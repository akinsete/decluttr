import 'package:flutter/material.dart';
import 'package:phosphoricons_flutter/phosphoricons_flutter.dart';

import '../../../../core/formatting/display_number_formatter.dart';
import '../../../../core/testing/widget_keys.dart';
import '../../../../core/theme/theme.dart';

class InsightsTypeBreakdown extends StatelessWidget {
  const InsightsTypeBreakdown({
    super.key,
    required this.title,
    required this.photosLabel,
    required this.contactsLabel,
    required this.photosCount,
    required this.contactsCount,
  });

  final String title;
  final String photosLabel;
  final String contactsLabel;
  final int photosCount;
  final int contactsCount;

  @override
  Widget build(BuildContext context) {
    final dt = context.decluttrTheme;
    final typography = context.decluttrTypography;
    final maxCount = photosCount > contactsCount ? photosCount : contactsCount;

    return DecoratedBox(
      key: WidgetKeys.insightsTypeBreakdown,
      decoration: BoxDecoration(
        color: dt.white,
        borderRadius: BorderRadius.circular(dt.radiusLg),
        boxShadow: dt.shadowSm,
      ),
      child: Padding(
        padding: EdgeInsets.all(dt.x4 + dt.x1),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(title, style: typography.walkthroughDemoLabel),
            SizedBox(height: dt.x4),
            _TypeRow(
              icon: PhosphorIconsRegular.images,
              iconColor: dt.pinkHot,
              barColor: dt.pinkHot,
              label: photosLabel,
              count: photosCount,
              maxCount: maxCount,
            ),
            SizedBox(height: dt.x4),
            _TypeRow(
              icon: PhosphorIconsRegular.addressBook,
              iconColor: dt.walkthroughKeep,
              barColor: dt.walkthroughKeep,
              label: contactsLabel,
              count: contactsCount,
              maxCount: maxCount,
            ),
          ],
        ),
      ),
    );
  }
}

class _TypeRow extends StatelessWidget {
  const _TypeRow({
    required this.icon,
    required this.iconColor,
    required this.barColor,
    required this.label,
    required this.count,
    required this.maxCount,
  });

  final IconData icon;
  final Color iconColor;
  final Color barColor;
  final String label;
  final int count;
  final int maxCount;

  @override
  Widget build(BuildContext context) {
    final dt = context.decluttrTheme;
    final typography = context.decluttrTypography;
    final progress = maxCount == 0 ? 0.0 : count / maxCount;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          children: [
            DecoratedBox(
              decoration: BoxDecoration(
                color: iconColor.withValues(alpha: 0.12),
                borderRadius: BorderRadius.circular(dt.radiusXs),
              ),
              child: Padding(
                padding: EdgeInsets.all(dt.x2),
                child: Icon(icon, color: iconColor, size: dt.x4),
              ),
            ),
            SizedBox(width: dt.x3),
            Expanded(child: Text(label, style: typography.moduleCardTitle)),
            Text(
              context.formatDisplayCount(count),
              style: typography.streakStatCount,
            ),
          ],
        ),
        SizedBox(height: dt.x2),
        ClipRRect(
          borderRadius: BorderRadius.circular(dt.radiusFull),
          child: LinearProgressIndicator(
            value: progress,
            minHeight: dt.x2,
            backgroundColor: barColor.withValues(alpha: 0.12),
            color: barColor,
          ),
        ),
      ],
    );
  }
}
