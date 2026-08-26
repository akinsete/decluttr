import 'package:flutter/material.dart';

import '../../../core/theme/theme.dart';

class SwipeProgressBar extends StatelessWidget {
  const SwipeProgressBar({
    super.key,
    required this.value,
  });

  final double value;

  @override
  Widget build(BuildContext context) {
    final dt = context.decluttrTheme;

    return ClipRRect(
      borderRadius: BorderRadius.circular(dt.radiusFull),
      child: SizedBox(
        height: dt.x2,
        child: Stack(
          fit: StackFit.expand,
          children: [
            ColoredBox(color: dt.ink.withValues(alpha: 0.08)),
            FractionallySizedBox(
              alignment: Alignment.centerLeft,
              widthFactor: value.clamp(0.0, 1.0),
              child: DecoratedBox(
                decoration: BoxDecoration(gradient: dt.primaryCtaGradient),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
