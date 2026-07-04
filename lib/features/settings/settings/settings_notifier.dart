import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/di/providers.dart';
import 'settings_state.dart';

class SettingsUiNotifier extends Notifier<SettingsUiState> {
  @override
  SettingsUiState build() {
    final appState = ref.watch(appStateProvider);
    return SettingsUiState(
      hapticOn: appState.hapticOn,
      notifOn: appState.notifOn,
      signedIn: appState.signedIn,
    );
  }

  Future<void> setHaptic(bool value) =>
      ref.read(appStateProvider.notifier).setHapticOn(value);

  Future<void> setNotif(bool value) =>
      ref.read(appStateProvider.notifier).setNotifOn(value);
}

final settingsUiProvider =
    NotifierProvider<SettingsUiNotifier, SettingsUiState>(
  SettingsUiNotifier.new,
);
