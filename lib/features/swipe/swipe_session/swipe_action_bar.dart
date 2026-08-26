import 'package:flutter/material.dart';
import 'package:phosphoricons_flutter/phosphoricons_flutter.dart';

import '../../../core/testing/widget_keys.dart';
import '../../../core/theme/theme.dart';

/// Bottom action row for swipe session — undo, delete (X), keep (check).
class SwipeActionBar extends StatelessWidget {
  const SwipeActionBar({
    super.key,
    required this.onUndo,
    required this.onDelete,
    required this.onKeep,
  });

  final VoidCallback onUndo;
  final VoidCallback onDelete;
  final VoidCallback onKeep;

  static const _keepGradientEnd = Color(0xFF5BD98F);

  @override
  Widget build(BuildContext context) {
    final dt = context.decluttrTheme;

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _SwipeCircleButton(
          key: WidgetKeys.swipeUndoButton,
          size: dt.x10 + dt.x1,
          iconSize: dt.x5,
          icon: PhosphorIconsRegular.arrowCounterClockwise,
          iconColor: dt.dockInactive,
          backgroundColor: dt.white,
          shadows: dt.shadowSm,
          onTap: onUndo,
        ),
        SizedBox(width: dt.x5 + dt.x1),
        _SwipeCircleButton(
          key: WidgetKeys.swipeDeleteButton,
          size: dt.x11 + dt.x1,
          iconSize: dt.x7,
          icon: PhosphorIconsRegular.x,
          iconColor: dt.destructiveStrong,
          backgroundColor: dt.white,
          shadows: const [
            BoxShadow(
              color: Color(0x38FF4F6D),
              blurRadius: 20,
              offset: Offset(0, 8),
            ),
          ],
          onTap: onDelete,
        ),
        SizedBox(width: dt.x5 + dt.x1),
        _SwipeCircleButton(
          key: WidgetKeys.swipeKeepButton,
          size: dt.x11 + dt.x1,
          iconSize: dt.x7,
          icon: PhosphorIconsRegular.check,
          iconColor: dt.white,
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [dt.walkthroughKeep, _keepGradientEnd],
          ),
          shadows: const [
            BoxShadow(
              color: Color(0x4752C77B),
              blurRadius: 20,
              offset: Offset(0, 8),
            ),
          ],
          onTap: onKeep,
        ),
      ],
    );
  }
}

class _SwipeCircleButton extends StatelessWidget {
  const _SwipeCircleButton({
    super.key,
    required this.size,
    required this.iconSize,
    required this.icon,
    required this.iconColor,
    required this.onTap,
    this.backgroundColor,
    this.gradient,
    this.shadows,
  });

  final double size;
  final double iconSize;
  final IconData icon;
  final Color iconColor;
  final Color? backgroundColor;
  final Gradient? gradient;
  final List<BoxShadow>? shadows;
  final VoidCallback onTap;

  /// Room below the circle so `boxShadow` is not clipped by parents.
  static double _shadowBleed(List<BoxShadow>? shadows, double token) {
    if (shadows == null || shadows.isEmpty) return token;
    var bleed = 0.0;
    for (final shadow in shadows) {
      bleed = bleed > shadow.offset.dy + shadow.blurRadius
          ? bleed
          : shadow.offset.dy + shadow.blurRadius;
    }
    return bleed + token;
  }

  @override
  Widget build(BuildContext context) {
    final dt = context.decluttrTheme;
    final bottomBleed = _shadowBleed(shadows, dt.x1);

    return SizedBox(
      width: size,
      height: size + bottomBleed,
      child: Material(
        color: Colors.transparent,
        clipBehavior: Clip.none,
        child: InkWell(
          onTap: onTap,
          customBorder: const CircleBorder(),
          child: Ink(
            width: size,
            height: size,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: backgroundColor,
              gradient: gradient,
              boxShadow: shadows,
            ),
            child: Icon(icon, size: iconSize, color: iconColor),
          ),
        ),
      ),
    );
  }
}
