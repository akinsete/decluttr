import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';

import '../../../../core/di/providers.dart';
import '../../../../core/di/trash_dock_badge_providers.dart';
import '../../../../core/error/result.dart';
import '../../shared/data/photos/photo_load_log.dart';
import '../../shared/domain/entities/photo_asset.dart';
import '../../shared/domain/entities/photo_batch_page.dart';
import '../../shared/domain/entities/swipe_item.dart';
import '../../shared/domain/entities/swipe_session_record.dart';
import '../../shared/domain/entities/trash_item.dart';
import 'swipe_session_state.dart';

class SwipeSessionNotifier extends Notifier<SwipeSessionState> {
  SwipeSessionNotifier(this._args);

  final SwipeSessionArgs _args;
  SwipeItem? _lastRemoved;
  SwipeDecision? _lastDecision;
  static const _uuid = Uuid();
  static const _pageSize = 6;
  static const _prefetchThreshold = 2;

  Set<String> _trashedIds = {};

  @override
  SwipeSessionState build() {
    Future.microtask(_load);
    return SwipeSessionState(
      batchId: _args.batchId,
      batchTitle: _args.batchTitle,
      isPhotos: _args.isPhotos,
      totalCount: _args.batchCount ?? 0,
      startedAt: DateTime.now(),
    );
  }

  Future<void> _load() async {
    final trace = PhotoLoadTrace('SwipeSession(${_args.batchId})');
    final prefs = ref.read(appPreferencesRepositoryProvider);
    final tutorialSeen = await prefs.tutorialSeen();
    trace.step('tutorialSeen');

    _trashedIds = await _loadTrashedIds();
    trace.step('trashedIds=${_trashedIds.length}');

    if (_args.isPhotos) {
      await _loadInitialPhotos(showTutorial: !tutorialSeen, trace: trace);
    } else {
      final result = await ref.read(contactsRepositoryProvider).fetchContactsForBatch(_args.batchId);
      final contacts = (result is Success ? result.value : const [])
          .where((contact) => !_trashedIds.contains(contact.id))
          .toList();
      state = state.copyWith(
        items: contacts
            .map(
              (c) => SwipeItem(id: c.id, title: c.displayName, subtitle: c.phone ?? c.email ?? '', detailBody: c.email),
            )
            .toList(),
        totalCount: contacts.length,
        hasMore: false,
        isLoading: false,
        showTutorial: !tutorialSeen,
      );
      trace.finish('contacts loaded count=${contacts.length}');
    }
  }

  Future<void> _loadInitialPhotos({required bool showTutorial, required PhotoLoadTrace trace}) async {
    final loaded = await _fetchPhotoPage(offset: 0, trace: trace);
    state = state.copyWith(
      items: loaded.items,
      sourceOffset: loaded.nextOffset,
      hasMore: loaded.hasMore,
      totalCount: _resolvedTotalCount(loaded),
      isLoading: false,
      showTutorial: showTutorial,
    );
    trace.step('initial UI ready items=${loaded.items.length} total=${state.totalCount}');
    await _prefetchIfNeeded();
    trace.finish('initial photos ready');
  }

  Future<void> loadMoreIfNeeded() async {
    if (!state.shouldPrefetchMore) return;
    await _loadMorePhotos();
  }

  Future<void> _prefetchIfNeeded() async {
    if (state.remaining > _prefetchThreshold || !state.hasMore) return;
    await _loadMorePhotos();
  }

  Future<void> _loadMorePhotos() async {
    if (!state.isPhotos || !state.hasMore || state.isLoadingMore) return;

    final trace = PhotoLoadTrace('SwipeSession.loadMore(${_args.batchId})');
    state = state.copyWith(isLoadingMore: true);
    final loaded = await _fetchPhotoPage(offset: state.sourceOffset, trace: trace);
    state = state.copyWith(
      items: [...state.items, ...loaded.items],
      sourceOffset: loaded.nextOffset,
      hasMore: loaded.hasMore,
      totalCount: _resolvedTotalCount(loaded, append: true),
      isLoadingMore: false,
    );
    trace.finish('appended ${loaded.items.length} items totalLoaded=${state.items.length}');
  }

  int _resolvedTotalCount(_PhotoPageSlice loaded, {bool append = false}) {
    if (loaded.repoTotalCount > 0) {
      return loaded.repoTotalCount;
    }
    if (_args.batchCount != null && _args.batchCount! > 0) {
      return _args.batchCount!;
    }
    if (!loaded.hasMore) {
      return append ? state.items.length + loaded.items.length : loaded.items.length;
    }
    return append ? state.totalCount : loaded.items.length;
  }

  Future<_PhotoPageSlice> _fetchPhotoPage({required int offset, PhotoLoadTrace? trace}) async {
    final targetCount = _pageSize;
    final collected = <SwipeItem>[];
    var nextOffset = offset;
    var hasMore = true;
    var repoRound = 0;

    var repoTotalCount = 0;

    trace?.step('fetchPhotoPage offset=$offset target=$targetCount');

    while (collected.length < targetCount && hasMore) {
      repoRound++;
      final roundSw = Stopwatch()..start();
      final result = await ref
          .read(photosRepositoryProvider)
          .fetchPhotosForBatchPage(_args.batchId, offset: nextOffset, limit: targetCount - collected.length);

      if (result is! Success<PhotoBatchPage>) {
        photoLoadLog('fetchPhotoPage repo failure at offset=$nextOffset');
        hasMore = false;
        break;
      }

      final page = result.value;
      repoTotalCount = page.totalCount;
      final fresh = page.items.where((photo) => !_trashedIds.contains(photo.id)).map(_mapPhoto).toList();

      collected.addAll(fresh);
      nextOffset += page.items.length;
      hasMore = page.hasMore;

      trace?.step(
        'repoRound=$repoRound raw=${page.items.length} kept=${fresh.length} '
        'trashedFiltered=${page.items.length - fresh.length} '
        'repoMs=${roundSw.elapsedMilliseconds}',
      );

      if (page.items.isEmpty) {
        hasMore = false;
      }
    }

    trace?.step('fetchPhotoPage done collected=${collected.length} nextOffset=$nextOffset hasMore=$hasMore');

    return _PhotoPageSlice(items: collected, nextOffset: nextOffset, hasMore: hasMore, repoTotalCount: repoTotalCount);
  }

  Future<Set<String>> _loadTrashedIds() async {
    final type = _args.isPhotos ? TrashItemType.photo : TrashItemType.contact;
    final trashed = await ref.read(trashRepositoryProvider).fetchByType(type);
    return trashed.map((item) => item.id).toSet();
  }

  SwipeItem _mapPhoto(PhotoAsset photo) {
    return SwipeItem(
      id: photo.id,
      title: photo.title,
      subtitle: photo.subtitle,
      gradientIndex: photo.gradientIndex,
      sizeBytes: photo.sizeBytes,
      isVideo: photo.isVideo,
      durationLabel: photo.durationLabel,
    );
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
    await _prefetchIfNeeded();
  }

  Future<void> deleteCurrent() async {
    final item = state.currentItem;
    if (item == null) return;

    var sizeBytes = item.sizeBytes;
    if (state.isPhotos && sizeBytes <= 0) {
      final sized = await ref.read(photosRepositoryProvider).resolvePhotoSizeBytes(item.id);
      sizeBytes = sized.valueOrNull ?? 0;
    }

    final trashedItem = item.copyWith(sizeBytes: sizeBytes);

    await ref
        .read(trashRepositoryProvider)
        .add(
          TrashItem(
            id: trashedItem.id,
            type: state.isPhotos ? TrashItemType.photo : TrashItemType.contact,
            title: trashedItem.title,
            subtitle: trashedItem.subtitle,
            deletedAt: DateTime.now(),
            monthKey: state.isPhotos ? state.batchId : null,
            initial: state.isPhotos ? null : _initials(trashedItem.title),
            sizeBytes: state.isPhotos ? sizeBytes : 0,
            gradientIndex: trashedItem.gradientIndex,
            isVideo: state.isPhotos ? trashedItem.isVideo : false,
            durationLabel: state.isPhotos ? trashedItem.durationLabel : null,
          ),
        );

    bumpTrashDockBadge(ref);

    _lastRemoved = trashedItem;
    _lastDecision = SwipeDecision.delete;

    state = state.copyWith(
      currentIndex: state.currentIndex + 1,
      deleted: state.deleted + 1,
      deletedBytes: state.deletedBytes + (state.isPhotos ? sizeBytes : 0),
    );
    await ref.read(appStateProvider.notifier).recordActivity();
    await _prefetchIfNeeded();
  }

  Future<void> undoLast() async {
    if (_lastRemoved == null || state.currentIndex == 0) return;

    if (_lastDecision == SwipeDecision.delete) {
      await ref.read(trashRepositoryProvider).remove(_lastRemoved!.id);
      bumpTrashDockBadge(ref);
      state = state.copyWith(
        currentIndex: state.currentIndex - 1,
        deleted: state.deleted - 1,
        deletedBytes: state.deletedBytes - (state.isPhotos ? _lastRemoved!.sizeBytes : 0),
      );
    } else {
      state = state.copyWith(currentIndex: state.currentIndex - 1, kept: state.kept - 1);
    }

    _lastRemoved = null;
    _lastDecision = SwipeDecision.undo;
  }

  /// Persists one combined session record locally (+ remote when available).
  Future<void> flushSession({required bool completed}) async {
    if (state.flushed || !state.hasActivity) return;

    final record = SwipeSessionRecord(
      sessionId: _uuid.v4(),
      batchId: state.batchId,
      isPhotos: state.isPhotos,
      keptCount: state.kept,
      deletedCount: state.deleted,
      deletedBytes: state.deletedBytes,
      completed: completed,
      startedAt: state.startedAt ?? DateTime.now(),
      endedAt: DateTime.now(),
    );

    await ref.read(swipeStatsRepositoryProvider).recordSession(record);
    bumpSwipeStatsRevision(ref);
    state = state.copyWith(flushed: true);
  }

  static String _initials(String name) {
    final parts = name.trim().split(RegExp(r'\s+'));
    if (parts.isEmpty || parts.first.isEmpty) return '?';
    final first = parts.first[0].toUpperCase();
    if (parts.length == 1) return first;
    final last = parts.last;
    return last.isEmpty ? first : '$first${last[0].toUpperCase()}';
  }
}

class _PhotoPageSlice {
  const _PhotoPageSlice({
    required this.items,
    required this.nextOffset,
    required this.hasMore,
    required this.repoTotalCount,
  });

  final List<SwipeItem> items;
  final int nextOffset;
  final bool hasMore;
  final int repoTotalCount;
}

final swipeSessionProvider = NotifierProvider.family<SwipeSessionNotifier, SwipeSessionState, SwipeSessionArgs>(
  SwipeSessionNotifier.new,
);
