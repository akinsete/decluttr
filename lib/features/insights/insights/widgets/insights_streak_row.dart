import 'package:flutter/material.dart';
import 'package:phosphoricons_flutter/phosphoricons_flutter.dart';

import '../../../../core/testing/widget_keys.dart';
import '../../../../core/theme/theme.dart';

class InsightsStreakRow extends StatelessWidget {
  const InsightsStreakRow({
    super.key,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  final String title;
  final String subtitle;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final dt = context.decluttrTheme;
    final typography = context.decluttrTypography;

    return Material(
      key: WidgetKeys.insightsStreakRow,
      color: dt.white,
      borderRadius: BorderRadius.circular(dt.radiusLg),
      elevation: 0,
      shadowColor: dt.ink.withValues(alpha: 0.06),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(dt.radiusLg),
        child: Ink(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(dt.radiusLg),
            boxShadow: dt.shadowSm,
          ),
          child: Padding(
            padding: EdgeInsets.all(dt.x4 + dt.x1),
            child: Row(
              children: [
                DecoratedBox(
                  decoration: BoxDecoration(
                    color: dt.streakFill,
                    shape: BoxShape.circle,
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(dt.x3),
                    child: Icon(PhosphorIconsFill.fire, color: dt.pinkHot, size: dt.x5),
                  ),
                ),
                SizedBox(width: dt.x3 + dt.x1),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(title, style: typography.moduleCardTitle),
                      SizedBox(height: dt.x1),
                      Text(subtitle, style: typography.moduleCardSubtitle),
                    ],
                  ),
                ),
                Icon(PhosphorIconsRegular.caretRight, color: dt.walkthroughMuted, size: dt.x4),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
