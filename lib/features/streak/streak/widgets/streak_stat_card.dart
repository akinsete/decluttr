import 'package:flutter/material.dart';

import '../../../../core/formatting/display_number_formatter.dart';
import '../../../../core/theme/theme.dart';

/// Compact stat tile for longest streak and items cleaned.
class StreakStatCard extends StatelessWidget {
  const StreakStatCard({
    super.key,
    required this.value,
    required this.label,
  });

  final int value;
  final String label;

  @override
  Widget build(BuildContext context) {
    final dt = context.decluttrTheme;
    final typography = context.decluttrTypography;

    return Expanded(
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: dt.white,
          borderRadius: BorderRadius.circular(dt.radiusLg),
          boxShadow: const [
            BoxShadow(
              color: Color(0x0D8C786E),
              blurRadius: 14,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: dt.x3 + dt.x1,
            vertical: dt.x3 + dt.x1,
          ),
          child: Column(
            children: [
              Text(
                context.formatDisplayCount(value),
                style: typography.streakStatCount,
              ),
              SizedBox(height: dt.x1 - 1),
              Text(label, textAlign: TextAlign.center, style: typography.streakStatLabel),
            ],
          ),
        ),
      ),
    );
  }
}
