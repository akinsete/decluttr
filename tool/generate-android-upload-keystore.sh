#!/usr/bin/env bash
# Generates the Decluttr Play upload keystore (local only — never commit).
# Upload the .keystore + credentials to Codemagic → Code signing → Android.
set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
OUT_DIR="${ROOT}/android/keystore"
KEYSTORE="${OUT_DIR}/decluttr-upload.keystore"
CREDS="${OUT_DIR}/decluttr-upload.credentials"
REFERENCE_NAME="decluttr_android_keystore"
ALIAS="decluttr-upload"
VALIDITY_DAYS=10000

mkdir -p "${OUT_DIR}"

if [[ -f "${KEYSTORE}" ]]; then
  echo "Keystore already exists: ${KEYSTORE}"
  echo "Delete it first if you need a new one."
  exit 1
fi

STORE_PASS="$(openssl rand -base64 24 | tr -d '/+=' | head -c 24)"
KEY_PASS="${STORE_PASS}"

keytool -genkeypair -v \
  -keystore "${KEYSTORE}" \
  -alias "${ALIAS}" \
  -keyalg RSA \
  -keysize 2048 \
  -validity "${VALIDITY_DAYS}" \
  -storepass "${STORE_PASS}" \
  -keypass "${KEY_PASS}" \
  -dname "CN=FFS Labs Decluttr, OU=Mobile, O=FFS Labs, C=US"

cat > "${CREDS}" <<EOF
# Decluttr Android upload keystore — KEEP SECRET (gitignored)
# Codemagic reference name: ${REFERENCE_NAME}
keystore_file=${KEYSTORE}
keystore_password=${STORE_PASS}
key_alias=${ALIAS}
key_password=${KEY_PASS}
EOF
chmod 600 "${CREDS}"

echo ""
echo "Created:"
echo "  Keystore:     ${KEYSTORE}"
echo "  Credentials:  ${CREDS}"
echo ""
echo "Codemagic upload (Team → Code signing → Android):"
echo "  Reference name: ${REFERENCE_NAME}"
echo "  Keystore file:  decluttr-upload.keystore"
echo "  Key alias:      ${ALIAS}"
echo "  Passwords:      see ${CREDS}"
echo ""
echo "Fingerprints (register in Play Console → App integrity):"
keytool -list -v \
  -keystore "${KEYSTORE}" \
  -alias "${ALIAS}" \
  -storepass "${STORE_PASS}" \
  | awk '/SHA1:|SHA256:/ { print }'
