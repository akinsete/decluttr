#!/usr/bin/env bash
# Exports App Store screenshots with captions from iOS source captures.
# iPhone 6.9" portrait: 1290×2796. iPhone 6.5" portrait: 1284×2778. iPad 13" portrait: 2064×2752.
# Run from repo root: bash docs/store/app-store/export-app-store-screenshots.sh

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(cd "$SCRIPT_DIR/../../.." && pwd)"
IOS_SRC="$SCRIPT_DIR/screenshots/source"
OUT_IPHONE69="$SCRIPT_DIR/screenshots/iphone-6.9"
OUT_IPHONE65="$SCRIPT_DIR/screenshots/iphone-6.5"
OUT_IPAD="$SCRIPT_DIR/screenshots/ipad-13"

IPHONE69_W=1290
IPHONE69_H=2796
IPHONE65_W=1284
IPHONE65_H=2778
IPAD_W=2064
IPAD_H=2752

# Decluttr cream canvas + ink (not the old green InvoiceFinito frame).
BG='#FBF6ED'
HEAD_FILL='#1A1A1A'
SUB_FILL='#6E6E73'
FONT_HEAD="$REPO_ROOT/assets/google_fonts/PlusJakartaSans-SemiBold.ttf"
FONT_SUB="$REPO_ROOT/assets/google_fonts/PlusJakartaSans-Regular.ttf"

if ! command -v magick >/dev/null 2>&1; then
  echo "ImageMagick 7 (magick) is required." >&2
  exit 1
fi
if [[ ! -f "$FONT_HEAD" || ! -f "$FONT_SUB" ]]; then
  echo "Missing Plus Jakarta Sans under assets/google_fonts/." >&2
  exit 1
fi

FRAMES=(
  "$IOS_SRC/01-splash_light.png	01-splash	Decluttr	Clear contacts and photos in minutes"
  "$IOS_SRC/02-home_light.png	02-home	Your declutter dashboard	Streaks, progress, and what is left to sort"
  "$IOS_SRC/03-trash_light.png	03-trash	Deleted photos, recoverable	Recover anything for 30 days"
  "$IOS_SRC/04-photos_light.png	04-photos	Browse by month	Pick a batch and swipe keep or delete"
)

for entry in "${FRAMES[@]}"; do
  IFS=$'\t' read -r path _base _h _s <<<"$entry"
  if [[ ! -f "$path" ]]; then
    echo "Missing source: $path" >&2
    exit 1
  fi
done

mkdir -p "$OUT_IPHONE69" "$OUT_IPHONE65" "$OUT_IPAD"
rm -f "$OUT_IPHONE69"/*.png "$OUT_IPHONE65"/*.png "$OUT_IPAD"/*.png

compose_captioned() {
  local src="$1"
  local out="$2"
  local out_w="$3"
  local out_h="$4"
  local headline="$5"
  local sub="$6"

  local pad=$((out_w * 8 / 100))
  local text_w=$((out_w - pad * 2))
  local head_h=$((out_h * 14 / 100))
  local sub_h=$((out_h * 7 / 100))
  local gap=$((out_h * 1 / 100))
  local top=$((out_h * 6 / 100))
  local phone_top=$((top + head_h + gap + sub_h + gap))
  local phone_h=$((out_h - phone_top - pad))
  local phone_w=$((out_w - pad * 2))

  local tmp
  tmp="$(mktemp -d)"
  magick -size "${text_w}x${head_h}" -background none -fill "$HEAD_FILL" \
    -font "$FONT_HEAD" -gravity center caption:"$headline" \
    "$tmp/head.png"
  magick -size "${text_w}x${sub_h}" -background none -fill "$SUB_FILL" \
    -font "$FONT_SUB" -gravity north caption:"$sub" \
    "$tmp/sub.png"
  magick "$src" -resize "${phone_w}x${phone_h}" "$tmp/phone.png"

  magick -size "${out_w}x${out_h}" "xc:${BG}" \
    "$tmp/head.png" -gravity north -geometry "+0+${top}" -composite \
    "$tmp/sub.png" -gravity north -geometry "+0+$((top + head_h + gap))" -composite \
    "$tmp/phone.png" -gravity north -geometry "+0+${phone_top}" -composite \
    -alpha remove -alpha off -type TrueColor -depth 8 \
    "$out"
  rm -rf "$tmp"
}

export_one() {
  local path="$1"
  local base="$2"
  local headline="$3"
  local sub="$4"
  local out_dir="$5"
  local w="$6"
  local h="$7"
  compose_captioned "$path" "$out_dir/${base}.png" "$w" "$h" "$headline" "$sub"
}

for entry in "${FRAMES[@]}"; do
  IFS=$'\t' read -r path base headline sub <<<"$entry"
  export_one "$path" "$base" "$headline" "$sub" "$OUT_IPHONE69" "$IPHONE69_W" "$IPHONE69_H"
  export_one "$path" "$base" "$headline" "$sub" "$OUT_IPHONE65" "$IPHONE65_W" "$IPHONE65_H"
  export_one "$path" "$base" "$headline" "$sub" "$OUT_IPAD" "$IPAD_W" "$IPAD_H"
  echo "  wrote ${base}.png"
done

echo "Wrote ${#FRAMES[@]} captioned shots × 3 targets:"
echo "  iPhone 6.9\" portrait: ${IPHONE69_W}×${IPHONE69_H} → $OUT_IPHONE69"
echo "  iPhone 6.5\" portrait: ${IPHONE65_W}×${IPHONE65_H} → $OUT_IPHONE65"
echo "  iPad 13\" portrait:    ${IPAD_W}×${IPAD_H} → $OUT_IPAD"
