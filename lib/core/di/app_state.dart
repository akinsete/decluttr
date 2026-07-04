import 'package:freezed_annotation/freezed_annotation.dart';

part 'app_state.freezed.dart';

@freezed
abstract class AppState with _$AppState {
  const factory AppState({
    @Default(false) bool onboardingComplete,
    @Default(false) bool tutorialSeen,
    @Default(false) bool hasActivity,
    @Default(false) bool contactsGranted,
    @Default(false) bool photosGranted,
    @Default(true) bool hapticOn,
    @Default(true) bool notifOn,
    @Default(false) bool signedIn,
    @Default(true) bool isLoading,
  }) = _AppState;
}
