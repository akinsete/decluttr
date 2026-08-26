enum TrashItemType { photo, contact }

class TrashItem {
  const TrashItem({
    required this.id,
    required this.type,
    required this.title,
    required this.subtitle,
    required this.deletedAt,
    this.monthKey,
    this.initial,
    this.isVideo = false,
    this.durationLabel,
    this.sizeBytes = 0,
    this.gradientIndex = 0,
  });

  final String id;
  final TrashItemType type;
  final String title;
  final String subtitle;
  final DateTime deletedAt;
  final String? monthKey;
  final String? initial;
  final bool isVideo;
  final String? durationLabel;
  final int sizeBytes;
  final int gradientIndex;

  int daysUntilPurge({DateTime? now}) {
    final current = now ?? DateTime.now();
    final purgeAt = deletedAt.add(const Duration(days: 30));
    final remaining = purgeAt.difference(current).inDays;
    return remaining.clamp(0, 30);
  }
}
