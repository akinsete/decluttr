import 'package:freezed_annotation/freezed_annotation.dart';

import '../../shared/domain/entities/swipe_item.dart';

part 'swipe_session_state.freezed.dart';

@freezed
abstract class SwipeSessionArgs with _$SwipeSessionArgs {
  const factory SwipeSessionArgs({
    required String batchId,
    required String batchTitle,
    required bool isPhotos,
    int? batchCount,
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
    @Default(0) int deletedBytes,
    @Default(false) bool flushed,
    @Default(true) bool isLoading,
    @Default(false) bool isLoadingMore,
    @Default(false) bool hasMore,
    @Default(0) int totalCount,
    @Default(0) int sourceOffset,
    @Default(false) bool showTutorial,
    @Default('') String batchId,
    @Default('') String batchTitle,
    @Default(true) bool isPhotos,
    DateTime? startedAt,
  }) = _SwipeSessionState;

  int get total => totalCount > 0 ? totalCount : items.length;

  int get displayedProgress {
    if (total == 0) return 0;
    final next = currentIndex + 1;
    return next > total ? total : next;
  }

  int get remaining => (items.length - currentIndex).clamp(0, items.length);

  bool get isComplete =>
      !isLoading && !isLoadingMore && currentIndex >= items.length && !hasMore;

  bool get shouldPrefetchMore =>
      isPhotos && hasMore && !isLoading && !isLoadingMore && remaining <= 3;

  bool get hasActivity => kept + deleted > 0;

  SwipeItem? get currentItem =>
      currentIndex < items.length ? items[currentIndex] : null;
}
