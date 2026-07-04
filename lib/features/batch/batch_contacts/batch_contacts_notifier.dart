import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/di/providers.dart';
import '../../../../core/error/result.dart';
import '../../shared/domain/entities/batch_item.dart';

class BatchContactsNotifier extends AsyncNotifier<List<BatchItem>> {
  @override
  Future<List<BatchItem>> build() async {
    final result = await ref.read(contactsRepositoryProvider).fetchBatches();
    if (result is Success<List<BatchItem>>) {
      return result.value.where((b) => !b.cleared).toList();
    }
    return const [];
  }

  Future<void> markCleared(String batchId) async {
    final current = state.value ?? [];
    state = AsyncData(
      current.map((b) => b.id == batchId ? b.copyWith(cleared: true) : b).where((b) => !b.cleared).toList(),
    );
  }
}

final batchContactsProvider =
    AsyncNotifierProvider<BatchContactsNotifier, List<BatchItem>>(
  BatchContactsNotifier.new,
);
