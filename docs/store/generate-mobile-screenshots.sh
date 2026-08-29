#!/usr/bin/env bash
# Generates Google Play + App Store source PNGs from Flutter store tests, then exports sizes.
# Run from Decluttr workspace root: bash docs/store/generate-mobile-screenshots.sh

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(cd "$SCRIPT_DIR/../.." && pwd)"
PLAY_SRC="$REPO_ROOT/docs/store/google-play/screenshots/source"
APP_SRC="$REPO_ROOT/docs/store/app-store/screenshots/source"
PLAY_GOLDENS="$REPO_ROOT/test/store/goldens/google-play"
APP_GOLDENS="$REPO_ROOT/test/store/goldens/app-store"

mkdir -p "$PLAY_SRC" "$APP_SRC" "$PLAY_GOLDENS" "$APP_GOLDENS"

echo "Running Flutter store-screenshot tests ..."
cd "$REPO_ROOT"
fvm flutter test test/store/store_screenshots_test.dart --tags store-screenshot --update-goldens

echo "Copying goldens to docs/store sources ..."
rm -f "$PLAY_SRC"/*.png "$APP_SRC"/*.png
cp -f "$PLAY_GOLDENS"/*.png "$PLAY_SRC"/
cp -f "$APP_GOLDENS"/*.png "$APP_SRC"/

if command -v magick >/dev/null 2>&1; then
  echo "Exporting Google Play sizes ..."
  bash "$REPO_ROOT/docs/store/google-play/export-play-screenshots.sh"
  echo "Exporting App Store sizes ..."
  bash "$REPO_ROOT/docs/store/app-store/export-app-store-screenshots.sh"
else
  echo "ImageMagick (magick) not found — skipped size export. Install to run export-*.sh"
fi

echo "Done."
