import 'package:flutter/material.dart';

import '../../../core/testing/widget_keys.dart';
import '../../../core/theme/theme.dart';
import '../../../core/widgets/shimmer.dart';

/// Skeleton for the swipe card stack only — header stays real.
class SwipeSessionLoadingShimmer extends StatelessWidget {
  const SwipeSessionLoadingShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    final dt = context.decluttrTheme;

    return Shimmer(
      child: Stack(
        key: WidgetKeys.swipeSessionLoadingShimmer,
        clipBehavior: Clip.none,
        children: [
          Positioned.fill(
            child: Transform.translate(
              offset: Offset(0, dt.x3),
              child: Transform.scale(
                scale: 0.95,
                child: Opacity(
                  opacity: 0.5,
                  child: ShimmerBox(
                    borderRadius: BorderRadius.circular(dt.radiusCard),
                  ),
                ),
              ),
            ),
          ),
          Positioned.fill(
            child: ShimmerBox(
              borderRadius: BorderRadius.circular(dt.radiusCard),
            ),
          ),
        ],
      ),
    );
  }
}
