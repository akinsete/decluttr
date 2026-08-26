import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/di/providers.dart';
import '../../../../core/error/result.dart';
import '../../shared/domain/entities/batch_item.dart';

class BatchPhotosNotifier extends AsyncNotifier<List<BatchItem>> {
  @override
  Future<List<BatchItem>> build() async {
    final result = await ref.read(photosRepositoryProvider).fetchBatches();
    if (result is Success<List<BatchItem>>) {
      return result.value
          .where((b) => !b.cleared && (b.isDuplicates || b.count > 0))
          .toList();
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

final batchPhotosProvider =
    AsyncNotifierProvider<BatchPhotosNotifier, List<BatchItem>>(
  BatchPhotosNotifier.new,
);
