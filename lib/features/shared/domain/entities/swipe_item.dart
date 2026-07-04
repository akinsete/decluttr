enum SwipeDecision { keep, delete, undo }

class SwipeItem {
  const SwipeItem({
    required this.id,
    required this.title,
    required this.subtitle,
    this.gradientIndex = 0,
    this.detailBody,
  });

  final String id;
  final String title;
  final String subtitle;
  final int gradientIndex;
  final String? detailBody;

  SwipeItem copyWith({
    String? title,
    String? subtitle,
    int? gradientIndex,
    String? detailBody,
  }) {
    return SwipeItem(
      id: id,
      title: title ?? this.title,
      subtitle: subtitle ?? this.subtitle,
      gradientIndex: gradientIndex ?? this.gradientIndex,
      detailBody: detailBody ?? this.detailBody,
    );
  }
}
