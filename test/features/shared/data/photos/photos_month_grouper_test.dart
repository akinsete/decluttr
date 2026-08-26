import 'package:decluttr/features/shared/data/photos/photos_month_grouper.dart';
import 'package:decluttr/features/shared/domain/entities/batch_item.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('monthKeyForDate', () {
    test('formats year and zero-padded month', () {
      expect(monthKeyForDate(DateTime(2026, 5, 3)), '2026-05');
      expect(monthKeyForDate(DateTime(2025, 11, 30)), '2025-11');
    });
  });

  group('parseMonthKey', () {
    test('parses valid keys', () {
      expect(parseMonthKey('2026-05'), (2026, 5));
    });

    test('rejects invalid keys', () {
      expect(parseMonthKey('dup'), isNull);
      expect(parseMonthKey('2026-13'), isNull);
      expect(parseMonthKey('2026'), isNull);
    });
  });

  group('incrementMonthCount', () {
    test('groups assets by month', () {
      var counts = <String, int>{};
      counts = incrementMonthCount(counts, DateTime(2026, 5, 1));
      counts = incrementMonthCount(counts, DateTime(2026, 5, 2));
      counts = incrementMonthCount(counts, DateTime(2026, 4, 1));

      expect(counts, {'2026-05': 2, '2026-04': 1});
    });

    test('ignores assets without create date', () {
      expect(incrementMonthCount({}, null), isEmpty);
    });
  });

  group('batchItemsFromMonthCounts', () {
    test('returns batches sorted newest first with gradient indices', () {
      final batches = batchItemsFromMonthCounts({
        '2026-03': 24,
        '2026-05': 7,
        '2026-04': 12,
      });

      expect(batches.map((b) => b.id), ['2026-05', '2026-04', '2026-03']);
      expect(batches.first.count, 7);
      expect(batches.first.kind, BatchKind.photos);
      expect(batches[0].gradientIndex, 0);
      expect(batches[1].gradientIndex, 1);
      expect(batches[2].gradientIndex, 2);
    });

    test('returns empty list for no counts', () {
      expect(batchItemsFromMonthCounts({}), isEmpty);
    });
  });

  group('assetCreatedInMonth', () {
    test('matches year and month only', () {
      expect(
        assetCreatedInMonth(DateTime(2026, 5, 31), 2026, 5),
        isTrue,
      );
      expect(
        assetCreatedInMonth(DateTime(2026, 4, 30), 2026, 5),
        isFalse,
      );
      expect(assetCreatedInMonth(null, 2026, 5), isFalse);
    });
  });
}
