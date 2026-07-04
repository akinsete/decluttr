import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/di/providers.dart';

class SignInLoadingNotifier extends Notifier<bool> {
  @override
  bool build() => false;

  Future<void> signIn() async {
    state = true;
    await Future<void>.delayed(const Duration(milliseconds: 400));
    await ref.read(appStateProvider.notifier).setSignedIn(true);
    state = false;
  }
}

final signInLoadingProvider =
    NotifierProvider<SignInLoadingNotifier, bool>(SignInLoadingNotifier.new);
