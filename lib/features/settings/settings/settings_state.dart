import 'package:freezed_annotation/freezed_annotation.dart';

part 'settings_state.freezed.dart';

@freezed
abstract class SettingsUiState with _$SettingsUiState {
  const factory SettingsUiState({
    @Default(true) bool hapticOn,
    @Default(true) bool notifOn,
    @Default(false) bool signedIn,
  }) = _SettingsUiState;
}
