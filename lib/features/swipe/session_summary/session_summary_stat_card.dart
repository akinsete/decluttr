import 'package:flutter/material.dart';

import '../../../core/formatting/display_number_formatter.dart';
import '../../../core/theme/theme.dart';

/// Kept / deleted count pill on the session summary screen.
class SessionSummaryStatCard extends StatelessWidget {
  const SessionSummaryStatCard({
    super.key,
    required this.count,
    required this.label,
    required this.countColor,
  });

  final int count;
  final String label;
  final Color countColor;

  @override
  Widget build(BuildContext context) {
    final dt = context.decluttrTheme;
    final typography = context.decluttrTypography;

    return DecoratedBox(
      decoration: BoxDecoration(
        color: dt.white,
        borderRadius: BorderRadius.circular(dt.radiusLg),
        boxShadow: const [
          BoxShadow(
            color: Color(0x128C786E),
            blurRadius: 14,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: dt.x6,
          vertical: dt.x4,
        ),
        child: Column(
          children: [
              Text(
                context.formatDisplayCount(count),
                style: typography.sessionSummaryStatCount.copyWith(color: countColor),
              ),
            SizedBox(height: dt.x1 - 1),
            Text(
              label,
              style: typography.moduleCardSubtitle.copyWith(color: dt.walkthroughMuted),
            ),
          ],
        ),
      ),
    );
  }
}
