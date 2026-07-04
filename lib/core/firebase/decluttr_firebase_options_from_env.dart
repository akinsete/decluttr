import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';

class DecluttrFirebaseOptionsFromEnv {
  const DecluttrFirebaseOptionsFromEnv(this._env);

  final Map<String, String> _env;

  String? get projectId => _env['FIREBASE_PROJECT_ID']?.trim();

  bool get hasRequiredKeys {
    final id = projectId;
    return id != null && id.isNotEmpty;
  }

  FirebaseOptions? buildCurrentPlatform() {
    if (!hasRequiredKeys) {
      return null;
    }

    if (kIsWeb) {
      return _webOptions();
    }

    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return _androidOptions();
      case TargetPlatform.iOS:
      case TargetPlatform.macOS:
        return _iosOptions();
      default:
        return null;
    }
  }

  FirebaseOptions _androidOptions() {
    return FirebaseOptions(
      apiKey: _require('FIREBASE_ANDROID_API_KEY'),
      appId: _require('FIREBASE_ANDROID_APP_ID'),
      messagingSenderId: _require('FIREBASE_MESSAGING_SENDER_ID'),
      projectId: _require('FIREBASE_PROJECT_ID'),
      storageBucket: _optional('FIREBASE_STORAGE_BUCKET'),
    );
  }

  FirebaseOptions _iosOptions() {
    return FirebaseOptions(
      apiKey: _require('FIREBASE_IOS_API_KEY'),
      appId: _require('FIREBASE_IOS_APP_ID'),
      messagingSenderId: _require('FIREBASE_MESSAGING_SENDER_ID'),
      projectId: _require('FIREBASE_PROJECT_ID'),
      storageBucket: _optional('FIREBASE_STORAGE_BUCKET'),
      iosBundleId: _optional('FIREBASE_IOS_BUNDLE_ID'),
    );
  }

  FirebaseOptions _webOptions() {
    return FirebaseOptions(
      apiKey: _require('FIREBASE_WEB_API_KEY'),
      appId: _require('FIREBASE_WEB_APP_ID'),
      messagingSenderId: _require('FIREBASE_MESSAGING_SENDER_ID'),
      projectId: _require('FIREBASE_PROJECT_ID'),
      authDomain: _optional('FIREBASE_AUTH_DOMAIN'),
      storageBucket: _optional('FIREBASE_STORAGE_BUCKET'),
    );
  }

  String _require(String key) {
    final value = _env[key]?.trim();
    if (value == null || value.isEmpty) {
      throw StateError('Missing Firebase env key: $key');
    }
    return value;
  }

  String? _optional(String key) {
    final value = _env[key]?.trim();
    return value == null || value.isEmpty ? null : value;
  }
}
