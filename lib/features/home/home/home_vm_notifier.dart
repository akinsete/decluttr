import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/di/providers.dart';
import '../../../../core/di/trash_dock_badge_providers.dart';
import '../../../../core/error/result.dart';
import '../../shared/domain/entities/trash_item.dart';

class HomeScreenVm {
  const HomeScreenVm({
    required this.isFirstVisit,
    required this.streakDays,
    required this.contactsCount,
    required this.photosCount,
    required this.itemsRemaining,
    required this.progress,
    required this.kept,
    required this.deleted,
    required this.isLoading,
  });

  final bool isFirstVisit;
  final int streakDays;
  final int contactsCount;
  final int photosCount;
  final int itemsRemaining;
  final double progress;
  final int kept;
  final int deleted;
  final bool isLoading;
}

class HomeScreenVmNotifier extends AsyncNotifier<HomeScreenVm> {
  @override
  Future<HomeScreenVm> build() async {
    final appState = ref.watch(appStateProvider);
    ref.watch(trashRevisionProvider);
    ref.watch(swipeStatsRevisionProvider);

    final streak = await ref.read(streakRepositoryProvider).currentStreak();
    final lifetimeStats = await ref.read(swipeStatsRepositoryProvider).getLifetimeStats();

    final contacts = appState.contactsGranted
        ? await ref.read(contactsRepositoryProvider).fetchBatches()
        : null;
    final photos = appState.photosGranted
        ? await ref.read(photosRepositoryProvider).fetchBatches()
        : null;

    final rawContactsCount =
        contacts?.valueOrNull?.fold<int>(0, (sum, b) => sum + b.count) ?? 0;
    final rawPhotosCount =
        photos?.valueOrNull?.fold<int>(0, (sum, b) => sum + b.count) ?? 0;

    final trashedPhotos = appState.photosGranted
        ? await ref.read(trashRepositoryProvider).fetchByType(TrashItemType.photo)
        : const <TrashItem>[];
    final trashedContacts = appState.contactsGranted
        ? await ref.read(trashRepositoryProvider).fetchByType(TrashItemType.contact)
        : const <TrashItem>[];

    final contactsCount = _waitingCount(
      rawContactsCount,
      trashedContacts.length,
      lifetimeStats.contactsKept,
    );
    final photosCount = _waitingCount(
      rawPhotosCount,
      trashedPhotos.length,
      lifetimeStats.photosKept,
    );
    final itemsRemaining = contactsCount + photosCount;
    final totalReviewed = lifetimeStats.totalKept + lifetimeStats.totalDeleted;
    final progressDenominator = totalReviewed + itemsRemaining;

    return HomeScreenVm(
      isFirstVisit: !appState.hasActivity,
      streakDays: streak,
      contactsCount: contactsCount,
      photosCount: photosCount,
      itemsRemaining: itemsRemaining,
      progress: progressDenominator > 0 ? totalReviewed / progressDenominator : 0,
      kept: lifetimeStats.totalKept,
      deleted: lifetimeStats.totalDeleted,
      isLoading: appState.isLoading,
    );
  }

  int _waitingCount(int batchTotal, int trashedCount, int keptCount) {
    final waiting = batchTotal - trashedCount - keptCount;
    return waiting < 0 ? 0 : waiting;
  }

  Future<void> refresh() async {
    state = const AsyncLoading();
    state = AsyncData(await build());
  }
}

final homeScreenVmProvider =
    AsyncNotifierProvider<HomeScreenVmNotifier, HomeScreenVm>(
  HomeScreenVmNotifier.new,
);
