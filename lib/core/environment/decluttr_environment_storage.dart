import 'package:shared_preferences/shared_preferences.dart';

import 'decluttr_app_environment.dart';

const _environmentKey = 'decluttr_app_environment';

class DecluttrEnvironmentStorage {
  DecluttrEnvironmentStorage(this._prefs);

  final SharedPreferences _prefs;

  DecluttrAppEnvironment read() {
    final raw = _prefs.getString(_environmentKey);
    return switch (raw) {
      'production' => DecluttrAppEnvironment.production,
      _ => DecluttrAppEnvironment.development,
    };
  }

  Future<void> write(DecluttrAppEnvironment environment) {
    return _prefs.setString(
      _environmentKey,
      environment.name,
    );
  }
}
