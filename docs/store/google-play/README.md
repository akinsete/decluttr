# Google Play listing (Decluttr)

Package: `com.ffslabs.decluttr`

## Local stage + upload

```bash
# From workspace root after screenshots exist:
bash docs/store/google-play/prepare-supply.sh
cd mobile/android && bundle install && bundle exec fastlane supply_listing
```

Codemagic runs the same after the AAB build unless `SKIP_PLAY_LISTING_UPLOAD=true`.

## Copy

Edit `title.txt`, `short-description.txt`, `full-description.txt` (and `locales/`).

See [`data-safety.md`](data-safety.md) before production.
