import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'app/app.dart';
import 'core/di/providers.dart';
import 'core/environment/decluttr_app_environment.dart';
import 'core/firebase/decluttr_firebase_bootstrap.dart';
import 'core/firebase/decluttr_firebase_env_loader.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  GoogleFonts.config.allowRuntimeFetching = false;
  GoogleFonts.plusJakartaSansTextTheme();
  for (final weight in [
    FontWeight.w400,
    FontWeight.w500,
    FontWeight.w600,
    FontWeight.w700,
    FontWeight.w800,
  ]) {
    GoogleFonts.plusJakartaSans(fontWeight: weight);
  }
  await GoogleFonts.pendingFonts();

  const environment = DecluttrAppEnvironment.development;
  final env = await DecluttrFirebaseEnvLoader.load(environment);

  if (kDebugMode) {
    debugPrint(
      'Decluttr: backend=${environment.name} '
      'project=${env['FIREBASE_PROJECT_ID'] ?? '?'}',
    );
  }

  final firebaseReady = await DecluttrFirebaseBootstrap.initialize(env);
  if (firebaseReady) {
    await DecluttrFirebaseBootstrap.activateAppCheck(env);
  }

  final prefs = await SharedPreferences.getInstance();

  runApp(
    ProviderScope(
      overrides: [
        sharedPreferencesProvider.overrideWithValue(prefs),
      ],
      child: const DecluttrApp(),
    ),
  );
}
