import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'providers.dart';

/// Bumped whenever trash contents change so dock badge count refreshes.
class TrashRevisionNotifier extends Notifier<int> {
  @override
  int build() => 0;

  void bump() => state++;
}

final trashRevisionProvider = NotifierProvider<TrashRevisionNotifier, int>(
  TrashRevisionNotifier.new,
);

final trashItemCountProvider = FutureProvider<int>((ref) async {
  ref.watch(trashRevisionProvider);
  final items = await ref.read(trashRepositoryProvider).fetchAll();
  return items.length;
});

void bumpTrashDockBadge(Ref ref) {
  ref.read(trashRevisionProvider.notifier).bump();
}

/// Bumped when lifetime swipe stats change (session flush, etc.).
class SwipeStatsRevisionNotifier extends Notifier<int> {
  @override
  int build() => 0;

  void bump() => state++;
}

final swipeStatsRevisionProvider = NotifierProvider<SwipeStatsRevisionNotifier, int>(
  SwipeStatsRevisionNotifier.new,
);

void bumpSwipeStatsRevision(Ref ref) {
  ref.read(swipeStatsRevisionProvider.notifier).bump();
}
