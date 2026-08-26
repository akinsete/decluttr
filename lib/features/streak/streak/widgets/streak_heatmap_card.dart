import 'package:flutter/material.dart';

import '../../../../core/theme/theme.dart';

/// Five-week activity heatmap card with Less/More legend.
class StreakHeatmapCard extends StatelessWidget {
  const StreakHeatmapCard({
    super.key,
    required this.title,
    required this.rangeHint,
    required this.lessLabel,
    required this.moreLabel,
    required this.levels,
    required this.todayIndex,
  });

  final String title;
  final String rangeHint;
  final String lessLabel;
  final String moreLabel;
  final List<int> levels;
  final int todayIndex;

  static const _legendLevels = [0, 1, 2, 3, 5];

  @override
  Widget build(BuildContext context) {
    final dt = context.decluttrTheme;
    final typography = context.decluttrTypography;

    return DecoratedBox(
      decoration: BoxDecoration(
        color: dt.white,
        borderRadius: BorderRadius.circular(dt.radiusXl),
        boxShadow: const [
          BoxShadow(
            color: Color(0x0D8C786E),
            blurRadius: 14,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: dt.x4 + dt.x1, vertical: dt.x4),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(title, style: typography.moduleCardTitle),
                ),
                Text(rangeHint, style: typography.streakHeatmapMeta),
              ],
            ),
            SizedBox(height: dt.x3),
            Column(
              children: List.generate(5, (week) {
                return Padding(
                  padding: EdgeInsets.only(bottom: week == 4 ? 0 : dt.x1 + dt.x1),
                  child: Row(
                    children: List.generate(7, (day) {
                      final index = week * 7 + day;
                      final level = index < levels.length ? levels[index] : 0;
                      final isToday = index == todayIndex;
                      return Expanded(
                        child: Padding(
                          padding: EdgeInsets.only(right: day == 6 ? 0 : dt.x1 + dt.x1),
                          child: AspectRatio(
                            aspectRatio: 1,
                            child: _HeatmapCell(
                              level: level,
                              isToday: isToday,
                            ),
                          ),
                        ),
                      );
                    }),
                  ),
                );
              }),
            ),
            SizedBox(height: dt.x3),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(lessLabel, style: typography.streakLegendLabel),
                SizedBox(width: dt.x1 + dt.x1),
                ..._legendLevels.map((level) {
                  return Padding(
                    padding: EdgeInsets.only(right: dt.x1),
                    child: _HeatmapCell(level: level, compact: true),
                  );
                }),
                SizedBox(width: dt.x1),
                Text(moreLabel, style: typography.streakLegendLabel),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _HeatmapCell extends StatelessWidget {
  const _HeatmapCell({
    required this.level,
    this.isToday = false,
    this.compact = false,
  });

  final int level;
  final bool isToday;
  final bool compact;

  @override
  Widget build(BuildContext context) {
    final dt = context.decluttrTheme;
    final color = Color.lerp(
      dt.streakFill,
      dt.pinkHot,
      level / 5,
    );

    return DecoratedBox(
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(compact ? dt.radiusXs - 4 : dt.radiusXs - 6),
        border: isToday
            ? Border.all(color: dt.pinkHot, width: dt.x1 - 2)
            : null,
        boxShadow: isToday
            ? [
                BoxShadow(
                  color: dt.white,
                  spreadRadius: dt.x1 - 3,
                ),
              ]
            : null,
      ),
    );
  }
}
