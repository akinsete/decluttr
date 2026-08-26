import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

import '../../domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  AuthRepositoryImpl({FirebaseAuth? auth}) : _auth = auth ?? FirebaseAuth.instance;

  final FirebaseAuth _auth;

  @override
  String? get currentUserId => _auth.currentUser?.uid;

  @override
  bool get isAnonymous => _auth.currentUser?.isAnonymous ?? false;

  @override
  Future<String?> ensureAnonymousUser() async {
    try {
      final existing = _auth.currentUser;
      if (existing != null) return existing.uid;

      final credential = await _auth.signInAnonymously();
      return credential.user?.uid;
    } catch (e, st) {
      debugPrint('AuthRepositoryImpl.ensureAnonymousUser: $e\n$st');
      return null;
    }
  }

  @override
  Future<void> linkWithEmail({
    required String email,
    required String password,
  }) async {
    final user = _auth.currentUser;
    if (user == null) {
      throw StateError('No signed-in user to link');
    }

    final credential = EmailAuthProvider.credential(
      email: email,
      password: password,
    );

    if (user.isAnonymous) {
      await user.linkWithCredential(credential);
    } else {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
    }
  }
}
