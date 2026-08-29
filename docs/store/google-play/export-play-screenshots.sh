#!/usr/bin/env bash
# Exports Google Play captioned screenshots (ASO frames, max 8 phone slots).
# Phone / 7" tablet: 1080×1920. 10" tablet: 1440×2560.
# Run from repo root: bash docs/store/google-play/export-play-screenshots.sh

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(cd "$SCRIPT_DIR/../../.." && pwd)"
SRC_DIR="$SCRIPT_DIR/screenshots/source"
OUT_PHONE="$SCRIPT_DIR/screenshots/phone"
OUT_T7="$SCRIPT_DIR/screenshots/tablet-7"
OUT_T10="$SCRIPT_DIR/screenshots/tablet-10"

PHONE_W=1080
PHONE_H=1920
T10_W=1440
T10_H=2560

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

# path TAB basename TAB headline TAB subhead
FRAMES=(
  "$SRC_DIR/01-splash_light.png	01-splash	Decluttr	Clear contacts and photos in minutes"
  "$SRC_DIR/02-home_light.png	02-home	Your declutter dashboard	Streaks, progress, and what is left to sort"
  "$SRC_DIR/03-trash_light.png	03-trash	Deleted photos, recoverable	Recover anything for 30 days"
  "$SRC_DIR/04-photos_light.png	04-photos	Browse by month	Pick a batch and swipe keep or delete"
)

for entry in "${FRAMES[@]}"; do
  IFS=$'\t' read -r path _base _h _s <<<"$entry"
  if [[ ! -f "$path" ]]; then
    echo "Missing source: $path" >&2
    exit 1
  fi
done

mkdir -p "$OUT_PHONE" "$OUT_T7" "$OUT_T10"
rm -f "$OUT_PHONE"/*.png "$OUT_T7"/*.png "$OUT_T10"/*.png

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

for entry in "${FRAMES[@]}"; do
  IFS=$'\t' read -r path base headline sub <<<"$entry"
  compose_captioned "$path" "$OUT_PHONE/${base}.png" "$PHONE_W" "$PHONE_H" "$headline" "$sub"
  cp "$OUT_PHONE/${base}.png" "$OUT_T7/${base}.png"
  compose_captioned "$path" "$OUT_T10/${base}.png" "$T10_W" "$T10_H" "$headline" "$sub"
  echo "  wrote ${base}.png"
done

echo "Wrote ${#FRAMES[@]} captioned shots × 3 targets:"
echo "  Phone + 7\" tablet: ${PHONE_W}×${PHONE_H} → $OUT_PHONE, $OUT_T7"
echo "  10\" tablet:         ${T10_W}×${T10_H} → $OUT_T10"
