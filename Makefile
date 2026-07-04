.PHONY: setup-env generate_intl build_runner pub_get analyze test

setup-env:
	@test -f env/.env.production || cp env/.env.production.example env/.env.production
	@test -f env/.env.development || cp env/.env.development.example env/.env.development
	@echo "Created env files if missing. Fill Firebase keys before release builds."

generate_intl:
	fvm flutter gen-l10n

build_runner:
	fvm dart run build_runner build --delete-conflicting-outputs

pub_get:
	fvm flutter pub get

analyze:
	fvm flutter analyze

test:
	fvm flutter test
