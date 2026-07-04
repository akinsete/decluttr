# Decluttr

Swipe to clean up contacts and photos — Flutter app (`com.ffslabs.decluttr`).

This directory is the **git repository root** (`origin`: `https://github.com/akinsete/decluttr.git`).

## CI

- [`codemagic.yaml`](codemagic.yaml) — release workflow (TestFlight + Google Play internal)
- [`docs/codemagic-setup.md`](docs/codemagic-setup.md) — signing and secrets

## Getting started

```bash
fvm install
make setup-env    # copy env/*.example if missing — then fill Firebase keys
fvm flutter pub get
fvm dart run build_runner build --delete-conflicting-outputs
fvm flutter gen-l10n
fvm flutter run
```

**Tests:**

```bash
make test
fvm flutter test --update-goldens --tags golden
```

Architecture and feature docs live in the parent workspace at `../docs/`.
