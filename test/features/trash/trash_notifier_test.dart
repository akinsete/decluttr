import 'package:decluttr/core/di/providers.dart';
import 'package:decluttr/core/di/trash_dock_badge_providers.dart';
import 'package:decluttr/core/error/result.dart';
import 'package:decluttr/features/shared/domain/entities/trash_item.dart';
import 'package:decluttr/features/shared/domain/repositories/trash_repository.dart';
import 'package:decluttr/features/trash/trash/trash_notifier.dart';
import 'package:decluttr/features/trash/trash/trash_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../helpers/mock_providers.dart';

void main() {
  provideDummy<Result<void>>(const Success(null));
  provideDummy<Result<int>>(const Success(0));

  group('TrashUiNotifier', () {
    test('refresh reloads items when trash revision bumps', () async {
      final repo = _MutableTrashRepository();
      final container = ProviderContainer(
        overrides: [
          trashRepositoryProvider.overrideWithValue(repo),
        ],
      );
      addTearDown(container.dispose);

      await Future<void>.delayed(Duration.zero);
      expect(container.read(trashUiProvider).items, isEmpty);

      repo.items.add(
        TrashItem(
          id: 'p1',
          type: TrashItemType.photo,
          title: 'One',
          subtitle: '1 MB',
          deletedAt: DateTime.now(),
        ),
      );
      container.read(trashRevisionProvider.notifier).bump();
      await Future<void>.delayed(Duration.zero);

      expect(container.read(trashUiProvider).items, hasLength(1));
      expect(container.read(trashUiProvider.notifier).photoCount, 1);
    });

    test('selectAllFiltered selects every item on the active tab', () {
      final container = ProviderContainer(
        overrides: [trashUiProvider.overrideWith(_PopulatedTrashUi.new)],
      );
      addTearDown(container.dispose);

      container.read(trashUiProvider.notifier).selectAllFiltered();

      final state = container.read(trashUiProvider);
      expect(state.selectMode, isTrue);
      expect(state.selectedIds, {'p1', 'p2', 'p3'});
      expect(container.read(trashUiProvider.notifier).allFilteredSelected, isTrue);
    });

    test('deselectAllFiltered clears selected ids', () {
      final container = ProviderContainer(
        overrides: [trashUiProvider.overrideWith(_PopulatedTrashUi.new)],
      );
      addTearDown(container.dispose);

      final notifier = container.read(trashUiProvider.notifier);
      notifier.selectAllFiltered();
      notifier.deselectAllFiltered();

      final state = container.read(trashUiProvider);
      expect(state.selectMode, isTrue);
      expect(state.selectedIds, isEmpty);
      expect(notifier.allFilteredSelected, isFalse);
    });

    test('deleteForever resolves zero sizeBytes before committing', () async {
      final photos = MockPhotosRepository();
      final stats = MockSwipeStatsRepository();
      when(photos.deletePhotos(any)).thenAnswer((_) async => const Success(null));
      when(photos.resolvePhotoSizeBytes('zero')).thenAnswer((_) async => const Success(4_200_000));
      when(stats.recordCommittedDeletedBytes(any)).thenAnswer((_) async {});

      final container = ProviderContainer(
        overrides: [
          photosRepositoryProvider.overrideWithValue(photos),
          swipeStatsRepositoryProvider.overrideWithValue(stats),
          trashRepositoryProvider.overrideWithValue(_MutableTrashRepository()),
          trashUiProvider.overrideWith(_ZeroSizePhotoTrashUi.new),
        ],
      );
      addTearDown(container.dispose);

      final notifier = container.read(trashUiProvider.notifier);
      notifier.selectAllFiltered();
      final ok = await notifier.deleteForeverSelected();

      expect(ok, isTrue);
      verify(photos.resolvePhotoSizeBytes('zero')).called(1);
      verify(stats.recordCommittedDeletedBytes(4_200_000)).called(1);
    });
  });
}

class _MutableTrashRepository implements TrashRepository {
  final items = <TrashItem>[];

  @override
  Future<void> add(TrashItem item) async {
    items.removeWhere((existing) => existing.id == item.id);
    items.insert(0, item);
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
      items.where((item) => item.deletedAt.isBefore(DateTime.now().subtract(maxAge))).toList();

  @override
  Future<void> remove(String id) async {
    items.removeWhere((item) => item.id == id);
  }

  @override
  Future<void> restore(List<String> ids) async {
    items.removeWhere((item) => ids.contains(item.id));
  }
}

class _PopulatedTrashUi extends TrashUiNotifier {
  @override
  TrashUiState build() {
    return TrashUiState(
      isLoading: false,
      items: [
        TrashItem(
          id: 'p1',
          type: TrashItemType.photo,
          title: 'One',
          subtitle: '1 MB',
          deletedAt: DateTime(2024, 5, 1),
        ),
        TrashItem(
          id: 'p2',
          type: TrashItemType.photo,
          title: 'Two',
          subtitle: '1 MB',
          deletedAt: DateTime(2024, 5, 2),
        ),
        TrashItem(
          id: 'p3',
          type: TrashItemType.photo,
          title: 'Three',
          subtitle: '1 MB',
          deletedAt: DateTime(2024, 5, 3),
        ),
        TrashItem(
          id: 'c1',
          type: TrashItemType.contact,
          title: 'Alex',
          subtitle: '555',
          deletedAt: DateTime(2024, 5, 4),
        ),
      ],
    );
  }
}

class _ZeroSizePhotoTrashUi extends TrashUiNotifier {
  @override
  TrashUiState build() {
    return TrashUiState(
      isLoading: false,
      items: [
        TrashItem(
          id: 'zero',
          type: TrashItemType.photo,
          title: 'Unknown size',
          subtitle: 'May 2024',
          deletedAt: DateTime(2024, 5, 1),
          sizeBytes: 0,
        ),
      ],
    );
  }

  @override
  Future<void> refresh() async {}
}
