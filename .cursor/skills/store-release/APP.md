# Decluttr — store release

This app uses the shared **[ffslabs-flutter-store-release](/Users/sundayakinsete/456Labs/.cursor/skills/ffslabs-flutter-store-release/SKILL.md)** skill.

Canonical path: `456Labs/.cursor/skills/ffslabs-flutter-store-release/`

## Config

- **Parameters:** [`store-release.config.yaml`](../../store-release.config.yaml) (repo root)
- **Codemagic:** [`codemagic.yaml`](../../codemagic.yaml)
- **Listing:** [`docs/store/`](../../docs/store/README.md)
- **Setup notes:** [`docs/codemagic-setup.md`](../../docs/codemagic-setup.md)

## App identifiers

| | Value |
|---|-------|
| Bundle / package | `com.ffslabs.decluttr` |
| Play GCP project | `decluttr-becd5` |
| Play service account | `firebase-adminsdk-fbsvc@decluttr-becd5.iam.gserviceaccount.com` |

## Codemagic signing refs

- Android keystore: `decluttr-keystore`
- iOS cert: `decluttr-distribution`
- iOS profile: `decluttr-appstore`

## Local commands

```bash
bash tool/ci_test.sh
bash docs/store/google-play/prepare-supply.sh
bash docs/store/app-store/prepare-deliver.sh
```

## Secrets

See skill [secrets.md](/Users/sundayakinsete/456Labs/.cursor/skills/ffslabs-flutter-store-release/secrets.md). Never commit `play-service-account.json` or keystore files.
