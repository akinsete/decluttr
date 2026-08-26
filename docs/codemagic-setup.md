# Codemagic setup (Decluttr)

Git / Flutter root: **`mobile/`** (this folder’s parent workspace holds `docs/store/`).

Workflow file: [`codemagic.yaml`](../codemagic.yaml) — **Release — Decluttr**.

## One-time Codemagic UI

1. **Android keystore** — Team → Code signing → Android. Replace `YOUR_DECLUTTR_android_keystore` in `codemagic.yaml` with the reference name.
2. **Env group `google_credentials`** — `GOOGLE_PLAY_SERVICE_ACCOUNT_CREDENTIALS` = Play service account JSON.
3. **Env group `mobile_env_files`** — `MOBILE_ENV_PRODUCTION` / `MOBILE_ENV_DEVELOPMENT` (full `.env` file bodies).
4. **Env group `appstore_credentials`** (if needed for Fastlane deliver):
   - `APP_STORE_CONNECT_KEY_IDENTIFIER`
   - `APP_STORE_CONNECT_ISSUER_ID`
   - `APP_STORE_CONNECT_API_KEY_BASE64`
5. **Integration** — App Store Connect API key named `appstore-connect-key`.
6. Optional vars: `ASC_APPLE_ID`, skip flags (`SKIP_*_LISTING_UPLOAD`, etc.).

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
