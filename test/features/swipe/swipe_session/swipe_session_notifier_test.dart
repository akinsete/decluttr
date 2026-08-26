import 'package:decluttr/core/di/app_state.dart';
import 'package:decluttr/core/di/providers.dart';
import 'package:decluttr/core/error/result.dart';
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
import 'package:shared_preferences/shared_preferences.dart';

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
  Future<void> remove(String id) async {
    items.removeWhere((item) => item.id == id);
  }

  @override
  Future<void> restore(List<String> ids) async {
    items.removeWhere((item) => ids.contains(item.id));
  }
}

class _MemoryPhotosRepository implements PhotosRepository {
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
      const Success([]);

  @override
  Future<Result<PhotoBatchPage>> fetchPhotosForBatchPage(
    String batchId, {
    required int offset,
    required int limit,
  }) async =>
      const Success(PhotoBatchPage(items: [], totalCount: 0, hasMore: false));

  @override
  Future<Result<bool>> hasPermission() async => const Success(true);

  @override
  Future<Result<bool>> requestPermission() async => const Success(true);
}
