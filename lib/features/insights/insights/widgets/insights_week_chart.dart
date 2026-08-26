import 'package:flutter/material.dart';

import '../../../../core/testing/widget_keys.dart';
import '../../../../core/theme/theme.dart';

class InsightsWeekChart extends StatelessWidget {
  const InsightsWeekChart({
    super.key,
    required this.counts,
    required this.todayIndex,
    required this.weekdayLabels,
  });

  final List<int> counts;
  final int todayIndex;
  final List<String> weekdayLabels;

  @override
  Widget build(BuildContext context) {
    final dt = context.decluttrTheme;
    final typography = context.decluttrTypography;
    final maxCount = counts.fold<int>(0, (max, value) => value > max ? value : max);

    return DecoratedBox(
      key: WidgetKeys.insightsWeekChart,
      decoration: BoxDecoration(
        color: dt.white,
        borderRadius: BorderRadius.circular(dt.radiusLg),
        boxShadow: dt.shadowSm,
      ),
      child: Padding(
        padding: EdgeInsets.fromLTRB(dt.x4, dt.x4 + dt.x1, dt.x4, dt.x4),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            for (var i = 0; i < counts.length; i++) ...[
              if (i > 0) SizedBox(width: dt.x2),
              Expanded(
                child: _DayBar(
                  count: counts[i],
                  maxCount: maxCount,
                  label: weekdayLabels[i],
                  isToday: i == todayIndex,
                  barColor: dt.pinkHot,
                  mutedBarColor: dt.pinkHot.withValues(alpha: 0.18),
                  labelStyle: typography.streakWeekdayLetter.copyWith(
                    color: i == todayIndex ? dt.ink : dt.walkthroughMuted,
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class _DayBar extends StatelessWidget {
  const _DayBar({
    required this.count,
    required this.maxCount,
    required this.label,
    required this.isToday,
    required this.barColor,
    required this.mutedBarColor,
    required this.labelStyle,
  });

  final int count;
  final int maxCount;
  final String label;
  final bool isToday;
  final Color barColor;
  final Color mutedBarColor;
  final TextStyle labelStyle;

  @override
  Widget build(BuildContext context) {
    final dt = context.decluttrTheme;
    final chartHeight = dt.x11;
    final normalized = maxCount == 0 ? 0.0 : count / maxCount;
    final barHeight = count == 0 ? dt.x1 : (chartHeight * normalized).clamp(dt.x3, chartHeight);

    return Column(
      children: [
        SizedBox(
          height: chartHeight,
          child: Align(
            alignment: Alignment.bottomCenter,
            child: AnimatedContainer(
              duration: AppMotion.standard,
              curve: AppMotion.standardCurve,
              width: double.infinity,
              height: barHeight,
              decoration: BoxDecoration(
                color: isToday ? barColor : mutedBarColor,
                borderRadius: BorderRadius.circular(dt.radiusXs),
              ),
            ),
          ),
        ),
        SizedBox(height: dt.x2),
        Text(label, style: labelStyle),
      ],
    );
  }
}
