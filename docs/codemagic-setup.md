# Codemagic setup (Decluttr)

Git / Flutter root: **`mobile/`** (this folder’s parent workspace holds `docs/store/`).

Workflow file: [`codemagic.yaml`](../codemagic.yaml) — **Release — Decluttr**.

## One-time Codemagic UI

1. **Android keystore** — Team → Code signing → Android:
   - Reference name: **`decluttr-keystore`** (must match `codemagic.yaml`)
   - Upload `mobile/android/keystore/decluttr-upload.keystore` (generate with `bash tool/generate-android-upload-keystore.sh` from `mobile/`)
   - Alias: `decluttr-upload`; passwords in `android/keystore/decluttr-upload.credentials` (gitignored)
   - Register SHA-1/SHA-256 in Play Console — see [`../../docs/android-signing-fingerprints.md`](../../docs/android-signing-fingerprints.md)
2. **iOS App Store signing** — one-time:
   - **Option A (automated):** Copy Codemagic `appstore_credentials` into `ios/fastlane/.env.asc` (see `.env.asc.example`), then run `bash tool/setup-ios-app-store.sh` from `mobile/`. This registers `com.ffslabs.decluttr` in Developer Portal + App Store Connect.
   - **Option B (manual):** [Apple Developer Identifiers](https://developer.apple.com/account/resources/identifiers/list) → create App ID `com.ffslabs.decluttr`; [App Store Connect](https://appstoreconnect.apple.com/apps) → New App.
   - **Codemagic:** Team integrations → **Developer Portal** → add the same App Store Connect API key (`appstore-connect-key`). Team settings → Code signing identities → **iOS** → ensure an **Apple Distribution** certificate exists (generate or fetch). The release workflow runs `app-store-connect fetch-signing-files … --create` before `xcode-project use-profiles`; you can also fetch an App Store profile manually under **iOS provisioning profiles**.
   - `codemagic.yaml` already sets `ios_signing.distribution_type: app_store` and `bundle_identifier: com.ffslabs.decluttr`.
3. **Env group `google_credentials`** — `GOOGLE_PLAY_SERVICE_ACCOUNT_CREDENTIALS` = Play service account JSON.
4. **Env group `mobile_env_files`** — `MOBILE_ENV_PRODUCTION` / `MOBILE_ENV_DEVELOPMENT` (full `.env` file bodies).
5. **Env group `appstore_credentials`** (if needed for Fastlane deliver):
   - `APP_STORE_CONNECT_KEY_IDENTIFIER`
   - `APP_STORE_CONNECT_ISSUER_ID`
   - `APP_STORE_CONNECT_API_KEY_BASE64`
6. **Integration** — App Store Connect API key named `appstore-connect-key`.
7. Optional vars: `ASC_APPLE_ID`, skip flags (`SKIP_*_LISTING_UPLOAD`, etc.).

## Listing automation

See [`../../docs/store/README.md`](../../docs/store/README.md). Screenshots: `bash docs/store/generate-mobile-screenshots.sh` from the workspace root.

## Fingerprints

[`../../docs/android-signing-fingerprints.md`](../../docs/android-signing-fingerprints.md)

## Local verify

```bash
cd mobile
fvm flutter analyze
fvm flutter test
```
