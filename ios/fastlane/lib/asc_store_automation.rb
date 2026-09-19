# frozen_string_literal: true

require "json"
require "net/http"
require "openssl"
require "uri"
require "digest"
require "base64"
require "time"

# Thin App Store Connect REST client + sync helpers for:
# - Custom Product Pages (+ screenshots)
# - Subscription introductory offers
# - App Privacy nutrition labels (via Spaceship ConnectAPI when available)
#
# Auth: APP_STORE_CONNECT_KEY_IDENTIFIER / ISSUER_ID / APP_STORE_CONNECT_API_KEY_BASE64
# (same secrets as Fastlane deliver).

module AscStoreAutomation
  BASE = "https://api.appstoreconnect.apple.com"
  BUNDLE_ID = "com.ffslabs.decluttr"
  APPLE_ID = ENV.fetch("ASC_APPLE_ID", "0000000000")

  @jwt = nil
  @jwt_expires_at = nil

  module_function

  def repo_store_root
    # __dir__ is mobile/ios/fastlane/lib → four levels up to repo root.
    File.expand_path("../../../../docs/store/app-store", __dir__)
  end

  def private_key_b64
    key = ENV["APP_STORE_CONNECT_API_KEY_BASE64"] || ENV["APP_STORE_CONNECT_PRIVATE_KEY"]
    raise "Missing APP_STORE_CONNECT_API_KEY_BASE64" if key.to_s.strip.empty?
    key
  end

  def api_key_hash
    {
      key_id: ENV.fetch("APP_STORE_CONNECT_KEY_IDENTIFIER"),
      issuer_id: ENV.fetch("APP_STORE_CONNECT_ISSUER_ID"),
      key: private_key_b64,
      # Always expect base64 of the .p8 (avoids PEM newline mangling in CI).
      is_key_content_base64: true,
      duration: 1200,
      in_house: false
    }
  end

  def configure_spaceship_token!
    require "spaceship"
    key = api_key_hash[:key]
    key = Base64.decode64(key) if api_key_hash[:is_key_content_base64]
    token = Spaceship::ConnectAPI::Token.create(
      key_id: api_key_hash[:key_id],
      issuer_id: api_key_hash[:issuer_id],
      key: key,
      duration: api_key_hash[:duration],
      in_house: api_key_hash[:in_house]
    )
    Spaceship::ConnectAPI.token = token
    @jwt = token.text
    @jwt_expires_at = Time.now + (api_key_hash[:duration] - 60)
    token
  end

  def jwt
    if @jwt.nil? || @jwt_expires_at.nil? || Time.now >= @jwt_expires_at
      configure_spaceship_token!
    end
    @jwt
  end

  def request(method, path, body: nil, query: nil)
    uri = URI("#{BASE}#{path}")
    uri.query = URI.encode_www_form(query) if query && !query.empty?
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true
    http.read_timeout = 120
    http.open_timeout = 30

    req =
      case method
      when :get then Net::HTTP::Get.new(uri)
      when :post then Net::HTTP::Post.new(uri)
      when :patch then Net::HTTP::Patch.new(uri)
      when :delete then Net::HTTP::Delete.new(uri)
      else
        raise "Unsupported method #{method}"
      end
    req["Authorization"] = "Bearer #{jwt}"
    req["Content-Type"] = "application/json"
    req.body = JSON.generate(body) if body

    res = http.request(req)
    parsed = res.body.to_s.strip.empty? ? {} : JSON.parse(res.body)
    unless res.is_a?(Net::HTTPSuccess)
      detail = parsed.dig("errors") || parsed
      raise "ASC #{method.upcase} #{path} → #{res.code}: #{detail}"
    end
    parsed
  end

  def find_app_id
    data = request(:get, "/v1/apps", query: { "filter[bundleId]" => BUNDLE_ID, "limit" => 1 })
    id = data.dig("data", 0, "id")
    raise "App not found for #{BUNDLE_ID}" unless id
    id
  end

  # --- Content rights ---------------------------------------------------------

  def set_content_rights!(uses_third_party_content: false)
    app_id = find_app_id
    declaration =
      if uses_third_party_content
        "USES_THIRD_PARTY_CONTENT"
      else
        "DOES_NOT_USE_THIRD_PARTY_CONTENT"
      end
    UI_message("Setting contentRightsDeclaration=#{declaration}")
    request(
      :patch,
      "/v1/apps/#{app_id}",
      body: {
        data: {
          type: "apps",
          id: app_id,
          attributes: { contentRightsDeclaration: declaration }
        }
      }
    )
    UI_message("Content rights updated")
  end

  # --- Pricing (free via appPriceSchedules) ---------------------------------

  def set_free_price_schedule!(base_territory: "USA")
    app_id = find_app_id

    begin
      existing = request(
        :get,
        "/v1/apps/#{app_id}/appPriceSchedule",
        query: { "include" => "manualPrices,baseTerritory" }
      )
      if existing.dig("data", "id")
        UI_message("App price schedule already present (#{existing.dig('data', 'id')}) — skipping")
        return
      end
    rescue StandardError => e
      # 404 when no schedule exists yet — continue to create.
      raise unless e.message.include?("404")
      UI_message("No existing appPriceSchedule (404) — will create free schedule")
    end

    points = request(
      :get,
      "/v1/apps/#{app_id}/appPricePoints",
      query: {
        "filter[territory]" => base_territory,
        "limit" => 200
      }
    )
    free_point = (points["data"] || []).find do |row|
      row.dig("attributes", "customerPrice").to_f.zero?
    end
    raise "No free (customerPrice=0) appPricePoint for territory #{base_territory}" unless free_point

    UI_message("Creating free price schedule (base=#{base_territory}, point=#{free_point['id']})")
    body = {
      data: {
        type: "appPriceSchedules",
        relationships: {
          app: { data: { type: "apps", id: app_id } },
          baseTerritory: { data: { type: "territories", id: base_territory } },
          manualPrices: {
            data: [{ type: "appPrices", id: "${price-0}" }]
          }
        }
      },
      included: [
        {
          type: "appPrices",
          id: "${price-0}",
          attributes: { startDate: nil },
          relationships: {
            appPricePoint: {
              data: { type: "appPricePoints", id: free_point["id"] }
            }
          }
        }
      ]
    }
    request(:post, "/v1/appPriceSchedules", body: body)
    UI_message("Free price schedule created")
  end

  # --- Privacy ----------------------------------------------------------------

  def sync_privacy!(json_path: nil, skip_publish: false)
    path = json_path || File.join(repo_store_root, "app_privacy_details.json")
    raise "Missing App Privacy JSON: #{path}" unless File.file?(path)

    usages_config = JSON.parse(File.read(path))
    unless usages_config.is_a?(Array)
      raise "app_privacy_details.json must be an array of usage configs (got #{usages_config.class})"
    end

    app_id = find_app_id
    UI_message("Uploading App Privacy from #{path}")

    # Spaceship still calls the retired /apps/{id}/dataUsages path — use appDataUsages.
    existing = request(
      :get,
      "/v1/apps/#{app_id}/appDataUsages",
      query: {
        "include" => "category,purpose,dataProtection",
        "limit" => 200
      }
    )
    (existing["data"] || []).each do |usage|
      request(:delete, "/v1/appDataUsages/#{usage['id']}")
    end

    usages_config.each do |usage_config|
      category = usage_config["category"]
      purposes = usage_config["purposes"] || []
      data_protections = usage_config["data_protections"] || []
      purposes = [nil] if purposes.empty?

      purposes.each do |purpose|
        data_protections.each do |data_protection|
          relationships = {
            app: { data: { type: "apps", id: app_id } }
          }
          if category
            relationships[:category] = {
              data: { type: "appDataUsageCategories", id: category }
            }
          end
          if data_protection
            relationships[:dataProtection] = {
              data: { type: "appDataUsageDataProtections", id: data_protection }
            }
          end
          if purpose
            relationships[:purpose] = {
              data: { type: "appDataUsagePurposes", id: purpose }
            }
          end

          request(
            :post,
            "/v1/appDataUsages",
            body: {
              data: {
                type: "appDataUsages",
                relationships: relationships
              }
            }
          )
          UI_message("  set #{category || 'n/a'} / #{purpose || 'n/a'} → #{data_protection}")
        end
      end
    end

    unless skip_publish
      publish = request(:get, "/v1/apps/#{app_id}/appDataUsagesPublishState")
      state = publish["data"]
      if state.dig("attributes", "published")
        UI_message("App Privacy already published")
      else
        request(
          :patch,
          "/v1/appDataUsagesPublishState/#{state['id']}",
          body: {
            data: {
              type: "appDataUsagesPublishState",
              id: state["id"],
              attributes: { published: true }
            }
          }
        )
        UI_message("App Privacy published")
      end
    else
      UI_message("App Privacy uploaded (skip_publish=true — verify in App Store Connect)")
    end
  end

  # --- Intro offers -----------------------------------------------------------

  def sync_intro_offers!(json_path: nil)
    path = json_path || File.join(repo_store_root, "intro-offers.json")
    config = JSON.parse(File.read(path))
    app_id = find_app_id

    groups = request(:get, "/v1/apps/#{app_id}/subscriptionGroups", query: { "limit" => 50 })
    group_ids = (groups["data"] || []).map { |g| g["id"] }
    raise "No subscription groups on app" if group_ids.empty?

    subscriptions = []
    group_ids.each do |gid|
      page = request(
        :get,
        "/v1/subscriptionGroups/#{gid}/subscriptions",
        query: { "limit" => 50 }
      )
      subscriptions.concat(page["data"] || [])
    end

    by_product = {}
    subscriptions.each do |sub|
      pid = sub.dig("attributes", "productId")
      by_product[pid] = sub if pid
    end

    (config["offers"] || []).each do |offer|
      product_id = offer.fetch("product_id")
      sub = by_product[product_id]
      raise "Subscription not found for productId=#{product_id}" unless sub

      existing = request(
        :get,
        "/v1/subscriptions/#{sub['id']}/introductoryOffers",
        query: { "limit" => 50 }
      )
      already = (existing["data"] || []).any? do |row|
        attrs = row["attributes"] || {}
        attrs["offerMode"] == offer["offer_mode"] &&
          attrs["duration"] == offer["duration"] &&
          attrs["numberOfPeriods"].to_i == offer["number_of_periods"].to_i
      end
      if already
        UI_message("Intro offer already present for #{product_id}")
        next
      end

      body = {
        data: {
          type: "subscriptionIntroductoryOffers",
          attributes: {
            offerMode: offer["offer_mode"],
            duration: offer["duration"],
            numberOfPeriods: offer["number_of_periods"]
          },
          relationships: {
            subscription: {
              data: { type: "subscriptions", id: sub["id"] }
            }
          }
        }
      }
      request(:post, "/v1/subscriptionIntroductoryOffers", body: body)
      UI_message("Created #{offer['offer_mode']} #{offer['duration']} for #{product_id}")
    end
  end

  # --- Custom Product Pages ---------------------------------------------------

  def sync_custom_product_pages!(json_path: nil, submit_for_review: nil)
    path = json_path || File.join(repo_store_root, "custom-product-pages.json")
    config = JSON.parse(File.read(path))
    locale = config.fetch("locale", "en-US")
    display_type = config.fetch("screenshot_display_type", "APP_IPHONE_65")
    shot_dir = File.expand_path(config.fetch("screenshot_dir"), repo_store_root)
    submit = submit_for_review.nil? ? !!config["submit_for_review"] : !!submit_for_review
    submit = true if ENV["SUBMIT_CPP_FOR_REVIEW"] == "true"

    app_id = find_app_id
    template_version_id = pick_app_store_version_id(app_id)

    existing = request(
      :get,
      "/v1/apps/#{app_id}/appCustomProductPages",
      query: { "limit" => 50, "include" => "appCustomProductPageVersions" }
    )
    by_name = {}
    (existing["data"] || []).each do |page|
      by_name[page.dig("attributes", "name")] = page
    end

    (config["pages"] || []).each do |page_cfg|
      name = page_cfg.fetch("name")
      page = by_name[name]
      if page.nil?
        page = create_custom_product_page!(
          app_id: app_id,
          name: name,
          template_version_id: template_version_id
        )
        by_name[name] = page
        UI_message("Created CPP '#{name}' (#{page['id']})")
      else
        UI_message("Updating existing CPP '#{name}' (#{page['id']})")
      end

      version = editable_cpp_version(page["id"])
      localization = ensure_cpp_localization!(version_id: version["id"], locale: locale)
      update_cpp_promotional_text!(localization["id"], page_cfg["promotional_text"])
      replace_cpp_screenshots!(
        localization_id: localization["id"],
        display_type: display_type,
        filenames: page_cfg.fetch("screenshots"),
        shot_dir: shot_dir
      )

      if submit
        submit_cpp_version!(app_id: app_id, version_id: version["id"])
      end
    end
  end

  def pick_app_store_version_id(app_id)
    live = request(
      :get,
      "/v1/apps/#{app_id}/appStoreVersions",
      query: {
        "filter[appStoreState]" => "READY_FOR_SALE",
        "filter[platform]" => "IOS",
        "limit" => 1
      }
    )
    id = live.dig("data", 0, "id")
    return id if id

    any = request(
      :get,
      "/v1/apps/#{app_id}/appStoreVersions",
      query: { "filter[platform]" => "IOS", "limit" => 5, "sort" => "-createdDate" }
    )
    id = any.dig("data", 0, "id")
    raise "No iOS App Store version found to use as CPP template" unless id
    id
  end

  def create_custom_product_page!(app_id:, name:, template_version_id:)
    body = {
      data: {
        type: "appCustomProductPages",
        attributes: { name: name },
        relationships: {
          app: { data: { type: "apps", id: app_id } },
          appStoreVersionTemplate: {
            data: { type: "appStoreVersions", id: template_version_id }
          }
        }
      }
    }
    request(:post, "/v1/appCustomProductPages", body: body)["data"]
  end

  def editable_cpp_version(page_id)
    versions = request(
      :get,
      "/v1/appCustomProductPages/#{page_id}/appCustomProductPageVersions",
      query: { "limit" => 20 }
    )
    rows = versions["data"] || []
    editable = rows.find do |v|
      state = v.dig("attributes", "state").to_s
      %w[PREPARE_FOR_SUBMISSION READY_FOR_REVIEW REJECTED].include?(state)
    end
    return editable if editable

    # Approved/accepted pages need a new draft version before further edits.
    body = {
      data: {
        type: "appCustomProductPageVersions",
        relationships: {
          appCustomProductPage: {
            data: { type: "appCustomProductPages", id: page_id }
          }
        }
      }
    }
    begin
      return request(:post, "/v1/appCustomProductPageVersions", body: body)["data"]
    rescue StandardError => e
      UI_message("Could not create new CPP version (#{e.message}); using newest existing")
      rows.last || raise("No CPP versions for page #{page_id}")
    end
  end

  def ensure_cpp_localization!(version_id:, locale:)
    locs = request(
      :get,
      "/v1/appCustomProductPageVersions/#{version_id}/appCustomProductPageLocalizations",
      query: { "limit" => 50 }
    )
    found = (locs["data"] || []).find { |l| l.dig("attributes", "locale") == locale }
    return found if found

    body = {
      data: {
        type: "appCustomProductPageLocalizations",
        attributes: { locale: locale },
        relationships: {
          appCustomProductPageVersion: {
            data: { type: "appCustomProductPageVersions", id: version_id }
          }
        }
      }
    }
    request(:post, "/v1/appCustomProductPageLocalizations", body: body)["data"]
  end

  def update_cpp_promotional_text!(localization_id, text)
    return if text.to_s.strip.empty?

    body = {
      data: {
        type: "appCustomProductPageLocalizations",
        id: localization_id,
        attributes: { promotionalText: text }
      }
    }
    request(:patch, "/v1/appCustomProductPageLocalizations/#{localization_id}", body: body)
  end

  def replace_cpp_screenshots!(localization_id:, display_type:, filenames:, shot_dir:)
    sets = request(
      :get,
      "/v1/appCustomProductPageLocalizations/#{localization_id}/appScreenshotSets",
      query: { "limit" => 20, "include" => "appScreenshots" }
    )
    set = (sets["data"] || []).find { |s| s.dig("attributes", "screenshotDisplayType") == display_type }
    unless set
      body = {
        data: {
          type: "appScreenshotSets",
          attributes: { screenshotDisplayType: display_type },
          relationships: {
            appCustomProductPageLocalization: {
              data: { type: "appCustomProductPageLocalizations", id: localization_id }
            }
          }
        }
      }
      set = request(:post, "/v1/appScreenshotSets", body: body)["data"]
    end

    # Clear existing screenshots in the set.
    existing_shots = request(
      :get,
      "/v1/appScreenshotSets/#{set['id']}/appScreenshots",
      query: { "limit" => 50 }
    )
    (existing_shots["data"] || []).each do |shot|
      request(:delete, "/v1/appScreenshots/#{shot['id']}")
    end

    filenames.each_with_index do |name, index|
      path = File.join(shot_dir, name)
      raise "Missing screenshot #{path}" unless File.file?(path)
      upload_screenshot!(set_id: set["id"], path: path)
      UI_message("  uploaded [#{index + 1}] #{name}")
    end
  end

  def upload_screenshot!(set_id:, path:)
    configure_spaceship_token!
    Spaceship::ConnectAPI::AppScreenshot.create(
      app_screenshot_set_id: set_id,
      path: path,
      wait_for_processing: true
    )
  end

  def submit_cpp_version!(app_id:, version_id:)
    body = {
      data: {
        type: "reviewSubmissions",
        attributes: { platform: "IOS" },
        relationships: {
          app: { data: { type: "apps", id: app_id } }
        }
      }
    }
    submission = request(:post, "/v1/reviewSubmissions", body: body)["data"]
    item_body = {
      data: {
        type: "reviewSubmissionItems",
        relationships: {
          reviewSubmission: {
            data: { type: "reviewSubmissions", id: submission["id"] }
          },
          appCustomProductPageVersion: {
            data: { type: "appCustomProductPageVersions", id: version_id }
          }
        }
      }
    }
    begin
      request(:post, "/v1/reviewSubmissionItems", body: item_body)
      request(
        :patch,
        "/v1/reviewSubmissions/#{submission['id']}",
        body: {
          data: {
            type: "reviewSubmissions",
            id: submission["id"],
            attributes: { submitted: true }
          }
        }
      )
      UI_message("Submitted CPP version #{version_id} for review")
    rescue StandardError => e
      UI_message("CPP review submit skipped/failed: #{e.message}")
    end
  end

  def UI_message(msg)
    if defined?(FastlaneCore::UI)
      FastlaneCore::UI.message(msg)
    else
      puts(msg)
    end
  end
end
