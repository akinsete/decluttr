#!/usr/bin/env ruby
# frozen_string_literal: true

require "json"
require "jwt"
require "net/http"
require "openssl"
require "uri"

key_id = ENV.fetch("APP_STORE_CONNECT_KEY_IDENTIFIER")
issuer_id = ENV.fetch("APP_STORE_ISSUER_ID") { ENV.fetch("APP_STORE_CONNECT_ISSUER_ID") }
key_b64 = ENV.fetch("APP_STORE_CONNECT_API_KEY_BASE64")
bundle_id = "com.ffslabs.decluttr"

p8 = Base64.decode64(key_b64)
private_key = OpenSSL::PKey::EC.new(p8)

def build_token(private_key, issuer_id, key_id)
  payload = {
    iss: issuer_id,
    iat: Time.now.to_i,
    exp: Time.now.to_i + 1200,
    aud: "appstoreconnect-v1"
  }
  JWT.encode(payload, private_key, "ES256", kid: key_id)
end

def asc_request(token, method, path, body = nil)
  uri = URI("https://api.appstoreconnect.apple.com#{path}")
  http = Net::HTTP.new(uri.host, uri.port)
  http.use_ssl = true
  klass = { get: Net::HTTP::Get, post: Net::HTTP::Post }.fetch(method)
  req = klass.new(uri)
  req["Authorization"] = "Bearer #{token}"
  req["Content-Type"] = "application/json"
  req.body = body.to_json if body
  res = http.request(req)
  parsed = res.body.to_s.strip.empty? ? {} : JSON.parse(res.body)
  [res.code.to_i, parsed]
end

token = build_token(private_key, issuer_id, key_id)

status, payload = asc_request(token, :get, "/v1/bundleIds?filter[identifier]=#{bundle_id}")
existing = payload.dig("data", 0)
if existing
  puts "Bundle ID already exists: #{bundle_id} (#{existing['id']})"
else
  status, payload = asc_request(
    token,
    :post,
    "/v1/bundleIds",
    {
      data: {
        type: "bundleIds",
        attributes: {
          identifier: bundle_id,
          name: "Decluttr",
          platform: "IOS"
        }
      }
    }
  )
  raise "Failed to create bundle ID (#{status}): #{payload}" unless status.between?(200, 299)

  puts "Created bundle ID: #{bundle_id} (#{payload.dig('data', 'id')})"
end

status, payload = asc_request(token, :get, "/v1/apps?filter[bundleId]=#{bundle_id}")
app = payload.dig("data", 0)
if app
  puts "App Store Connect app already exists: #{bundle_id} (apple id #{app['id']})"
else
  status, payload = asc_request(
    token,
    :post,
    "/v1/apps",
    {
      data: {
        type: "apps",
        attributes: {
          bundleId: bundle_id,
          name: "Decluttr",
          primaryLocale: "en-US",
          sku: "decluttr-ios"
        }
      }
    }
  )
  raise "Failed to create App Store Connect app (#{status}): #{payload}" unless status.between?(200, 299)

  puts "Created App Store Connect app: #{bundle_id} (apple id #{payload.dig('data', 'id')})"
end

puts "OK: #{bundle_id} is ready for Codemagic iOS signing."
