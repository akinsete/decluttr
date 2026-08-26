import 'package:flutter/material.dart';

import '../../../core/testing/widget_keys.dart';
import '../../../core/theme/theme.dart';
import '../../../core/widgets/shimmer.dart';

/// Skeleton for dashboard cards only — hero copy stays visible on [HomePage].
class HomeContentLoadingShimmer extends StatelessWidget {
  const HomeContentLoadingShimmer({super.key, required this.isReturning});

  final bool isReturning;

  static const _contentGap = 18.0;
  static const _moduleLeadingSize = 44.0;
  static const _moduleCaretSize = 32.0;
  static const _streakIconSize = 36.0;

  @override
  Widget build(BuildContext context) {
    final dt = context.decluttrTheme;

    return Shimmer(
      child: Column(
        key: WidgetKeys.homeLoadingShimmer,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          if (isReturning) ...[
            const _StreakCardShimmer(),
            SizedBox(height: _contentGap),
          ],
          _ModuleCardShimmer(gradient: dt.contactsCardGradient),
          SizedBox(height: _contentGap),
          _ModuleCardShimmer(gradient: dt.photosCardGradient),
          if (isReturning) ...[
            SizedBox(height: _contentGap),
            const _ProgressCardShimmer(),
          ],
        ],
      ),
    );
  }
}

class _StreakCardShimmer extends StatelessWidget {
  const _StreakCardShimmer();

  @override
  Widget build(BuildContext context) {
    final dt = context.decluttrTheme;

    return Container(
      padding: EdgeInsets.all(dt.x5),
      decoration: BoxDecoration(
        color: dt.streakFill,
        borderRadius: BorderRadius.circular(dt.radiusLg),
        border: Border.all(color: dt.streakBorder),
      ),
      child: Row(
        children: [
          ShimmerBox(
            width: HomeContentLoadingShimmer._streakIconSize,
            height: HomeContentLoadingShimmer._streakIconSize,
            borderRadius: BorderRadius.circular(dt.radiusSm),
            baseColor: dt.white,
            highlightColor: dt.surfaceCard,
          ),
          SizedBox(width: dt.x3),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
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
                  width: dt.x10,
                  borderRadius: BorderRadius.circular(dt.radiusXs),
                  baseColor: dt.inkA(0.08),
                  highlightColor: dt.white.withValues(alpha: 0.55),
                ),
              ],
            ),
          ),
          ShimmerBox(
            width: HomeContentLoadingShimmer._moduleCaretSize,
            height: HomeContentLoadingShimmer._moduleCaretSize,
            borderRadius: BorderRadius.circular(dt.radiusFull),
            baseColor: dt.white,
            highlightColor: dt.surfaceCard,
          ),
        ],
      ),
    );
  }
}

class _ModuleCardShimmer extends StatelessWidget {
  const _ModuleCardShimmer({required this.gradient});

  final LinearGradient gradient;

  @override
  Widget build(BuildContext context) {
    final dt = context.decluttrTheme;

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: dt.x4,
        vertical: dt.x5,
      ),
      decoration: BoxDecoration(
        gradient: gradient,
        borderRadius: BorderRadius.circular(dt.radiusXl),
      ),
      child: Row(
        children: [
          ShimmerBox(
            width: HomeContentLoadingShimmer._moduleLeadingSize,
            height: HomeContentLoadingShimmer._moduleLeadingSize,
            borderRadius: BorderRadius.circular(dt.radiusSm),
            baseColor: dt.white.withValues(alpha: 0.55),
            highlightColor: dt.white.withValues(alpha: 0.85),
          ),
          SizedBox(width: dt.x3),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
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
          ),
          ShimmerBox(
            width: HomeContentLoadingShimmer._moduleCaretSize,
            height: HomeContentLoadingShimmer._moduleCaretSize,
            borderRadius: BorderRadius.circular(dt.radiusFull),
            baseColor: dt.white,
            highlightColor: dt.surfaceCard,
          ),
        ],
      ),
    );
  }
}

class _ProgressCardShimmer extends StatelessWidget {
  const _ProgressCardShimmer();

  @override
  Widget build(BuildContext context) {
    final dt = context.decluttrTheme;

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: dt.x4 + dt.x1,
        vertical: dt.x4,
      ),
      decoration: BoxDecoration(
        color: dt.white,
        borderRadius: BorderRadius.circular(dt.radiusXxl),
        boxShadow: dt.shadowSm,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              ShimmerBox(
                height: dt.x3,
                width: dt.x9,
                borderRadius: BorderRadius.circular(dt.radiusXs),
              ),
              const Spacer(),
              ShimmerBox(
                height: dt.x3,
                width: dt.x10,
                borderRadius: BorderRadius.circular(dt.radiusXs),
              ),
            ],
          ),
          SizedBox(height: dt.x2),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  ShimmerBox(
                    width: dt.x9 + dt.x1,
                    height: dt.x9 + dt.x1,
                    borderRadius: BorderRadius.circular(dt.radiusFull),
                  ),
                  SizedBox(height: dt.x2),
                  ShimmerBox(
                    width: dt.x5,
                    height: dt.x5,
                    borderRadius: BorderRadius.circular(dt.radiusXs),
                  ),
                ],
              ),
              ShimmerBox(
                width: dt.x10 + dt.x11 + dt.x3,
                height: dt.x10 + dt.x11 + dt.x3,
                borderRadius: BorderRadius.circular(dt.radiusFull),
              ),
              Column(
                children: [
                  ShimmerBox(
                    width: dt.x9 + dt.x1,
                    height: dt.x9 + dt.x1,
                    borderRadius: BorderRadius.circular(dt.radiusFull),
                  ),
                  SizedBox(height: dt.x2),
                  ShimmerBox(
                    width: dt.x5,
                    height: dt.x5,
                    borderRadius: BorderRadius.circular(dt.radiusXs),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
