import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../di/providers.dart';
import 'decluttr_app_environment.dart';
import 'decluttr_environment_storage.dart';

final decluttrAppEnvironmentProvider = Provider<DecluttrAppEnvironment>((ref) {
  final storage = ref.watch(environmentStorageProvider);
  return storage.read();
});

final environmentStorageProvider = Provider<DecluttrEnvironmentStorage>((ref) {
  final prefs = ref.watch(sharedPreferencesProvider);
  return DecluttrEnvironmentStorage(prefs);
});
