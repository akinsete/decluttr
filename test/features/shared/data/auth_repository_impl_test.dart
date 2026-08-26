import 'package:decluttr/features/shared/data/repositories/auth_repository_impl.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../helpers/mock_providers.mocks.dart';

void main() {
  group('AuthRepositoryImpl', () {
    late MockFirebaseAuth auth;
    late AuthRepositoryImpl repository;

    setUp(() {
      auth = MockFirebaseAuth();
      repository = AuthRepositoryImpl(auth: auth);
    });

    test('ensureAnonymousUser returns existing uid', () async {
      final user = MockUser();
      when(user.uid).thenReturn('existing-uid');
      when(auth.currentUser).thenReturn(user);

      final uid = await repository.ensureAnonymousUser();

      expect(uid, 'existing-uid');
      verifyNever(auth.signInAnonymously());
    });

    test('ensureAnonymousUser signs in anonymously when no user', () async {
      when(auth.currentUser).thenReturn(null);
      final user = MockUser();
      when(user.uid).thenReturn('anon-uid');
      final credential = MockUserCredential();
      when(credential.user).thenReturn(user);
      when(auth.signInAnonymously()).thenAnswer((_) async => credential);

      final uid = await repository.ensureAnonymousUser();

      expect(uid, 'anon-uid');
      verify(auth.signInAnonymously()).called(1);
    });

    test('linkWithEmail links anonymous account', () async {
      final user = MockUser();
      when(user.isAnonymous).thenReturn(true);
      when(auth.currentUser).thenReturn(user);
      when(user.linkWithCredential(any)).thenAnswer((_) async => MockUserCredential());

      await repository.linkWithEmail(email: 'a@b.com', password: 'secret');

      verify(user.linkWithCredential(any)).called(1);
    });
  });
}
