import '../../core/theme/theme.dart';
import 'package:flutter/material.dart';


class ProgressCard extends StatelessWidget {
  const ProgressCard({
    super.key,
    required this.title,
    required this.progress,
    required this.statsLabel,
  });

  final String title;
  final double progress;
  final String statsLabel;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      padding: EdgeInsets.all(context.decluttrTheme.x6),
      decoration: BoxDecoration(
        color: context.decluttrTheme.white,
        borderRadius: BorderRadius.circular(context.decluttrTheme.radiusXxl),
        boxShadow: context.decluttrTheme.shadowSm,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: theme.textTheme.titleLarge),
          SizedBox(height: context.decluttrTheme.x5),
          ClipRRect(
            borderRadius: BorderRadius.circular(context.decluttrTheme.radiusFull),
            child: LinearProgressIndicator(
              value: progress.clamp(0, 1),
              minHeight: 10,
              backgroundColor: context.decluttrTheme.surfaceCard,
              color: context.decluttrTheme.pinkHot,
            ),
          ),
          SizedBox(height: context.decluttrTheme.x3),
          Text(statsLabel, style: theme.textTheme.bodyMedium),
        ],
      ),
    );
  }
}
