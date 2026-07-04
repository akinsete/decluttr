import 'package:freezed_annotation/freezed_annotation.dart';

import '../../shared/domain/entities/duplicate_group.dart';

part 'duplicate_contacts_state.freezed.dart';

@freezed
abstract class DuplicateContactsState with _$DuplicateContactsState {
  const DuplicateContactsState._();

  const factory DuplicateContactsState({
    @Default(<DuplicateGroup>[]) List<DuplicateGroup> groups,
    @Default(0) int index,
    @Default(0) int merged,
    @Default(0) int kept,
    @Default(0) int deleted,
    @Default(false) bool isComplete,
  }) = _DuplicateContactsState;

  DuplicateGroup? get currentGroup =>
      index < groups.length ? groups[index] : null;
}
