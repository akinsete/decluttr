import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/di/providers.dart';
import '../../../../core/error/result.dart';
import '../../shared/domain/entities/duplicate_group.dart';
import 'duplicate_contacts_state.dart';

class DuplicateContactsNotifier extends AsyncNotifier<DuplicateContactsState> {
  @override
  Future<DuplicateContactsState> build() async {
    final result =
        await ref.read(contactsRepositoryProvider).fetchDuplicateGroups();
    final groups = result is Success ? result.value : <DuplicateGroup>[];
    return DuplicateContactsState(groups: groups);
  }

  Future<void> mergeCurrent() async {
    final current = state.value;
    if (current == null || current.groups.isEmpty) return;
    final group = current.groups[current.index];
    await ref.read(contactsRepositoryProvider).mergeDuplicateGroup(group.id);
    _advance(current, merged: 1);
  }

  Future<void> keepBoth() async {
    final current = state.value;
    if (current == null || current.groups.isEmpty) return;
    final group = current.groups[current.index];
    await ref.read(contactsRepositoryProvider).keepBothDuplicateGroup(group.id);
    _advance(current, kept: 1);
  }

  Future<void> deleteOne() async {
    final current = state.value;
    if (current == null || current.groups.isEmpty) return;
    final group = current.groups[current.index];
    await ref
        .read(contactsRepositoryProvider)
        .deleteOneFromDuplicateGroup(group.id);
    _advance(current, deleted: 1);
  }

  void _advance(
    DuplicateContactsState current, {
    int merged = 0,
    int kept = 0,
    int deleted = 0,
  }) {
    final nextIndex = current.index + 1;
    state = AsyncData(
      current.copyWith(
        index: nextIndex,
        merged: current.merged + merged,
        kept: current.kept + kept,
        deleted: current.deleted + deleted,
        isComplete: nextIndex >= current.groups.length,
      ),
    );
  }
}

final duplicateContactsProvider = AsyncNotifierProvider<
    DuplicateContactsNotifier, DuplicateContactsState>(
  DuplicateContactsNotifier.new,
);
