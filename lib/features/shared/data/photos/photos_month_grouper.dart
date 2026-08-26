import 'package:intl/intl.dart';
import 'package:photo_manager/photo_manager.dart';

import '../../domain/entities/batch_item.dart';

const photosMonthScanPageSize = 500;

/// Stable `YYYY-MM` key for grouping and batch ids.
String monthKeyForDate(DateTime date) =>
    '${date.year}-${date.month.toString().padLeft(2, '0')}';

(int year, int month)? parseMonthKey(String batchId) {
  final parts = batchId.split('-');
  if (parts.length != 2) return null;
  final year = int.tryParse(parts[0]);
  final month = int.tryParse(parts[1]);
  if (year == null || month == null || month < 1 || month > 12) {
    return null;
  }
  return (year, month);
}

bool assetCreatedInMonth(DateTime? created, int year, int month) {
  if (created == null) return false;
  return created.year == year && created.month == month;
}

/// Native library filter for a single calendar month (avoids scanning unrelated assets).
FilterOptionGroup monthFilterOption(int year, int month) {
  return FilterOptionGroup(
    createTimeCond: DateTimeCond(
      min: DateTime(year, month, 1),
      max: DateTime(year, month + 1, 0, 23, 59, 59, 999),
    ),
    orders: const [
      OrderOption(type: OrderOptionType.createDate, asc: false),
    ],
  );
}

/// Merges one asset's month into running counts.
Map<String, int> incrementMonthCount(
  Map<String, int> counts,
  DateTime? created,
) {
  if (created == null) return counts;
  final key = monthKeyForDate(created);
  return {...counts, key: (counts[key] ?? 0) + 1};
}

List<BatchItem> batchItemsFromMonthCounts(Map<String, int> monthCounts) {
  if (monthCounts.isEmpty) return const [];

  final keys = monthCounts.keys.toList()..sort((a, b) => b.compareTo(a));
  final titleFormat = DateFormat.yMMMM();

  return keys.asMap().entries.map((entry) {
    final key = entry.value;
    final count = monthCounts[key]!;
    final parsed = parseMonthKey(key)!;
    final title = titleFormat.format(DateTime(parsed.$1, parsed.$2));

    return BatchItem(
      id: key,
      kind: BatchKind.photos,
      title: title,
      subtitle: '$count photos',
      count: count,
      gradientIndex: entry.key,
    );
  }).toList();
}
