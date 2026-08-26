import 'package:freezed_annotation/freezed_annotation.dart';

import '../../shared/domain/entities/trash_item.dart';

part 'trash_state.freezed.dart';

enum TrashTab { photos, contacts }

@freezed
abstract class TrashUiState with _$TrashUiState {
  const factory TrashUiState({
    @Default(TrashTab.photos) TrashTab tab,
    @Default(false) bool selectMode,
    @Default(<String>{}) Set<String> selectedIds,
    @Default(true) bool isLoading,
    @Default(<TrashItem>[]) List<TrashItem> items,
  }) = _TrashUiState;
}
