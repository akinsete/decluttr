import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';

class SplashProgressNotifier extends Notifier<double> {
  Timer? _timer;

  @override
  double build() {
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(milliseconds: 44), (_) {
      if (state >= 1) {
        _timer?.cancel();
        return;
      }
      state = (state + 0.02).clamp(0, 1);
    });
    ref.onDispose(() => _timer?.cancel());
    return 0;
  }
}

final splashProgressProvider =
    NotifierProvider<SplashProgressNotifier, double>(SplashProgressNotifier.new);
