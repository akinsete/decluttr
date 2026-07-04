import 'package:freezed_annotation/freezed_annotation.dart';

import '../../shared/domain/entities/swipe_item.dart';

part 'swipe_session_state.freezed.dart';

@freezed
abstract class SwipeSessionArgs with _$SwipeSessionArgs {
  const factory SwipeSessionArgs({
    required String batchId,
    required String batchTitle,
    required bool isPhotos,
  }) = _SwipeSessionArgs;
}

@freezed
abstract class SwipeSessionState with _$SwipeSessionState {
  const SwipeSessionState._();

  const factory SwipeSessionState({
    @Default(<SwipeItem>[]) List<SwipeItem> items,
    @Default(0) int currentIndex,
    @Default(0) int kept,
    @Default(0) int deleted,
    @Default(true) bool isLoading,
    @Default(false) bool showTutorial,
    @Default('') String batchId,
    @Default('') String batchTitle,
    @Default(true) bool isPhotos,
  }) = _SwipeSessionState;

  int get total => items.length;

  int get remaining => (total - currentIndex).clamp(0, total);

  bool get isComplete => !isLoading && currentIndex >= total;

  SwipeItem? get currentItem =>
      currentIndex < items.length ? items[currentIndex] : null;
}
