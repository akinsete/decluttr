import 'package:flutter/material.dart';
import 'package:phosphoricons_flutter/phosphoricons_flutter.dart';

import '../../../../core/testing/widget_keys.dart';
import '../../../../core/theme/theme.dart';
import '../../../shared/domain/entities/photo_size_formatter.dart';

class InsightsStorageHero extends StatelessWidget {
  const InsightsStorageHero({
    super.key,
    required this.bytes,
    required this.label,
    this.localeName,
  });

  final int bytes;
  final String label;
  final String? localeName;

  @override
  Widget build(BuildContext context) {
    final dt = context.decluttrTheme;
    final typography = context.decluttrTypography;

    return DecoratedBox(
      key: WidgetKeys.insightsStorageHero,
      decoration: BoxDecoration(
        gradient: dt.primaryCtaGradient,
        borderRadius: BorderRadius.circular(dt.radiusCard),
        boxShadow: dt.shadowMd,
      ),
      child: Padding(
        padding: EdgeInsets.all(dt.x5),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(PhosphorIconsRegular.hardDrives, color: dt.white, size: dt.x4),
                SizedBox(width: dt.x2),
                Text(
                  label,
                  style: typography.walkthroughDemoLabel.copyWith(color: dt.white.withValues(alpha: 0.9)),
                ),
              ],
            ),
            SizedBox(height: dt.x3),
            Text(
              formatPhotoSizeBytes(bytes, localeName),
              style: typography.homeProgressRingNumber.copyWith(color: dt.white),
            ),
          ],
        ),
      ),
    );
  }
}
