# App Store listing (Decluttr)

Bundle ID: `com.ffslabs.decluttr`

Set `ASC_APPLE_ID` (numeric App Store Connect Apple ID) before deliver.

## Local stage + upload

```bash
bash docs/store/app-store/prepare-deliver.sh
cd mobile/ios && bundle install && bundle exec fastlane deliver_listing
```

Optional privacy: `bundle exec fastlane sync_store_extras` (uses [`app_privacy_details.json`](app_privacy_details.json) — replace stub before publishing).

Codemagic runs deliver after IPA unless `SKIP_LISTING_UPLOAD=true`.
