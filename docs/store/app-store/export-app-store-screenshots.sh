#!/usr/bin/env bash
# Exports App Store screenshots with large captions (ASO frames) from iOS source captures.
# iPhone 6.9" portrait: 1290×2796. iPhone 6.5" portrait: 1284×2778. iPad 13" portrait: 2064×2752.
# Run from repo root: bash docs/store/app-store/export-app-store-screenshots.sh

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(cd "$SCRIPT_DIR/../../.." && pwd)"
IOS_SRC="$REPO_ROOT/docs/store/app-store/screenshots/source"
OUT_IPHONE69="$SCRIPT_DIR/screenshots/iphone-6.9"
OUT_IPHONE65="$SCRIPT_DIR/screenshots/iphone-6.5"
OUT_IPAD="$SCRIPT_DIR/screenshots/ipad-13"

IPHONE69_W=1290
IPHONE69_H=2796
IPHONE65_W=1284
IPHONE65_H=2778
IPAD_W=2064
IPAD_H=2752

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

# path TAB basename TAB headline TAB subhead
# Max 10 App Store slots. First three are the story arc.
FRAMES=(
  "$IOS_SRC/01-home_dark.png	01-home	Invoices, expenses and time — one app	The freelance back office on your phone"
  "$IOS_SRC/06-new_invoice_dark.png	02-new-invoice	Speak a job. Get an invoice.	AI drafts the lines from voice or a photo"
  "$IOS_SRC/05-invoice_detail_dark.png	03-invoice-detail	Clients pay by card	Stripe on every invoice you send"
  "$IOS_SRC/03-expenses_dark.png	04-expenses	Snap a receipt. It is sorted.	AI categories, bank import, tax reports"
  "$IOS_SRC/04-task_report_dark.png	05-time	Bill every hour	Timers to invoice in one tap"
  "$IOS_SRC/08-recurring_dark.png	06-recurring	Retainers on a schedule	Send the same invoice every month"
  "$IOS_SRC/09-clients_dark.png	07-clients	Every client in one place	Rates, projects, and what they owe"
  "$IOS_SRC/02-invoices_dark.png	08-invoices	See sent, viewed, and paid	Outstanding and overdue at a glance"
  "TRUST	09-trust	Made for freelancers, consultants, and small studios	Invoices, expenses, and time — without spreadsheet chaos"
  "$IOS_SRC/07-client_details_dark.png	10-client-details	Bill the same client in two taps	History, unbilled time, and contact details"
)

for entry in "${FRAMES[@]}"; do
  IFS=$'\t' read -r path _base _h _s <<<"$entry"
  if [[ "$path" != "TRUST" && ! -f "$path" ]]; then
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
    "$tmp/sub.png" -gravity north -geometry "+0+$((top + head_h + out_h * 3 / 100))" -composite \
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
  local dest="$out_dir/${base}.png"
  if [[ "$path" == "TRUST" ]]; then
    compose_trust "$dest" "$w" "$h" "$headline" "$sub"
  else
    compose_captioned "$path" "$dest" "$w" "$h" "$headline" "$sub"
  fi
}

for entry in "${FRAMES[@]}"; do
  IFS=$'\t' read -r path base headline sub <<<"$entry"
  export_one "$path" "$base" "$headline" "$sub" "$OUT_IPHONE69" "$IPHONE69_W" "$IPHONE69_H"
  export_one "$path" "$base" "$headline" "$sub" "$OUT_IPHONE65" "$IPHONE65_W" "$IPHONE65_H"
  export_one "$path" "$base" "$headline" "$sub" "$OUT_IPAD" "$IPAD_W" "$IPAD_H"
done

echo "Wrote ${#FRAMES[@]} captioned shots × 3 targets:"
echo "  iPhone 6.9\" portrait: ${IPHONE69_W}×${IPHONE69_H} → $OUT_IPHONE69"
echo "  iPhone 6.5\" portrait: ${IPHONE65_W}×${IPHONE65_H} → $OUT_IPHONE65"
echo "  iPad 13\" portrait:    ${IPAD_W}×${IPAD_H} → $OUT_IPAD"
echo
for p in "$OUT_IPHONE69"/*.png; do
  [[ -f "$p" ]] || continue
  sz=$(wc -c <"$p" | tr -d ' ')
  b=$(basename "$p")
  sz65=$(wc -c <"$OUT_IPHONE65/$b" | tr -d ' ')
  echo "  $b — 6.9: $((sz / 1024)) KB, 6.5: $((sz65 / 1024)) KB"
done
