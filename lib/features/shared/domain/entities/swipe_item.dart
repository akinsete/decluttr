enum SwipeDecision { keep, delete, undo }

class SwipeItem {
  const SwipeItem({
    required this.id,
    required this.title,
    required this.subtitle,
    this.gradientIndex = 0,
    this.detailBody,
    this.sizeBytes = 0,
  });

  final String id;
  final String title;
  final String subtitle;
  final int gradientIndex;
  final String? detailBody;
  final int sizeBytes;

  SwipeItem copyWith({
    String? title,
    String? subtitle,
    int? gradientIndex,
    String? detailBody,
    int? sizeBytes,
  }) {
    return SwipeItem(
      id: id,
      title: title ?? this.title,
      subtitle: subtitle ?? this.subtitle,
      gradientIndex: gradientIndex ?? this.gradientIndex,
      detailBody: detailBody ?? this.detailBody,
      sizeBytes: sizeBytes ?? this.sizeBytes,
    );
  }
}
