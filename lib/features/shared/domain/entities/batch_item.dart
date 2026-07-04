enum BatchKind { photos, contacts }

class BatchItem {
  const BatchItem({
    required this.id,
    required this.kind,
    required this.title,
    required this.subtitle,
    required this.count,
    this.isDuplicates = false,
    this.gradientIndex = 0,
    this.cleared = false,
  });

  final String id;
  final BatchKind kind;
  final String title;
  final String subtitle;
  final int count;
  final bool isDuplicates;
  final int gradientIndex;
  final bool cleared;

  BatchItem copyWith({bool? cleared, int? count}) {
    return BatchItem(
      id: id,
      kind: kind,
      title: title,
      subtitle: subtitle,
      count: count ?? this.count,
      isDuplicates: isDuplicates,
      gradientIndex: gradientIndex,
      cleared: cleared ?? this.cleared,
    );
  }
}
