import 'package:flutter/material.dart';
import 'package:phosphoricons_flutter/phosphoricons_flutter.dart';

import '../../../../core/theme/theme.dart';

/// Weekday strip with M–S labels and completed-day checkmarks.
class StreakWeekStrip extends StatelessWidget {
  const StreakWeekStrip({
    super.key,
    required this.weekdayLabels,
    required this.weekActivity,
    required this.todayIndex,
  });

  final List<String> weekdayLabels;
  final List<bool> weekActivity;
  final int todayIndex;

  @override
  Widget build(BuildContext context) {
    final dt = context.decluttrTheme;
    final typography = context.decluttrTypography;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: List.generate(weekdayLabels.length, (index) {
        final active = weekActivity[index];
        return Column(
          children: [
            Text(weekdayLabels[index], style: typography.streakWeekdayLetter),
            SizedBox(height: dt.x2 + dt.x1),
            _WeekdayDot(active: active, highlighted: index == todayIndex),
          ],
        );
      }),
    );
  }
}

class _WeekdayDot extends StatelessWidget {
  const _WeekdayDot({
    required this.active,
    required this.highlighted,
  });

  final bool active;
  final bool highlighted;

  @override
  Widget build(BuildContext context) {
    final dt = context.decluttrTheme;
    final size = dt.x7 + dt.x1;

    if (active) {
      return Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [dt.walkthroughDelete, dt.pinkHot],
          ),
        ),
        child: Icon(
          PhosphorIconsRegular.check,
          color: dt.white,
          size: dt.x3 + dt.x1,
        ),
      );
    }

    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color: highlighted ? dt.pinkHot : dt.streakBorder,
          width: highlighted ? dt.x1 - 1 : dt.x1 - 2,
        ),
      ),
    );
  }
}
