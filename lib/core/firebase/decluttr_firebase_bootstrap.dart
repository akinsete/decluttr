import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'decluttr_firebase_options_from_env.dart';

class DecluttrFirebaseBootstrap {
  static Future<bool> initialize(Map<String, String> env) async {
    final optionsBuilder = DecluttrFirebaseOptionsFromEnv(env);
    if (!optionsBuilder.hasRequiredKeys) {
      debugPrint(
        'DecluttrFirebaseBootstrap: skipping Firebase init — '
        'FIREBASE_PROJECT_ID is empty.',
      );
      return false;
    }

    try {
      final options = optionsBuilder.buildCurrentPlatform();
      if (options == null) {
        debugPrint(
          'DecluttrFirebaseBootstrap: no Firebase options for this platform.',
        );
        return false;
      }

      await Firebase.initializeApp(options: options);
      return true;
    } catch (e, st) {
      debugPrint('DecluttrFirebaseBootstrap: init failed: $e');
      debugPrint('$st');
      return false;
    }
  }

  /// Activates App Check after [initialize]. Debug builds (or
  /// `FIREBASE_APP_CHECK_USE_DEBUG_PROVIDER=true` in env) use debug providers —
  /// register tokens in Firebase Console → App Check → Manage debug tokens.
  static Future<void> activateAppCheck(Map<String, String> env) async {
    if (kIsWeb) return;

    final flag =
        env['FIREBASE_APP_CHECK_USE_DEBUG_PROVIDER']?.trim().toLowerCase();
    final useDebugProvider = kDebugMode ||
        flag == '1' ||
        flag == 'true' ||
        flag == 'yes';

    if (kDebugMode) {
      debugPrint(
        'DecluttrFirebaseBootstrap: App Check debug provider='
        '${useDebugProvider ? 'yes' : 'no (Play Integrity / App Attest)'}',
      );
    }

    try {
      await FirebaseAppCheck.instance.activate(
        providerAndroid: useDebugProvider
            ? const AndroidDebugProvider()
            : const AndroidPlayIntegrityProvider(),
        providerApple: useDebugProvider
            ? const AppleDebugProvider()
            : const AppleAppAttestWithDeviceCheckFallbackProvider(),
      );
      await FirebaseAppCheck.instance.setTokenAutoRefreshEnabled(true);
    } on MissingPluginException catch (e) {
      debugPrint(
        'DecluttrFirebaseBootstrap: App Check unavailable: $e\n'
        'Stop the app and do a full rebuild (not hot restart).',
      );
      if (!kDebugMode) rethrow;
    }
  }
}
