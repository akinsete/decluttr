import 'package:decluttr/core/di/app_state.dart';
import 'package:decluttr/core/di/providers.dart';
import 'package:decluttr/core/error/result.dart';
import 'package:decluttr/features/shared/data/repositories/kept_items_repository_impl.dart';
import 'package:decluttr/features/shared/domain/entities/batch_item.dart';
import 'package:decluttr/features/shared/domain/entities/insights_snapshot.dart';
import 'package:decluttr/features/shared/domain/entities/lifetime_swipe_stats.dart';
import 'package:decluttr/features/shared/domain/entities/photo_asset.dart';
import 'package:decluttr/features/shared/domain/entities/photo_batch_page.dart';
import 'package:decluttr/features/shared/domain/entities/swipe_item.dart';
import 'package:decluttr/features/shared/domain/entities/swipe_session_record.dart';
import 'package:decluttr/features/shared/domain/entities/trash_item.dart';
import 'package:decluttr/features/shared/domain/repositories/photos_repository.dart';
import 'package:decluttr/features/shared/domain/repositories/swipe_stats_repository.dart';
import 'package:decluttr/features/shared/domain/repositories/trash_repository.dart';
import 'package:decluttr/features/swipe/swipe_session/swipe_session_notifier.dart';
import 'package:decluttr/features/swipe/swipe_session/swipe_session_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../helpers/mock_providers.dart';

const _swipeArgs = SwipeSessionArgs(
  batchId: '2026-07',
  batchTitle: 'July 2026',
  isPhotos: true,
);

void main() {
  test('displayedProgress clamps to total on last item', () {
    const state = SwipeSessionState(
      isLoading: false,
      hasMore: false,
      totalCount: 1,
      currentIndex: 1,
      items: [
        SwipeItem(id: '1', title: 'Only photo', subtitle: '1 MB'),
      ],
    );

    expect(state.isComplete, isTrue);
    expect(state.displayedProgress, 1);
  });

  test('flushSession records one combined session record', () async {
    SharedPreferences.setMockInitialValues({});
    final prefs = await SharedPreferences.getInstance();
    final statsRepo = _RecordingSwipeStatsRepository();

    final container = ProviderContainer(
      overrides: [
        sharedPreferencesProvider.overrideWithValue(prefs),
        swipeStatsRepositoryProvider.overrideWithValue(statsRepo),
        photosRepositoryProvider.overrideWithValue(_MemoryPhotosRepository()),
        trashRepositoryProvider.overrideWithValue(_MemoryTrashRepository()),
        swipeSessionProvider(_swipeArgs).overrideWith(_LoadedSwipeSession.new),
      ],
    );
    addTearDown(container.dispose);

    final notifier = container.read(swipeSessionProvider(_swipeArgs).notifier);
    await notifier.flushSession(completed: false);

    expect(statsRepo.lastSession, isNotNull);
    expect(statsRepo.lastSession!.keptCount, 2);
    expect(statsRepo.lastSession!.deletedCount, 1);
    expect(statsRepo.lastSession!.deletedBytes, 2400000);
    expect(statsRepo.lastSession!.completed, isFalse);
    expect(container.read(swipeSessionProvider(_swipeArgs)).flushed, isTrue);
  });

  test('flushSession is idempotent', () async {
    SharedPreferences.setMockInitialValues({});
    final prefs = await SharedPreferences.getInstance();
    final statsRepo = _RecordingSwipeStatsRepository();

    final container = ProviderContainer(
      overrides: [
        sharedPreferencesProvider.overrideWithValue(prefs),
        swipeStatsRepositoryProvider.overrideWithValue(statsRepo),
        photosRepositoryProvider.overrideWithValue(_MemoryPhotosRepository()),
        trashRepositoryProvider.overrideWithValue(_MemoryTrashRepository()),
        swipeSessionProvider(_swipeArgs).overrideWith(_LoadedSwipeSession.new),
      ],
    );
    addTearDown(container.dispose);

    final notifier = container.read(swipeSessionProvider(_swipeArgs).notifier);
    await notifier.flushSession(completed: true);
    await notifier.flushSession(completed: true);

    expect(statsRepo.recordCount, 1);
  });

  test('deleteCurrent stages photo in trash without calling PhotoKit', () async {
    SharedPreferences.setMockInitialValues({});
    final prefs = await SharedPreferences.getInstance();
    final photosRepo = _MemoryPhotosRepository();
    final trashRepo = _MemoryTrashRepository();

    final container = ProviderContainer(
      overrides: [
        sharedPreferencesProvider.overrideWithValue(prefs),
        appStateProvider.overrideWith(_ReadyAppState.new),
        photosRepositoryProvider.overrideWithValue(photosRepo),
        trashRepositoryProvider.overrideWithValue(trashRepo),
        swipeSessionProvider(_swipeArgs).overrideWith(_SingleItemSwipeSession.new),
      ],
    );
    addTearDown(container.dispose);

    final notifier = container.read(swipeSessionProvider(_swipeArgs).notifier);
    await notifier.deleteCurrent();

    final state = container.read(swipeSessionProvider(_swipeArgs));
    expect(state.isComplete, isTrue);
    expect(state.currentItem, isNull);
    expect(state.deleted, 1);
    expect(photosRepo.deletedIds, isEmpty);
    expect(trashRepo.items.map((item) => item.id), ['last']);
  });

  test('undoLast restores staged delete from trash', () async {
    SharedPreferences.setMockInitialValues({});
    final prefs = await SharedPreferences.getInstance();
    final trashRepo = _MemoryTrashRepository();

    final container = ProviderContainer(
      overrides: [
        sharedPreferencesProvider.overrideWithValue(prefs),
        appStateProvider.overrideWith(_ReadyAppState.new),
        photosRepositoryProvider.overrideWithValue(_MemoryPhotosRepository()),
        trashRepositoryProvider.overrideWithValue(trashRepo),
        swipeSessionProvider(_swipeArgs).overrideWith(_SingleItemSwipeSession.new),
      ],
    );
    addTearDown(container.dispose);

    final notifier = container.read(swipeSessionProvider(_swipeArgs).notifier);
    await notifier.deleteCurrent();
    await notifier.undoLast();

    final state = container.read(swipeSessionProvider(_swipeArgs));
    expect(state.isComplete, isFalse);
    expect(state.deleted, 0);
    expect(state.currentItem?.id, 'last');
    expect(trashRepo.items, isEmpty);
  });

  test('keepCurrent persists id and undo removes it', () async {
    SharedPreferences.setMockInitialValues({});
    final prefs = await SharedPreferences.getInstance();
    final keptRepo = MockKeptItemsRepository();
    when(keptRepo.add(any, any)).thenAnswer((_) async {});
    when(keptRepo.remove(any)).thenAnswer((_) async {});

    final container = ProviderContainer(
      overrides: [
        sharedPreferencesProvider.overrideWithValue(prefs),
        appStateProvider.overrideWith(_ReadyAppState.new),
        photosRepositoryProvider.overrideWithValue(_MemoryPhotosRepository()),
        trashRepositoryProvider.overrideWithValue(_MemoryTrashRepository()),
        keptItemsRepositoryProvider.overrideWithValue(keptRepo),
        swipeSessionProvider(_swipeArgs).overrideWith(_SingleItemSwipeSession.new),
      ],
    );
    addTearDown(container.dispose);

    final notifier = container.read(swipeSessionProvider(_swipeArgs).notifier);
    await notifier.keepCurrent();

    verify(keptRepo.add('last', TrashItemType.photo)).called(1);
    expect(container.read(swipeSessionProvider(_swipeArgs)).kept, 1);

    await notifier.undoLast();

    verify(keptRepo.remove('last')).called(1);
    expect(container.read(swipeSessionProvider(_swipeArgs)).kept, 0);
    expect(container.read(swipeSessionProvider(_swipeArgs)).currentItem?.id, 'last');
  });

  test('reload excludes previously kept ids from the deck', () async {
    SharedPreferences.setMockInitialValues({});
    final prefs = await SharedPreferences.getInstance();
    final keptRepo = KeptItemsRepositoryImpl(prefs: prefs);
    final photos = _MemoryPhotosRepository(
      assets: const [
        PhotoAsset(
          id: 'keep-me',
          title: 'Keep me',
          subtitle: 'July 2026',
          monthKey: '2026-07',
        ),
        PhotoAsset(
          id: 'next',
          title: 'Next',
          subtitle: 'July 2026',
          monthKey: '2026-07',
        ),
      ],
    );

    final first = ProviderContainer(
      overrides: [
        sharedPreferencesProvider.overrideWithValue(prefs),
        appStateProvider.overrideWith(_ReadyAppState.new),
        photosRepositoryProvider.overrideWithValue(photos),
        trashRepositoryProvider.overrideWithValue(_MemoryTrashRepository()),
        keptItemsRepositoryProvider.overrideWithValue(keptRepo),
      ],
    );

    await _waitUntilLoaded(first);
    final firstNotifier = first.read(swipeSessionProvider(_swipeArgs).notifier);
    expect(first.read(swipeSessionProvider(_swipeArgs)).currentItem?.id, 'keep-me');
    await firstNotifier.keepCurrent();
    expect(await keptRepo.fetchIds(TrashItemType.photo), {'keep-me'});
    first.dispose();

    final second = ProviderContainer(
      overrides: [
        sharedPreferencesProvider.overrideWithValue(prefs),
        appStateProvider.overrideWith(_ReadyAppState.new),
        photosRepositoryProvider.overrideWithValue(photos),
        trashRepositoryProvider.overrideWithValue(_MemoryTrashRepository()),
        keptItemsRepositoryProvider.overrideWithValue(
          KeptItemsRepositoryImpl(prefs: prefs),
        ),
      ],
    );
    addTearDown(second.dispose);

    await _waitUntilLoaded(second);
    final ids =
        second.read(swipeSessionProvider(_swipeArgs)).items.map((item) => item.id).toList();
    expect(ids, isNot(contains('keep-me')));
    expect(ids, ['next']);
  });
}

Future<void> _waitUntilLoaded(ProviderContainer container) async {
  for (var i = 0; i < 50; i++) {
    await Future<void>.delayed(Duration.zero);
    if (!container.read(swipeSessionProvider(_swipeArgs)).isLoading) return;
  }
  fail('swipe session stayed loading');
}

class _ReadyAppState extends AppStateNotifier {
  @override
  AppState build() => const AppState(isLoading: false);
}

class _SingleItemSwipeSession extends SwipeSessionNotifier {
  _SingleItemSwipeSession() : super(_swipeArgs);

  @override
  SwipeSessionState build() {
    return SwipeSessionState(
      batchId: '2026-07',
      batchTitle: 'July 2026',
      isPhotos: true,
      isLoading: false,
      hasMore: false,
      totalCount: 1,
      items: const [
        SwipeItem(id: 'last', title: 'Last photo', subtitle: 'July 2026 · 1 MB', sizeBytes: 1000),
      ],
    );
  }
}

class _LoadedSwipeSession extends SwipeSessionNotifier {
  _LoadedSwipeSession() : super(_swipeArgs);

  @override
  SwipeSessionState build() {
    return SwipeSessionState(
      batchId: '2026-07',
      batchTitle: 'July 2026',
      isPhotos: true,
      isLoading: false,
      kept: 2,
      deleted: 1,
      deletedBytes: 2400000,
      startedAt: DateTime(2026, 7, 4),
      items: const [
        SwipeItem(id: '1', title: 'IMG_1', subtitle: 'July 2026 · 2.4 MB', sizeBytes: 2400000),
      ],
    );
  }
}

class _RecordingSwipeStatsRepository implements SwipeStatsRepository {
  SwipeSessionRecord? lastSession;
  int recordCount = 0;

  @override
  Future<LifetimeSwipeStats> getLifetimeStats() async => const LifetimeSwipeStats();

  @override
  Future<InsightsSnapshot> getInsightsSnapshot() async => const InsightsSnapshot();

  @override
  Future<void> recordCommittedDeletedBytes(int bytes) async {}

  @override
  Future<void> recordSession(SwipeSessionRecord session) async {
    lastSession = session;
    recordCount++;
  }

  @override
  Future<void> syncPendingSessions() async {}
}

class _MemoryTrashRepository implements TrashRepository {
  final items = <TrashItem>[];

  @override
  Future<void> add(TrashItem item) async {
    items.removeWhere((existing) => existing.id == item.id);
    items.add(item);
  }

  @override
  Future<void> deleteForever(List<String> ids) async {
    items.removeWhere((item) => ids.contains(item.id));
  }

  @override
  Future<List<TrashItem>> fetchAll() async => List.unmodifiable(items);

  @override
  Future<List<TrashItem>> fetchByType(TrashItemType type) async =>
      items.where((item) => item.type == type).toList();

  @override
  Future<int> reclaimableBytes({TrashItemType? type}) async => 0;

  @override
  Future<List<TrashItem>> fetchExpired({
    Duration maxAge = const Duration(days: 30),
  }) async =>
      const [];

  @override
  Future<void> remove(String id) async {
    items.removeWhere((item) => item.id == id);
  }

  @override
  Future<void> restore(List<String> ids) async {
    items.removeWhere((item) => ids.contains(item.id));
  }
}

class _MemoryPhotosRepository implements PhotosRepository {
  _MemoryPhotosRepository({this.assets = const []});

  final List<PhotoAsset> assets;
  final deletedIds = <String>[];

  @override
  Future<Result<void>> deletePhotos(List<String> assetIds) async {
    deletedIds.addAll(assetIds);
    return const Success(null);
  }

  @override
  Future<Result<List<BatchItem>>> fetchBatches() async => const Success([]);

  @override
  Future<Result<List<PhotoAsset>>> fetchPhotosForBatch(String batchId) async =>
      Success(assets);

  @override
  Future<Result<PhotoBatchPage>> fetchPhotosForBatchPage(
    String batchId, {
    required int offset,
    required int limit,
  }) async {
    if (offset >= assets.length) {
      return Success(
        PhotoBatchPage(items: const [], totalCount: assets.length, hasMore: false),
      );
    }
    final end = (offset + limit).clamp(0, assets.length);
    final slice = assets.sublist(offset, end);
    return Success(
      PhotoBatchPage(
        items: slice,
        totalCount: assets.length,
        hasMore: end < assets.length,
      ),
    );
  }

  @override
  Future<Result<bool>> hasPermission() async => const Success(true);

  @override
  Future<Result<bool>> requestPermission() async => const Success(true);

  @override
  Future<Result<String?>> resolvePlayablePath(String assetId) async =>
      const Success(null);

  @override
  Future<Result<int>> resolvePhotoSizeBytes(String assetId) async =>
      const Success(0);
}
