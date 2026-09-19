fastlane documentation
----

# Installation

Make sure you have the latest version of the Xcode command line tools installed:

```sh
xcode-select --install
```

For _fastlane_ installation instructions, see [Installing _fastlane_](https://docs.fastlane.tools/#installing-fastlane)

# Available Actions

## iOS

### ios setup_app_store

```sh
[bundle exec] fastlane ios setup_app_store
```

One-time: register bundle ID + create App Store Connect app

### ios deliver_listing

```sh
[bundle exec] fastlane ios deliver_listing
```

Upload App Store listing metadata (+ screenshots) via deliver

### ios deliver_metadata_only

```sh
[bundle exec] fastlane ios deliver_metadata_only
```

Metadata only (no screenshots)

### ios upload_privacy

```sh
[bundle exec] fastlane ios upload_privacy
```

App Privacy nutrition labels from docs/store/app-store/app_privacy_details.json

### ios prepare_first_submission

```sh
[bundle exec] fastlane ios prepare_first_submission
```

First-submit prep: content rights, free price, App Privacy

### ios sync_store_extras

```sh
[bundle exec] fastlane ios sync_store_extras
```

Privacy extras + content rights + free pricing (CPP / intro offers skipped unless JSON is Decluttr-ready)

----

This README.md is auto-generated and will be re-generated every time [_fastlane_](https://fastlane.tools) is run.

More information about _fastlane_ can be found on [fastlane.tools](https://fastlane.tools).

The documentation of _fastlane_ can be found on [docs.fastlane.tools](https://docs.fastlane.tools).
