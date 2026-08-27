# Store assets (Google Play + App Store)

Decluttr listing copy, screenshot pipeline, and Fastlane upload notes (mirrors Invoicefinito).

| Store | Docs |
|-------|------|
| Google Play | [`google-play/README.md`](google-play/README.md) |
| App Store | [`app-store/README.md`](app-store/README.md) |

**CI:** Codemagic **Release — Decluttr** stages listing via `prepare-supply.sh` / `prepare-deliver.sh`, then Fastlane `supply` / `deliver` (see [`mobile/codemagic.yaml`](../mobile/codemagic.yaml)). Git root is `mobile/`; from CI cwd run `bash ../docs/store/...`.

## Generate screenshots

From the **workspace root** (`decluttr/`):

```bash
bash docs/store/generate-mobile-screenshots.sh
```

Requires FVM + (for export) ImageMagick 7 (`magick`).

## Layout

- Listing text: `google-play/*.txt`, `app-store/*.txt` (+ `locales/es|fr`)
- Sources: `*/screenshots/source/`
- Exported upload sizes: `google-play/screenshots/phone|tablet-*`, `app-store/screenshots/iphone-*|ipad-*`
- Fastlane stage targets: `mobile/android/fastlane/metadata`, `mobile/ios/fastlane/metadata|screenshots` (gitignored)

## Skip flags (Codemagic env)

- `SKIP_PLAY_LISTING_UPLOAD` / `SKIP_PLAY_SCREENSHOT_UPLOAD`
- `SKIP_LISTING_UPLOAD` / `SKIP_SCREENSHOT_UPLOAD` / `SKIP_STORE_EXTRAS`
