import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/di/trash_dock_badge_providers.dart';
import '../../../../core/di/providers.dart';
import '../../shared/data/photos/photo_load_log.dart';
import '../../../../core/error/result.dart';
import '../../shared/domain/entities/photo_size_formatter.dart';
import '../../shared/domain/entities/trash_item.dart';
import 'trash_month_grouper.dart';
import 'trash_state.dart';

class TrashUiNotifier extends Notifier<TrashUiState> {
  @override
  TrashUiState build() {
    ref.listen(trashRevisionProvider, (previous, next) {
      if (previous != next) {
        Future.microtask(refresh);
      }
    });
    Future.microtask(refresh);
    return const TrashUiState();
  }

  Future<void> refresh() async {
    photoLoadLog('TrashUi.refresh start count=${state.items.length}');
    await purgeExpired();
    final repo = ref.read(trashRepositoryProvider);
    final items = await repo.fetchAll();
    state = state.copyWith(
      items: items,
      isLoading: false,
    );
    photoLoadLog(
      'TrashUi.refresh done photos=$photoCount contacts=$contactCount',
    );
  }

  /// Permanently removes trash older than 30 days (device + prefs).
  Future<void> purgeExpired() async {
    final expired = await ref.read(trashRepositoryProvider).fetchExpired();
    if (expired.isEmpty) return;
    await _deleteItemsForever(expired);
  }

  void setTab(TrashTab tab) {
    state = state.copyWith(tab: tab, selectMode: false, selectedIds: {});
  }

  void enterSelectMode() {
    state = state.copyWith(selectMode: true, selectedIds: {});
  }

  void selectAllFiltered() {
    state = state.copyWith(
      selectMode: true,
      selectedIds: filteredItems.map((item) => item.id).toSet(),
    );
  }

  void deselectAllFiltered() {
    state = state.copyWith(selectedIds: {});
  }

  bool get allFilteredSelected {
    final items = filteredItems;
    if (items.isEmpty) return false;
    return items.every((item) => state.selectedIds.contains(item.id));
  }

  void exitSelectMode() {
    state = state.copyWith(selectMode: false, selectedIds: {});
  }

  void toggleSelection(String id) {
    final selected = Set<String>.from(state.selectedIds);
    if (selected.contains(id)) {
      selected.remove(id);
    } else {
      selected.add(id);
    }
    state = state.copyWith(selectedIds: selected, selectMode: true);
  }

  Future<void> restoreSelected() async {
    if (state.selectedIds.isEmpty) return;
    await ref.read(trashRepositoryProvider).restore(state.selectedIds.toList());
    bumpTrashDockBadge(ref);
    await refresh();
    state = state.copyWith(selectMode: false, selectedIds: {});
  }

  Future<bool> deleteForeverSelected() async {
    final ids = state.selectedIds.isEmpty
        ? filteredItems.map((i) => i.id).toList()
        : state.selectedIds.toList();
    if (ids.isEmpty) return true;

    final items = state.items.where((item) => ids.contains(item.id)).toList();
    final ok = await _deleteItemsForever(items);
    if (!ok) return false;
    await refresh();
    state = state.copyWith(selectMode: false, selectedIds: {});
    return true;
  }

  Future<bool> _deleteItemsForever(List<TrashItem> items) async {
    if (items.isEmpty) return true;

    final photoItems = items.where((item) => item.type == TrashItemType.photo).toList();
    final photoIds = photoItems.map((item) => item.id).toList();
    if (photoIds.isNotEmpty) {
      final result = await ref.read(photosRepositoryProvider).deletePhotos(photoIds);
      if (result is FailureResult<void>) return false;
      final committedBytes = await _committedPhotoBytes(photoItems);
      await ref.read(swipeStatsRepositoryProvider).recordCommittedDeletedBytes(committedBytes);
    }

    for (final contact in items.where((item) => item.type == TrashItemType.contact)) {
      final result = await ref.read(contactsRepositoryProvider).deleteContact(contact.id);
      if (result is FailureResult<void>) return false;
    }

    await ref.read(trashRepositoryProvider).deleteForever(items.map((i) => i.id).toList());
    bumpTrashDockBadge(ref);
    return true;
  }

  /// Prefer stored sizes; re-resolve when swipe stored 0 so Insights isn't undercounted.
  Future<int> _committedPhotoBytes(List<TrashItem> photoItems) async {
    var total = 0;
    final photos = ref.read(photosRepositoryProvider);
    for (final item in photoItems) {
      var bytes = item.sizeBytes;
      if (bytes <= 0) {
        final sized = await photos.resolvePhotoSizeBytes(item.id);
        bytes = sized.valueOrNull ?? 0;
      }
      total += bytes;
    }
    return total;
  }

  List<TrashItem> get filteredItems {
    final type = state.tab == TrashTab.photos
        ? TrashItemType.photo
        : TrashItemType.contact;
    return state.items.where((i) => i.type == type).toList();
  }

  int get photoCount =>
      state.items.where((item) => item.type == TrashItemType.photo).length;

  int get contactCount =>
      state.items.where((item) => item.type == TrashItemType.contact).length;

  List<TrashMonthGroup> get photoGroups =>
      groupTrashPhotosByMonth(state.items.where((i) => i.type == TrashItemType.photo).toList());

  List<TrashMonthGroup> get contactGroups =>
      groupTrashContactsByMonth(state.items.where((i) => i.type == TrashItemType.contact).toList());

  int get tabReclaimableBytes => filteredItems.fold<int>(
        0,
        (sum, item) => sum + item.sizeBytes,
      );

  String tabReclaimableLabel([String? localeName]) =>
      formatPhotoSizeBytes(tabReclaimableBytes, localeName);
}

final trashUiProvider = NotifierProvider<TrashUiNotifier, TrashUiState>(
  TrashUiNotifier.new,
);
