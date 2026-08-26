import 'package:intl/intl.dart';

import '../../shared/domain/entities/trash_item.dart';

class TrashMonthGroup {
  const TrashMonthGroup({
    required this.monthLabel,
    required this.items,
  });

  final String monthLabel;
  final List<TrashItem> items;
}

List<TrashMonthGroup> groupTrashPhotosByMonth(List<TrashItem> items) {
  final sorted = [...items]..sort((a, b) => b.deletedAt.compareTo(a.deletedAt));
  final buckets = <String, List<TrashItem>>{};

  for (final item in sorted) {
    final key = item.monthKey ?? _monthBucketKey(item.deletedAt);
    buckets.putIfAbsent(key, () => []).add(item);
  }

  final keys = buckets.keys.toList()
    ..sort((a, b) => b.compareTo(a));

  return keys
      .map(
        (key) => TrashMonthGroup(
          monthLabel: _labelForMonthKey(key, buckets[key]!.first.deletedAt),
          items: buckets[key]!,
        ),
      )
      .toList();
}

List<TrashMonthGroup> groupTrashContactsByMonth(List<TrashItem> items) {
  final sorted = [...items]..sort((a, b) => b.deletedAt.compareTo(a.deletedAt));
  final buckets = <String, List<TrashItem>>{};

  for (final item in sorted) {
    final key = _monthBucketKey(item.deletedAt);
    buckets.putIfAbsent(key, () => []).add(item);
  }

  final keys = buckets.keys.toList()
    ..sort((a, b) => b.compareTo(a));

  return keys
      .map(
        (key) => TrashMonthGroup(
          monthLabel: _labelForMonthKey(key, buckets[key]!.first.deletedAt),
          items: buckets[key]!,
        ),
      )
      .toList();
}

String _monthBucketKey(DateTime date) =>
    '${date.year}-${date.month.toString().padLeft(2, '0')}';

String _labelForMonthKey(String key, DateTime fallback) {
  final parts = key.split('-');
  if (parts.length == 2) {
    final year = int.tryParse(parts[0]);
    final month = int.tryParse(parts[1]);
    if (year != null && month != null) {
      return DateFormat.yMMMM().format(DateTime(year, month));
    }
  }
  return DateFormat.yMMMM().format(fallback);
}
