import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/di/providers.dart';

class SignInLoadingNotifier extends Notifier<bool> {
  @override
  bool build() => false;

  Future<void> signIn({required String email, required String password}) async {
    state = true;
    try {
      await ref.read(authRepositoryProvider).linkWithEmail(
            email: email,
            password: password,
          );
      await ref.read(appStateProvider.notifier).setSignedIn(true);
      await ref.read(swipeStatsRepositoryProvider).syncPendingSessions();
    } finally {
      state = false;
    }
  }
}

final signInLoadingProvider =
    NotifierProvider<SignInLoadingNotifier, bool>(SignInLoadingNotifier.new);
