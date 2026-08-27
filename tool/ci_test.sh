#!/usr/bin/env bash
# CI unit/widget tests only — no golden or store-screenshot pixel tests.
set -euo pipefail

cd "$(dirname "$0")/.."

flutter test \
  --exclude-tags golden \
  --exclude-tags store-screenshot \
  test/core \
  test/features/batch \
  test/features/home \
  test/features/insights \
  test/features/onboarding \
  test/features/shared \
  test/features/streak \
  test/features/swipe \
  test/features/trash
