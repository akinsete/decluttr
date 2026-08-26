import 'package:flutter/material.dart';

import '../testing/widget_keys.dart';
import '../theme/app_motion.dart';
import '../theme/theme.dart';

/// Small count bubble for dock tabs — gentle bounce loop when visible.
class DockCountBadge extends StatefulWidget {
  const DockCountBadge({
    super.key,
    required this.count,
    required this.semanticsLabel,
  });

  final int count;
  final String semanticsLabel;

  @override
  State<DockCountBadge> createState() => _DockCountBadgeState();
}

class _DockCountBadgeState extends State<DockCountBadge> with TickerProviderStateMixin {
  late final AnimationController _floatController;
  late final AnimationController _pulseController;
  late final Animation<double> _floatAnimation;
  late final Animation<double> _pulseAnimation;

  @override
  void initState() {
    super.initState();
    _floatController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1400),
    )..repeat(reverse: true);
    _floatAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _floatController, curve: Curves.easeInOut),
    );

    _pulseController = AnimationController(
      vsync: this,
      duration: AppMotion.fast,
    );
    _pulseAnimation = Tween<double>(begin: 1, end: 1.18).animate(
      CurvedAnimation(parent: _pulseController, curve: AppMotion.bouncyCurve),
    );
  }

  @override
  void didUpdateWidget(DockCountBadge oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.count > oldWidget.count) {
      _pulseController.forward(from: 0).then((_) {
        if (mounted) _pulseController.reverse();
      });
    }
  }

  @override
  void dispose() {
    _floatController.dispose();
    _pulseController.dispose();
    super.dispose();
  }

  String get _label {
    if (widget.count > 99) return '99+';
    return '${widget.count}';
  }

  @override
  Widget build(BuildContext context) {
    if (widget.count <= 0) return const SizedBox.shrink();

    final dt = context.decluttrTheme;
    final typography = context.decluttrTypography;

    return Semantics(
      label: widget.semanticsLabel,
      child: AnimatedBuilder(
        animation: Listenable.merge([_floatAnimation, _pulseAnimation]),
        builder: (context, child) {
          final floatOffset = (_floatAnimation.value - 0.5) * dt.x1;
          return Transform.translate(
            offset: Offset(0, floatOffset),
            child: Transform.scale(
              scale: _pulseAnimation.value,
              child: child,
            ),
          );
        },
        child: DecoratedBox(
          key: WidgetKeys.trashDockBadge,
          decoration: BoxDecoration(
            color: dt.destructiveStrong,
            borderRadius: BorderRadius.circular(dt.radiusFull),
            border: Border.all(color: dt.white, width: dt.x1),
            boxShadow: dt.shadowSm,
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: widget.count > 9 ? dt.x2 + dt.x1 : dt.x2,
              vertical: dt.x1,
            ),
            child: Text(
              _label,
              style: typography.statusPill.copyWith(color: dt.white),
            ),
          ),
        ),
      ),
    );
  }
}
