# Codemagic — Decluttr

Git repository root is this Flutter app directory. `codemagic.yaml` lives here alongside `pubspec.yaml`.

## One-time Codemagic UI setup

### Android code signing
1. Team settings → Code signing identities → Android
2. Upload keystore; note the reference name (default placeholder: `YOUR_DECLUTTR_android_keystore`)

### Environment variable groups

**Group: `google_credentials`**
- `GOOGLE_PLAY_SERVICE_ACCOUNT_CREDENTIALS` — full JSON body of Play Console service account key

**Group: `mobile_env_files`**
- `MOBILE_ENV_PRODUCTION` — full contents of `env/.env.production`
- `MOBILE_ENV_DEVELOPMENT` — full contents of `env/.env.development`

### App Store Connect
1. Team integrations → Developer Portal → add App Store Connect API key
2. Use the same integration name as `integrations.app_store_connect` in `codemagic.yaml` (default: `appstore-connect-key`)

### Firebase native configs (before first release build)
- `android/app/google-services.json`
- `ios/Runner/GoogleService-Info.plist`
- Register bundle ID `com.ffslabs.decluttr` in Firebase Console (dev + prod projects)

### iOS bundle identifier
- `com.ffslabs.decluttr` — must match Xcode, Firebase, and `codemagic.yaml` → `ios_signing.bundle_identifier`

## Local verification before CI

```bash
make setup-env   # create .env files from examples
fvm flutter pub get
fvm dart run build_runner build --delete-conflicting-outputs
fvm flutter gen-l10n
fvm dart analyze lib test
fvm flutter test
```

## Workflow

The `release` workflow builds Android APK/AAB + iOS IPA, runs analyze + test, and publishes to Google Play (internal/draft) and TestFlight.
