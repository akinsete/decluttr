import 'package:decluttr/core/di/app_state.dart';
import 'package:decluttr/core/di/providers.dart';
import 'package:decluttr/core/di/trash_dock_badge_providers.dart';
import 'package:decluttr/core/error/result.dart';
import 'package:decluttr/features/home/home/home_vm_notifier.dart';
import 'package:decluttr/features/shared/domain/entities/batch_item.dart';
import 'package:decluttr/features/shared/domain/entities/contact_record.dart';
import 'package:decluttr/features/shared/domain/entities/duplicate_group.dart';
import 'package:decluttr/features/shared/domain/entities/insights_snapshot.dart';
import 'package:decluttr/features/shared/domain/entities/lifetime_swipe_stats.dart';
import 'package:decluttr/features/shared/domain/entities/photo_asset.dart';
import 'package:decluttr/features/shared/domain/entities/photo_batch_page.dart';
import 'package:decluttr/features/shared/domain/entities/swipe_session_record.dart';
import 'package:decluttr/features/shared/domain/entities/trash_item.dart';
import 'package:decluttr/features/shared/domain/repositories/contacts_repository.dart';
import 'package:decluttr/features/shared/domain/repositories/photos_repository.dart';
import 'package:decluttr/features/shared/domain/repositories/streak_repository.dart';
import 'package:decluttr/features/shared/domain/repositories/swipe_stats_repository.dart';
import 'package:decluttr/features/shared/domain/repositories/trash_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('home vm rebuilds when swipe stats revision bumps', () async {
    final statsRepo = _MutableSwipeStatsRepository();
    final container = ProviderContainer(
      overrides: [
        appStateProvider.overrideWith(_ReturningAppState.new),
        swipeStatsRepositoryProvider.overrideWithValue(statsRepo),
        streakRepositoryProvider.overrideWithValue(_FakeStreakRepository()),
        contactsRepositoryProvider.overrideWithValue(_EmptyContactsRepository()),
        photosRepositoryProvider.overrideWithValue(_EmptyPhotosRepository()),
        trashRepositoryProvider.overrideWithValue(_EmptyTrashRepository()),
      ],
    );
    addTearDown(container.dispose);

    await container.read(homeScreenVmProvider.future);
    expect(container.read(homeScreenVmProvider).value?.kept, 0);

    statsRepo.stats = const LifetimeSwipeStats(totalKept: 12, totalDeleted: 4);
    container.read(swipeStatsRevisionProvider.notifier).bump();

    final vm = await container.read(homeScreenVmProvider.future);
    expect(vm.kept, 12);
    expect(vm.deleted, 4);
  });

  test('home vm rebuilds when trash revision bumps', () async {
    final trashRepo = _MutableTrashRepository();
    final statsRepo = _MutableSwipeStatsRepository(
      stats: const LifetimeSwipeStats(photosKept: 2),
    );
    final container = ProviderContainer(
      overrides: [
        appStateProvider.overrideWith(_ReturningAppState.new),
        swipeStatsRepositoryProvider.overrideWithValue(statsRepo),
        streakRepositoryProvider.overrideWithValue(_FakeStreakRepository()),
        contactsRepositoryProvider.overrideWithValue(_EmptyContactsRepository()),
        photosRepositoryProvider.overrideWithValue(_PhotosBatchesRepository()),
        trashRepositoryProvider.overrideWithValue(trashRepo),
      ],
    );
    addTearDown(container.dispose);

    await container.read(homeScreenVmProvider.future);
    expect(container.read(homeScreenVmProvider).value?.photosCount, 98);

    trashRepo.photoTrashCount = 5;
    container.read(trashRevisionProvider.notifier).bump();

    final vm = await container.read(homeScreenVmProvider.future);
    expect(vm.photosCount, 93);
    expect(vm.itemsRemaining, 93);
  });
}

class _ReturningAppState extends AppStateNotifier {
  @override
  AppState build() => const AppState(
        isLoading: false,
        hasActivity: true,
        photosGranted: true,
      );
}

class _PhotosBatchesRepository implements PhotosRepository {
  @override
  Future<Result<List<BatchItem>>> fetchBatches() async => const Success([
        BatchItem(
          id: '2024-01',
          kind: BatchKind.photos,
          title: 'Jan',
          subtitle: 'Jan 2024',
          count: 100,
        ),
      ]);

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

  @override
  Future<Result<void>> deletePhotos(List<String> assetIds) async => const Success(null);
}

class _MutableTrashRepository implements TrashRepository {
  int photoTrashCount = 0;

  @override
  Future<void> add(TrashItem item) async {}

  @override
  Future<void> deleteForever(List<String> ids) async {}

  @override
  Future<List<TrashItem>> fetchAll() async => const [];

  @override
  Future<List<TrashItem>> fetchByType(TrashItemType type) async {
    if (type != TrashItemType.photo) return const [];
    return List.generate(
      photoTrashCount,
      (i) => TrashItem(
        id: 'p$i',
        type: TrashItemType.photo,
        title: 'Photo',
        subtitle: '',
        deletedAt: DateTime(2024),
      ),
    );
  }

  @override
  Future<int> reclaimableBytes({TrashItemType? type}) async => 0;

  @override
  Future<void> remove(String id) async {}

  @override
  Future<void> restore(List<String> ids) async {}
}

class _MutableSwipeStatsRepository implements SwipeStatsRepository {
  _MutableSwipeStatsRepository({this.stats = const LifetimeSwipeStats()});

  LifetimeSwipeStats stats;

  @override
  Future<LifetimeSwipeStats> getLifetimeStats() async => stats;

  @override
  Future<InsightsSnapshot> getInsightsSnapshot() async => const InsightsSnapshot();

  @override
  Future<void> recordCommittedDeletedBytes(int bytes) async {}

  @override
  Future<void> recordSession(SwipeSessionRecord session) async {
    stats = stats.applySession(session);
  }

  @override
  Future<void> syncPendingSessions() async {}
}

class _FakeStreakRepository implements StreakRepository {
  @override
  Future<int> currentStreak() async => 3;

  @override
  Future<int> longestStreak() async => 3;

  @override
  Future<List<bool>> weekActivity() async => List.filled(7, false);

  @override
  Future<List<int>> lastFiveWeeksHeatmap() async => List.filled(35, 0);

  @override
  Future<void> recordActivity() async {}
}

class _EmptyPhotosRepository implements PhotosRepository {
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

  @override
  Future<Result<void>> deletePhotos(List<String> assetIds) async => const Success(null);
}

class _EmptyContactsRepository implements ContactsRepository {
  @override
  Future<Result<List<BatchItem>>> fetchBatches() async => const Success([]);

  @override
  Future<Result<List<ContactRecord>>> fetchContactsForBatch(String batchId) async =>
      const Success([]);

  @override
  Future<Result<List<DuplicateGroup>>> fetchDuplicateGroups() async => const Success([]);

  @override
  Future<Result<bool>> hasPermission() async => const Success(true);

  @override
  Future<Result<bool>> requestPermission() async => const Success(true);

  @override
  Future<Result<void>> mergeDuplicateGroup(String groupId) async => const Success(null);

  @override
  Future<Result<void>> keepBothDuplicateGroup(String groupId) async => const Success(null);

  @override
  Future<Result<void>> deleteOneFromDuplicateGroup(String groupId) async =>
      const Success(null);

  @override
  Future<Result<void>> deleteContact(String contactId) async => const Success(null);
}

class _EmptyTrashRepository implements TrashRepository {
  @override
  Future<void> add(TrashItem item) async {}

  @override
  Future<void> deleteForever(List<String> ids) async {}

  @override
  Future<List<TrashItem>> fetchAll() async => const [];

  @override
  Future<List<TrashItem>> fetchByType(TrashItemType type) async => const [];

  @override
  Future<int> reclaimableBytes({TrashItemType? type}) async => 0;

  @override
  Future<void> remove(String id) async {}

  @override
  Future<void> restore(List<String> ids) async {}
}
