import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../di/providers.dart';

typedef HapticPulse = Future<void> Function();

/// Settings-gated haptics. No-ops when [AppState.hapticOn] is false.
class AppHaptics {
  AppHaptics({
    required bool Function() isEnabled,
    HapticPulse? selection,
    HapticPulse? light,
    HapticPulse? medium,
  })  : _isEnabled = isEnabled,
        _selection = selection ?? HapticFeedback.selectionClick,
        _light = light ?? HapticFeedback.lightImpact,
        _medium = medium ?? HapticFeedback.mediumImpact;

  final bool Function() _isEnabled;
  final HapticPulse _selection;
  final HapticPulse _light;
  final HapticPulse _medium;

  Future<void> selection() => _run(_selection);

  Future<void> light() => _run(_light);

  Future<void> medium() => _run(_medium);

  /// Keep / delete decision — stronger pulse.
  Future<void> decision() => medium();

  /// Undo — lighter pulse.
  Future<void> undo() => light();

  Future<void> _run(HapticPulse pulse) async {
    if (!_isEnabled()) return;
    await pulse();
  }
}

final appHapticsProvider = Provider<AppHaptics>((ref) {
  return AppHaptics(
    isEnabled: () => ref.read(appStateProvider).hapticOn,
  );
});
