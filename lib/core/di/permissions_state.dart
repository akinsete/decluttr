import 'package:freezed_annotation/freezed_annotation.dart';

part 'permissions_state.freezed.dart';

@freezed
abstract class PermissionsState with _$PermissionsState {
  const factory PermissionsState({
    @Default(false) bool contactsGranted,
    @Default(false) bool photosGranted,
    @Default(true) bool isChecking,
  }) = _PermissionsState;
}
