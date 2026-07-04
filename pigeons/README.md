# Pigeon native APIs (Decluttr)

Use **Pigeon** for any app-owned platform channel — never hand-written MethodChannels.

## Current status

Contacts, photos, and permissions use community plugins:
- `flutter_contacts`
- `photo_manager`
- `permission_handler`

If a plugin gap appears (e.g. custom merge write-back, OS trash integration), define the API here and generate bindings:

```bash
cd mobile
fvm dart run pigeon --input pigeons/decluttr_native_api.dart
```

## Adding a new API

1. Create `pigeons/<feature>.dart` with `@HostApi()` / `@FlutterApi()` definitions
2. Run pigeon (see Makefile `build_runner` target)
3. Commit all generated Dart/Kotlin/Swift files
4. Add a thin gateway in `lib/core/native/` or feature `data/` layer

Reference: Invoicefinito `.cursor/rules/flutter-native-pigeon.mdc`
