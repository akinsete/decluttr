import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import '../environment/decluttr_app_environment.dart';

class DecluttrFirebaseEnvLoader {
  static Future<Map<String, String>> load(
    DecluttrAppEnvironment environment,
  ) async {
    final fileName = environment.isProduction
        ? 'env/.env.production'
        : 'env/.env.development';

    try {
      await dotenv.load(fileName: fileName);
    } catch (e, st) {
      debugPrint('DecluttrFirebaseEnvLoader: failed to load $fileName: $e');
      debugPrint('$st');
    }

    return Map<String, String>.from(dotenv.env);
  }
}
