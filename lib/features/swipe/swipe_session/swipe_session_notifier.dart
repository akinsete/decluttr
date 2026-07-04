import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/di/providers.dart';
import '../../../../core/error/result.dart';
import '../../shared/domain/entities/swipe_item.dart';
import '../../shared/domain/entities/trash_item.dart';
import 'swipe_session_state.dart';

class SwipeSessionNotifier extends Notifier<SwipeSessionState> {
  SwipeSessionNotifier(this._args);

  final SwipeSessionArgs _args;
  SwipeItem? _lastRemoved;
  SwipeDecision? _lastDecision;

  @override
  SwipeSessionState build() {
    Future.microtask(_load);
    return SwipeSessionState(batchId: _args.batchId, batchTitle: _args.batchTitle, isPhotos: _args.isPhotos);
  }

  Future<void> _load() async {
    final prefs = ref.read(appPreferencesRepositoryProvider);
    final tutorialSeen = await prefs.tutorialSeen();

    if (_args.isPhotos) {
      final result = await ref.read(photosRepositoryProvider).fetchPhotosForBatch(_args.batchId);
      final photos = result is Success ? result.value : const [];
      state = state.copyWith(
        items: photos
            .map((p) => SwipeItem(id: p.id, title: p.title, subtitle: p.subtitle, gradientIndex: p.gradientIndex))
            .toList(),
        isLoading: false,
        showTutorial: !tutorialSeen,
      );
    } else {
      final result = await ref.read(contactsRepositoryProvider).fetchContactsForBatch(_args.batchId);
      final contacts = result is Success ? result.value : const [];
      state = state.copyWith(
        items: contacts
            .map(
              (c) => SwipeItem(id: c.id, title: c.displayName, subtitle: c.phone ?? c.email ?? '', detailBody: c.email),
            )
            .toList(),
        isLoading: false,
        showTutorial: !tutorialSeen,
      );
    }
  }

  Future<void> dismissTutorial() async {
    await ref.read(appStateProvider.notifier).setTutorialSeen(true);
    state = state.copyWith(showTutorial: false);
  }

  Future<void> keepCurrent() async {
    final item = state.currentItem;
    if (item == null) return;
    _lastRemoved = item;
    _lastDecision = SwipeDecision.keep;
    state = state.copyWith(currentIndex: state.currentIndex + 1, kept: state.kept + 1);
    await ref.read(appStateProvider.notifier).recordActivity();
  }

  Future<void> deleteCurrent() async {
    final item = state.currentItem;
    if (item == null) return;
    _lastRemoved = item;
    _lastDecision = SwipeDecision.delete;

    await ref
        .read(trashRepositoryProvider)
        .add(
          TrashItem(
            id: item.id,
            type: state.isPhotos ? TrashItemType.photo : TrashItemType.contact,
            title: item.title,
            subtitle: item.subtitle,
            deletedAt: DateTime.now(),
            monthKey: state.isPhotos ? state.batchId : null,
            initial: state.isPhotos ? null : (item.title.isNotEmpty ? item.title[0] : '?'),
          ),
        );

    state = state.copyWith(currentIndex: state.currentIndex + 1, deleted: state.deleted + 1);
    await ref.read(appStateProvider.notifier).recordActivity();
  }

  void undoLast() {
    if (_lastRemoved == null || state.currentIndex == 0) return;
    state = state.copyWith(
      currentIndex: state.currentIndex - 1,
      kept: _lastDecision == SwipeDecision.keep ? state.kept - 1 : state.kept,
      deleted: _lastDecision == SwipeDecision.delete ? state.deleted - 1 : state.deleted,
    );
    _lastRemoved = null;
    _lastDecision = SwipeDecision.undo;
  }
}

final swipeSessionProvider = NotifierProvider.family<SwipeSessionNotifier, SwipeSessionState, SwipeSessionArgs>(
  SwipeSessionNotifier.new,
);
