import 'package:flutter/material.dart';

import '../../../../core/formatting/display_number_formatter.dart';
import '../../../../core/theme/theme.dart';

class InsightsStatCard extends StatelessWidget {
  const InsightsStatCard({
    super.key,
    required this.icon,
    required this.count,
    required this.label,
    required this.accentColor,
  });

  final IconData icon;
  final int count;
  final String label;
  final Color accentColor;

  @override
  Widget build(BuildContext context) {
    final dt = context.decluttrTheme;
    final typography = context.decluttrTypography;

    return Expanded(
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: dt.white,
          borderRadius: BorderRadius.circular(dt.radiusLg),
          boxShadow: dt.shadowSm,
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: dt.x4,
            vertical: dt.x4 + dt.x1,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(icon, color: accentColor, size: dt.x5),
              SizedBox(height: dt.x3),
              Text(
                context.formatDisplayCount(count),
                style: typography.homeProgressSideCount,
              ),
              SizedBox(height: dt.x1),
              Text(
                label,
                style: typography.streakStatLabel.copyWith(color: accentColor),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
