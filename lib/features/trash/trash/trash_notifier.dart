import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/di/providers.dart';
import '../../shared/domain/entities/trash_item.dart';
import 'trash_state.dart';

class TrashUiNotifier extends Notifier<TrashUiState> {
  @override
  TrashUiState build() {
    Future.microtask(_load);
    return const TrashUiState();
  }

  Future<void> _load() async {
    final repo = ref.read(trashRepositoryProvider);
    final items = await repo.fetchAll();
    final bytes = await repo.reclaimableBytes();
    state = state.copyWith(
      items: items,
      isLoading: false,
      reclaimableLabel: _formatBytes(bytes),
    );
  }

  void setTab(TrashTab tab) {
    state = state.copyWith(tab: tab, selectMode: false, selectedIds: {});
  }

  void toggleSelectMode() {
    state = state.copyWith(selectMode: !state.selectMode, selectedIds: {});
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
    await _load();
    state = state.copyWith(selectMode: false, selectedIds: {});
  }

  Future<void> deleteForeverSelected() async {
    final ids = state.selectedIds.isEmpty
        ? filteredItems.map((i) => i.id).toList()
        : state.selectedIds.toList();
    await ref.read(trashRepositoryProvider).deleteForever(ids);
    await _load();
    state = state.copyWith(selectMode: false, selectedIds: {});
  }

  List<TrashItem> get filteredItems {
    final type = state.tab == TrashTab.photos
        ? TrashItemType.photo
        : TrashItemType.contact;
    return state.items.where((i) => i.type == type).toList();
  }

  String _formatBytes(int bytes) {
    if (bytes < 1000000) {
      return '${(bytes / 1000).toStringAsFixed(1)} KB';
    }
    return '${(bytes / 1000000).toStringAsFixed(1)} MB';
  }
}

final trashUiProvider = NotifierProvider<TrashUiNotifier, TrashUiState>(
  TrashUiNotifier.new,
);
