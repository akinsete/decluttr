import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:phosphoricons_flutter/phosphoricons_flutter.dart';

import '../../core/testing/widget_keys.dart';
import '../../core/formatting/display_number_formatter.dart';
import '../../core/theme/theme.dart';

/// Home "Your progress" card — gradient ring with kept / deleted side stats.
class ProgressCard extends StatelessWidget {
  const ProgressCard({
    super.key,
    required this.title,
    required this.kept,
    required this.deleted,
    required this.itemsRemaining,
    required this.progress,
    required this.viewAllLabel,
    required this.keptLabel,
    required this.deletedLabel,
    required this.itemsRemainingLabel,
    this.onViewAll,
  });

  final String title;
  final int kept;
  final int deleted;
  final int itemsRemaining;
  final double progress;
  final String viewAllLabel;
  final String keptLabel;
  final String deletedLabel;
  final String itemsRemainingLabel;
  final VoidCallback? onViewAll;

  @override
  Widget build(BuildContext context) {
    final dt = context.decluttrTheme;
    final typography = context.decluttrTypography;

    final card = Padding(
      padding: EdgeInsets.symmetric(
        horizontal: dt.x4 + dt.x1,
        vertical: dt.x4,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  title,
                  style: typography.walkthroughDemoLabel,
                ),
              ),
              Text(
                key: WidgetKeys.homeProgressViewAll,
                viewAllLabel,
                style: typography.walkthroughDemoLabel.copyWith(color: dt.pinkHot),
              ),
            ],
          ),
          SizedBox(height: dt.x2),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _ProgressSideStat(
                key: WidgetKeys.homeProgressKeptStat,
                count: kept,
                label: keptLabel,
                icon: PhosphorIconsRegular.check,
                iconColor: dt.walkthroughTap,
                circleColor: dt.keptStatCircleFill,
              ),
              _ProgressRing(
                key: WidgetKeys.homeProgressRing,
                progress: progress,
                centerValue: context.formatDisplayCount(itemsRemaining),
                caption: itemsRemainingLabel,
              ),
              _ProgressSideStat(
                key: WidgetKeys.homeProgressDeletedStat,
                count: deleted,
                label: deletedLabel,
                icon: PhosphorIconsRegular.trash,
                iconColor: dt.pinkHot,
                circleColor: dt.deletedStatCircleFill,
              ),
            ],
          ),
        ],
      ),
    );

    return Material(
      key: WidgetKeys.homeProgressCard,
      color: dt.white,
      elevation: 0,
      shadowColor: Colors.transparent,
      borderRadius: BorderRadius.circular(dt.radiusXxl),
      child: InkWell(
        onTap: onViewAll,
        borderRadius: BorderRadius.circular(dt.radiusXxl),
        child: Ink(
          decoration: BoxDecoration(
            color: dt.white,
            borderRadius: BorderRadius.circular(dt.radiusXxl),
            boxShadow: dt.shadowSm,
          ),
          child: card,
        ),
      ),
    );
  }
}

class _ProgressSideStat extends StatelessWidget {
  const _ProgressSideStat({
    super.key,
    required this.count,
    required this.label,
    required this.icon,
    required this.iconColor,
    required this.circleColor,
  });

  final int count;
  final String label;
  final IconData icon;
  final Color iconColor;
  final Color circleColor;

  @override
  Widget build(BuildContext context) {
    final dt = context.decluttrTheme;
    final typography = context.decluttrTypography;

    return SizedBox(
      width: dt.x11,
      child: Column(
        children: [
          Container(
            width: dt.x9 + dt.x1,
            height: dt.x9 + dt.x1,
            decoration: BoxDecoration(
              color: circleColor,
              shape: BoxShape.circle,
            ),
            child: Icon(
              icon,
              color: iconColor,
              size: dt.x5,
            ),
          ),
          SizedBox(height: dt.x2 - dt.x1),
          Text(context.formatDisplayCount(count), style: typography.homeProgressSideCount),
          Text(
            label,
            style: typography.moduleCardSubtitle.copyWith(color: iconColor),
          ),
        ],
      ),
    );
  }
}

class _ProgressRing extends StatelessWidget {
  const _ProgressRing({
    super.key,
    required this.progress,
    required this.centerValue,
    required this.caption,
  });

  final double progress;
  final String centerValue;
  final String caption;

  @override
  Widget build(BuildContext context) {
    final dt = context.decluttrTheme;
    final typography = context.decluttrTypography;
    final ringSize = dt.x10 + dt.x11 + dt.x3;

    return SizedBox(
      width: ringSize,
      height: ringSize,
      child: Stack(
        alignment: Alignment.center,
        children: [
          CustomPaint(
            size: Size.square(ringSize),
            painter: _ProgressRingPainter(
              progress: progress.clamp(0, 1),
              trackColor: dt.progressRingTrack,
              gradient: dt.progressRingGradient,
              strokeWidth: dt.x3 - dt.x1,
            ),
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(centerValue, style: typography.homeProgressRingNumber),
              SizedBox(height: dt.x1 - 1),
              Text(
                caption,
                textAlign: TextAlign.center,
                style: typography.homeProgressRingCaption,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _ProgressRingPainter extends CustomPainter {
  _ProgressRingPainter({
    required this.progress,
    required this.trackColor,
    required this.gradient,
    required this.strokeWidth,
  });

  final double progress;
  final Color trackColor;
  final LinearGradient gradient;
  final double strokeWidth;

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = (size.width - strokeWidth) / 2;
    final rect = Rect.fromCircle(center: center, radius: radius);

    final trackPaint = Paint()
      ..color = trackColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;

    canvas.drawArc(rect, 0, math.pi * 2, false, trackPaint);

    if (progress <= 0) return;

    final progressPaint = Paint()
      ..shader = gradient.createShader(rect)
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;

    canvas.drawArc(
      rect,
      -math.pi / 2,
      math.pi * 2 * progress,
      false,
      progressPaint,
    );
  }

  @override
  bool shouldRepaint(covariant _ProgressRingPainter oldDelegate) {
    return oldDelegate.progress != progress ||
        oldDelegate.trackColor != trackColor ||
        oldDelegate.strokeWidth != strokeWidth;
  }
}
