#!/usr/bin/env bash
# Registers com.ffslabs.decluttr in Apple Developer + App Store Connect via Fastlane produce.
# Requires App Store Connect API key (same vars as Codemagic appstore_credentials group).
set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
ASC_ENV="${ROOT}/ios/fastlane/.env.asc"

if [[ -f "${ASC_ENV}" ]]; then
  # shellcheck disable=SC1090
  set -a
  source "${ASC_ENV}"
  set +a
fi

: "${APP_STORE_CONNECT_KEY_IDENTIFIER:?Set APP_STORE_CONNECT_KEY_IDENTIFIER (Codemagic appstore_credentials)}"
: "${APP_STORE_CONNECT_ISSUER_ID:?Set APP_STORE_CONNECT_ISSUER_ID}"
: "${APP_STORE_CONNECT_API_KEY_BASE64:?Set APP_STORE_CONNECT_API_KEY_BASE64 (base64 of .p8)}"

cd "${ROOT}/ios"
gem install bundler --no-document
bundle config set --local path 'vendor/bundle'
bundle install
bundle exec fastlane setup_app_store
