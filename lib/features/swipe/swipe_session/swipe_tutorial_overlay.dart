import 'package:flutter/material.dart';
import 'package:phosphoricons_flutter/phosphoricons_flutter.dart';

import '../../../core/testing/widget_keys.dart';
import '../../../core/theme/theme.dart';
import '../../../l10n/l10n.dart';

/// One-time swipe tutorial overlay centered on the active card.
class SwipeTutorialOverlay extends StatelessWidget {
  const SwipeTutorialOverlay({
    super.key,
    required this.onDismiss,
  });

  final VoidCallback onDismiss;

  static const _scrim = Color(0x94181216);

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final dt = context.decluttrTheme;
    final typography = context.decluttrTypography;

    return Material(
      key: WidgetKeys.swipeTutorialOverlay,
      color: Colors.transparent,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(dt.radiusCard),
        child: Stack(
          fit: StackFit.expand,
          children: [
            GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: onDismiss,
              child: const ColoredBox(color: _scrim),
            ),
            Padding(
              padding: EdgeInsets.all(dt.x6),
              child: LayoutBuilder(
                builder: (context, constraints) {
                  return SingleChildScrollView(
                    child: ConstrainedBox(
                      constraints: BoxConstraints(minHeight: constraints.maxHeight),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            l10n.swipeTutorialTitle,
                            textAlign: TextAlign.center,
                            style: typography.primaryCta.copyWith(color: dt.white),
                          ),
                          SizedBox(height: dt.x5),
                          ConstrainedBox(
                            constraints: BoxConstraints(maxWidth: dt.x11 * 4),
                            child: IntrinsicWidth(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                _SwipeTutorialHintRow(
                                  circleColor: dt.walkthroughDelete,
                                  icon: PhosphorIconsRegular.arrowLeft,
                                  label: l10n.walkthroughDeleteHint,
                                ),
                                SizedBox(height: dt.x3 + dt.x1),
                                _SwipeTutorialHintRow(
                                  circleColor: dt.walkthroughKeep,
                                  icon: PhosphorIconsRegular.arrowRight,
                                  label: l10n.walkthroughKeepHint,
                                ),
                                SizedBox(height: dt.x3 + dt.x1),
                                _SwipeTutorialHintRow(
                                  circleColor: dt.walkthroughTap,
                                  label: l10n.walkthroughTapHint,
                                ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(height: dt.x5 + dt.x2),
                          Material(
                            color: dt.white,
                            borderRadius: BorderRadius.circular(dt.radiusPill),
                            child: InkWell(
                              onTap: onDismiss,
                              borderRadius: BorderRadius.circular(dt.radiusPill),
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                  horizontal: dt.x8 + dt.x2,
                                  vertical: dt.x3 + dt.x1,
                                ),
                                child: Text(
                                  l10n.swipeDismissTutorial,
                                  style: typography.primaryButton.copyWith(color: dt.ink),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SwipeTutorialHintRow extends StatelessWidget {
  const _SwipeTutorialHintRow({
    required this.circleColor,
    required this.label,
    this.icon,
  });

  final Color circleColor;
  final IconData? icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    final dt = context.decluttrTheme;
    final typography = context.decluttrTypography;

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: dt.x3 + dt.x1,
        vertical: dt.x3,
      ),
      decoration: BoxDecoration(
        color: dt.white.withValues(alpha: 0.14),
        borderRadius: BorderRadius.circular(dt.radiusMd),
      ),
      child: Row(
        children: [
          Container(
            width: dt.x8 + dt.x1,
            height: dt.x8 + dt.x1,
            decoration: BoxDecoration(
              color: circleColor,
              shape: BoxShape.circle,
            ),
            child: Center(
              child: icon != null
                  ? Icon(icon, size: dt.x4 + dt.x1, color: dt.white)
                  : const _TapTargetIcon(),
            ),
          ),
          SizedBox(width: dt.x3 + dt.x1),
          Expanded(
            child: Text(
              label,
              style: typography.walkthroughHint.copyWith(color: dt.white),
            ),
          ),
        ],
      ),
    );
  }
}

class _TapTargetIcon extends StatelessWidget {
  const _TapTargetIcon();

  @override
  Widget build(BuildContext context) {
    final dt = context.decluttrTheme;

    return SizedBox(
      width: dt.x4,
      height: dt.x4,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            width: dt.x4 + dt.x1,
            height: dt.x4 + dt.x1,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: dt.white.withValues(alpha: 0.55),
                width: 2,
              ),
            ),
          ),
          Container(
            width: dt.x2,
            height: dt.x2,
            decoration: BoxDecoration(
              color: dt.white,
              shape: BoxShape.circle,
            ),
          ),
        ],
      ),
    );
  }
}
