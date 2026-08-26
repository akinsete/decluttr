import 'package:flutter/material.dart';

import '../../../core/testing/widget_keys.dart';
import '../../../core/theme/theme.dart';
import '../../../core/widgets/shimmer.dart';

/// Skeleton placeholder for batch list content (header is shown separately).
class BatchPhotosLoadingShimmer extends StatelessWidget {
  const BatchPhotosLoadingShimmer({super.key});

  static const _skeletonMonthCount = 5;

  @override
  Widget build(BuildContext context) {
    final dt = context.decluttrTheme;
    final cardHeight = dt.batchPickerCardHeight;
    final overlap = dt.batchStackOverlap;
    final stackHeight =
        cardHeight + (_skeletonMonthCount - 1) * (cardHeight - overlap);

    return Shimmer(
      child: Column(
        key: WidgetKeys.batchPhotosLoadingShimmer,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const _DuplicatesCardShimmer(),
          SizedBox(height: dt.x5),
          ShimmerBox(
            height: dt.x4,
            width: dt.x11,
            borderRadius: BorderRadius.circular(dt.radiusXs),
          ),
          SizedBox(height: dt.x5),
          SizedBox(
            height: stackHeight,
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                for (var i = 0; i < _skeletonMonthCount; i++)
                  Positioned(
                    top: i * (cardHeight - overlap),
                    left: 0,
                    right: 0,
                    child: _MonthBatchCardShimmer(
                      gradient: dt.batchPickerGradientAt(i),
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _DuplicatesCardShimmer extends StatelessWidget {
  const _DuplicatesCardShimmer();

  @override
  Widget build(BuildContext context) {
    final dt = context.decluttrTheme;

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: dt.x4,
        vertical: dt.x3 + dt.x1,
      ),
      decoration: BoxDecoration(
        gradient: dt.duplicatesPickerGradient,
        borderRadius: BorderRadius.circular(dt.radiusXxl),
      ),
      child: Row(
        children: [
          ShimmerBox(
            width: dt.x11,
            height: dt.x11,
            borderRadius: BorderRadius.circular(dt.radiusSm),
            baseColor: dt.duplicatesPickerIconSurface,
            highlightColor: dt.white.withValues(alpha: 0.85),
          ),
          SizedBox(width: dt.x3 + dt.x1),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ShimmerBox(
                  height: dt.x4,
                  width: dt.x9,
                  borderRadius: BorderRadius.circular(dt.radiusXs),
                  baseColor: dt.inkA(0.08),
                  highlightColor: dt.white.withValues(alpha: 0.55),
                ),
                SizedBox(height: dt.x1),
                ShimmerBox(
                  height: dt.x3,
                  width: dt.x11,
                  borderRadius: BorderRadius.circular(dt.radiusXs),
                  baseColor: dt.inkA(0.08),
                  highlightColor: dt.white.withValues(alpha: 0.55),
                ),
              ],
            ),
          ),
          ShimmerBox(
            width: dt.x5,
            height: dt.x5,
            borderRadius: BorderRadius.circular(dt.radiusXs),
            baseColor: dt.inkA(0.06),
            highlightColor: dt.white.withValues(alpha: 0.45),
          ),
        ],
      ),
    );
  }
}

class _MonthBatchCardShimmer extends StatelessWidget {
  const _MonthBatchCardShimmer({required this.gradient});

  final LinearGradient gradient;

  @override
  Widget build(BuildContext context) {
    final dt = context.decluttrTheme;

    return Container(
      height: dt.batchPickerCardHeight,
      padding: EdgeInsets.symmetric(
        horizontal: dt.screenH,
        vertical: dt.x5,
      ),
      decoration: BoxDecoration(
        gradient: gradient,
        borderRadius: BorderRadius.circular(dt.radiusXl),
        boxShadow: dt.batchPickerCardShadow,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ShimmerBox(
            height: dt.x4,
            width: dt.x11,
            borderRadius: BorderRadius.circular(dt.radiusXs),
            baseColor: dt.inkA(0.08),
            highlightColor: dt.white.withValues(alpha: 0.55),
          ),
          SizedBox(height: dt.x1),
          ShimmerBox(
            height: dt.x3,
            width: dt.x9,
            borderRadius: BorderRadius.circular(dt.radiusXs),
            baseColor: dt.inkA(0.08),
            highlightColor: dt.white.withValues(alpha: 0.55),
          ),
        ],
      ),
    );
  }
}
