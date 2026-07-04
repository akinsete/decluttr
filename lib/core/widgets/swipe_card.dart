import '../../core/theme/theme.dart';
import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../theme/app_motion.dart';

class SwipeCard extends StatefulWidget {
  const SwipeCard({
    super.key,
    required this.title,
    required this.subtitle,
    this.gradientIndex = 0,
    this.onSwipeKeep,
    this.onSwipeDelete,
    this.onTap,
    this.isTop = true,
  });

  final String title;
  final String subtitle;
  final int gradientIndex;
  final VoidCallback? onSwipeKeep;
  final VoidCallback? onSwipeDelete;
  final VoidCallback? onTap;
  final bool isTop;

  @override
  State<SwipeCard> createState() => _SwipeCardState();
}

class _SwipeCardState extends State<SwipeCard> {
  double _dx = 0;
  double _dy = 0;
  bool _animating = false;

  static const _threshold = 110.0;

  static const _gradients = [
    [Color(0xFFE9F3FF), Color(0xFFCFE6FF)],
    [Color(0xFFFFF0F6), Color(0xFFFBD3E4)],
    [Color(0xFFFFF6D6), Color(0xFFFFE4A8)],
    [Color(0xFFE8F9EC), Color(0xFFC8EFD4)],
    [Color(0xFFF0E8FF), Color(0xFFD9CCFF)],
    [Color(0xFFFFEDE7), Color(0xFFFFD4C8)],
  ];

  Gradient get _gradient {
    final pair = _gradients[widget.gradientIndex % _gradients.length];
    return LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: pair,
    );
  }

  void _onPanUpdate(DragUpdateDetails details) {
    if (!widget.isTop || _animating) return;
    setState(() {
      _dx += details.delta.dx;
      _dy += details.delta.dy * 0.2;
    });
  }

  Future<void> _onPanEnd(DragEndDetails details) async {
    if (!widget.isTop || _animating) return;

    if (_dx > _threshold) {
      await _flyAway(620, widget.onSwipeKeep);
    } else if (_dx < -_threshold) {
      await _flyAway(-620, widget.onSwipeDelete);
    } else if (_dx.abs() < 20 && _dy.abs() < 20) {
      widget.onTap?.call();
      _reset();
    } else {
      _reset();
    }
  }

  Future<void> _flyAway(double target, VoidCallback? callback) async {
    setState(() => _animating = true);
    final start = _dx;
    const steps = 12;
    for (var i = 1; i <= steps; i++) {
      await Future<void>.delayed(
        AppMotion.swipeFly ~/ steps,
      );
      if (!mounted) return;
      setState(() {
        _dx = start + (target - start) * (i / steps);
      });
    }
    callback?.call();
    if (mounted) {
      setState(() {
        _dx = 0;
        _dy = 0;
        _animating = false;
      });
    }
  }

  void _reset() {
    setState(() {
      _dx = 0;
      _dy = 0;
    });
  }

  void swipeKeep() => _flyAway(620, widget.onSwipeKeep);
  void swipeDelete() => _flyAway(-620, widget.onSwipeDelete);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final rotation = _dx / 18 * math.pi / 180;
    final keepOpacity = (_dx / _threshold).clamp(0.0, 1.0);
    final deleteOpacity = (-_dx / _threshold).clamp(0.0, 1.0);

    return Transform.translate(
      offset: Offset(_dx, _dy),
      child: Transform.rotate(
        angle: rotation,
        child: GestureDetector(
          onPanUpdate: _onPanUpdate,
          onPanEnd: _onPanEnd,
          onTap: widget.onTap,
          child: AnimatedContainer(
            duration: _animating ? AppMotion.swipeFly : AppMotion.swipeRelease,
            curve: AppMotion.standardCurve,
            height: 420,
            decoration: BoxDecoration(
              gradient: _gradient,
              borderRadius: BorderRadius.circular(context.decluttrTheme.radiusCard),
              boxShadow: widget.isTop ? context.decluttrTheme.shadowCardActive : context.decluttrTheme.shadowStack,
            ),
            child: Stack(
              children: [
                Padding(
                  padding: EdgeInsets.all(context.decluttrTheme.x6),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Spacer(),
                      Text(widget.title, style: theme.textTheme.headlineSmall),
                      SizedBox(height: context.decluttrTheme.x2),
                      Text(widget.subtitle, style: theme.textTheme.bodyMedium),
                    ],
                  ),
                ),
                Positioned(
                  top: context.decluttrTheme.x6,
                  left: context.decluttrTheme.x6,
                  child: Opacity(
                    opacity: keepOpacity,
                    child: _Stamp(label: 'KEEP', color: context.decluttrTheme.success),
                  ),
                ),
                Positioned(
                  top: context.decluttrTheme.x6,
                  right: context.decluttrTheme.x6,
                  child: Opacity(
                    opacity: deleteOpacity,
                    child: _Stamp(label: 'DELETE', color: context.decluttrTheme.destructive),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _Stamp extends StatelessWidget {
  const _Stamp({required this.label, required this.color});

  final String label;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: context.decluttrTheme.x4,
        vertical: context.decluttrTheme.x2,
      ),
      decoration: BoxDecoration(
        border: Border.all(color: color, width: 3),
        borderRadius: BorderRadius.circular(context.decluttrTheme.radiusSm),
      ),
      child: Text(
        label,
        style: context.decluttrTypography.swipeStamp.copyWith(color: color),
      ),
    );
  }
}
