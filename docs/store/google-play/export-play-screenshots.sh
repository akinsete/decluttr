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

BG='#0B1F17'
HEAD_FILL='#F4F7F5'
SUB_FILL='#A8C4B5'
FONT_HEAD="$REPO_ROOT/assets/google_fonts/Geist-SemiBold.ttf"
FONT_SUB="$REPO_ROOT/assets/google_fonts/Geist-Regular.ttf"

if ! command -v magick >/dev/null 2>&1; then
  echo "ImageMagick 7 (magick) is required." >&2
  exit 1
fi
if [[ ! -f "$FONT_HEAD" || ! -f "$FONT_SUB" ]]; then
  echo "Missing Geist fonts under assets/google_fonts/." >&2
  exit 1
fi

# Play allows up to 8 phone screenshots. Same story arc as App Store (minus 2 frames).
# path TAB basename TAB headline TAB subhead
FRAMES=(
  "$SRC_DIR/01-home_dark.png	01-home	Invoices, expenses and time — one app	The freelance back office on your phone"
  "$SRC_DIR/06-new_invoice_dark.png	02-new-invoice	Speak a job. Get an invoice.	AI drafts the lines from voice or a photo"
  "$SRC_DIR/05-invoice_detail_dark.png	03-invoice-detail	Clients pay by card	Stripe on every invoice you send"
  "$SRC_DIR/03-expenses_dark.png	04-expenses	Snap a receipt. It is sorted.	AI categories, bank import, tax reports"
  "$SRC_DIR/04-task_report_dark.png	05-time	Bill every hour	Timers to invoice in one tap"
  "$SRC_DIR/08-recurring_dark.png	06-recurring	Retainers on a schedule	Send the same invoice every month"
  "$SRC_DIR/09-clients_dark.png	07-clients	Every client in one place	Rates, projects, and what they owe"
  "TRUST	08-trust	Made for freelancers, consultants, and small studios	Invoices, expenses, and time — without spreadsheet chaos"
)

for entry in "${FRAMES[@]}"; do
  IFS=$'\t' read -r path _base _h _s <<<"$entry"
  if [[ "$path" != "TRUST" && ! -f "$path" ]]; then
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
  local head_h=$((out_h * 16 / 100))
  local sub_h=$((out_h * 8 / 100))
  local gap=$((out_h * 1 / 100))
  local top=$((out_h * 7 / 100))
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

compose_trust() {
  local out="$1"
  local out_w="$2"
  local out_h="$3"
  local headline="$4"
  local sub="$5"

  local pad=$((out_w * 10 / 100))
  local text_w=$((out_w - pad * 2))
  local head_h=$((out_h * 28 / 100))
  local sub_h=$((out_h * 22 / 100))
  local top=$((out_h * 22 / 100))

  local tmp
  tmp="$(mktemp -d)"
  magick -size "${text_w}x${head_h}" -background none -fill "$HEAD_FILL" \
    -font "$FONT_HEAD" -gravity center caption:"$headline" \
    "$tmp/head.png"
  magick -size "${text_w}x${sub_h}" -background none -fill "$SUB_FILL" \
    -font "$FONT_SUB" -gravity north caption:"$sub" \
    "$tmp/sub.png"

  magick -size "${out_w}x${out_h}" "xc:${BG}" \
    "$tmp/head.png" -gravity north -geometry "+0+${top}" -composite \
    "$tmp/sub.png" -gravity north -geometry "+0+$((top + head_h))" -composite \
    -alpha remove -alpha off -type TrueColor -depth 8 \
    "$out"
  rm -rf "$tmp"
}

for entry in "${FRAMES[@]}"; do
  IFS=$'\t' read -r path base headline sub <<<"$entry"
  if [[ "$path" == "TRUST" ]]; then
    compose_trust "$OUT_PHONE/${base}.png" "$PHONE_W" "$PHONE_H" "$headline" "$sub"
    cp "$OUT_PHONE/${base}.png" "$OUT_T7/${base}.png"
    compose_trust "$OUT_T10/${base}.png" "$T10_W" "$T10_H" "$headline" "$sub"
  else
    compose_captioned "$path" "$OUT_PHONE/${base}.png" "$PHONE_W" "$PHONE_H" "$headline" "$sub"
    cp "$OUT_PHONE/${base}.png" "$OUT_T7/${base}.png"
    compose_captioned "$path" "$OUT_T10/${base}.png" "$T10_W" "$T10_H" "$headline" "$sub"
  fi
  echo "  wrote ${base}.png"
done

echo "Wrote ${#FRAMES[@]} captioned shots × 3 targets (Play max 8 phone):"
echo "  Phone + 7\" tablet: ${PHONE_W}×${PHONE_H} → $OUT_PHONE, $OUT_T7"
echo "  10\" tablet:         ${T10_W}×${T10_H} → $OUT_T10"
