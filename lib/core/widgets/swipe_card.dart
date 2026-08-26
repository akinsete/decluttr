import '../../core/theme/theme.dart';
import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../theme/app_motion.dart';

/// Imperative handle for programmatic keep/delete swipes (e.g. action bar taps).
class SwipeCardController {
  Future<void> Function()? _swipeKeep;
  Future<void> Function()? _swipeDelete;

  void _bind({
    required Future<void> Function() swipeKeep,
    required Future<void> Function() swipeDelete,
  }) {
    _swipeKeep = swipeKeep;
    _swipeDelete = swipeDelete;
  }

  void _unbind() {
    _swipeKeep = null;
    _swipeDelete = null;
  }

  Future<void> swipeKeep() => _swipeKeep?.call() ?? Future<void>.value();

  Future<void> swipeDelete() => _swipeDelete?.call() ?? Future<void>.value();
}

class SwipeCard extends StatefulWidget {
  const SwipeCard({
    super.key,
    required this.title,
    required this.subtitle,
    this.gradientIndex = 0,
    this.mediaBackground,
    this.tagLabel,
    this.controller,
    this.onSwipeKeep,
    this.onSwipeDelete,
    this.onTap,
    this.isTop = true,
    this.deleteOnSwipeRight = false,
  });

  final String title;
  final String subtitle;
  final int gradientIndex;
  final Widget? mediaBackground;
  final String? tagLabel;
  final SwipeCardController? controller;
  final Future<void> Function()? onSwipeKeep;
  final Future<void> Function()? onSwipeDelete;
  final VoidCallback? onTap;
  final bool isTop;
  final bool deleteOnSwipeRight;

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

  bool get _isPhotoCard => widget.mediaBackground != null;

  @override
  void initState() {
    super.initState();
    _bindController();
  }

  @override
  void didUpdateWidget(SwipeCard oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.controller != widget.controller) {
      oldWidget.controller?._unbind();
      _bindController();
    }
    if (oldWidget.title != widget.title ||
        oldWidget.subtitle != widget.subtitle ||
        oldWidget.tagLabel != widget.tagLabel ||
        oldWidget.deleteOnSwipeRight != widget.deleteOnSwipeRight) {
      _dx = 0;
      _dy = 0;
      _animating = false;
      _bindController();
    }
  }

  @override
  void dispose() {
    widget.controller?._unbind();
    super.dispose();
  }

  void _bindController() {
    if (!widget.isTop) return;
    final keepTarget = widget.deleteOnSwipeRight ? -620.0 : 620.0;
    final deleteTarget = widget.deleteOnSwipeRight ? 620.0 : -620.0;
    widget.controller?._bind(
      swipeKeep: () => _flyAway(keepTarget, widget.onSwipeKeep),
      swipeDelete: () => _flyAway(deleteTarget, widget.onSwipeDelete),
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
      final target = 620.0;
      final callback =
          widget.deleteOnSwipeRight ? widget.onSwipeDelete : widget.onSwipeKeep;
      await _flyAway(target, callback);
    } else if (_dx < -_threshold) {
      final target = -620.0;
      final callback =
          widget.deleteOnSwipeRight ? widget.onSwipeKeep : widget.onSwipeDelete;
      await _flyAway(target, callback);
    } else if (_dx.abs() < 20 && _dy.abs() < 20) {
      widget.onTap?.call();
      _reset();
    } else {
      _reset();
    }
  }

  Future<void> _flyAway(double target, Future<void> Function()? callback) async {
    if (!widget.isTop || _animating) return;
    setState(() => _animating = true);
    final start = _dx;
    const steps = 12;
    try {
      for (var i = 1; i <= steps; i++) {
        await Future<void>.delayed(
          AppMotion.swipeFly ~/ steps,
        );
        if (!mounted) break;
        setState(() {
          _dx = start + (target - start) * (i / steps);
        });
      }
    } finally {
      await (callback?.call() ?? Future<void>.value());
    }
    if (!mounted) return;
    setState(() {
      _dx = 0;
      _dy = 0;
      _animating = false;
    });
  }

  void _reset() {
    setState(() {
      _dx = 0;
      _dy = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    final dt = context.decluttrTheme;
    final typography = context.decluttrTypography;
    final rotation = _dx / 18 * math.pi / 180;
    final keepOpacity = widget.deleteOnSwipeRight
        ? (-_dx / _threshold).clamp(0.0, 1.0)
        : (_dx / _threshold).clamp(0.0, 1.0);
    final deleteOpacity = widget.deleteOnSwipeRight
        ? (_dx / _threshold).clamp(0.0, 1.0)
        : (-_dx / _threshold).clamp(0.0, 1.0);

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
            width: double.infinity,
            height: double.infinity,
            clipBehavior: Clip.antiAlias,
            decoration: BoxDecoration(
              gradient: _isPhotoCard ? null : _gradient,
              borderRadius: BorderRadius.circular(dt.radiusCard),
              boxShadow: widget.isTop ? dt.shadowCardActive : dt.shadowStack,
            ),
            child: Stack(
              fit: StackFit.expand,
              children: [
                if (_isPhotoCard) widget.mediaBackground!,
                if (!_isPhotoCard)
                  Padding(
                    padding: EdgeInsets.all(dt.x6),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Spacer(),
                        Text(widget.title, style: Theme.of(context).textTheme.headlineSmall),
                        SizedBox(height: dt.x2),
                        Text(widget.subtitle, style: Theme.of(context).textTheme.bodyMedium),
                      ],
                    ),
                  ),
                if (_isPhotoCard) ...[
                  if (widget.tagLabel != null)
                    Positioned(
                      top: dt.x4 + dt.x1,
                      left: dt.x4 + dt.x1,
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                          color: dt.white.withValues(alpha: 0.9),
                          borderRadius: BorderRadius.circular(dt.radiusFull),
                        ),
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: dt.x3 + dt.x1,
                            vertical: dt.x1 + dt.x1,
                          ),
                          child: Text(
                            widget.tagLabel!,
                            style: typography.walkthroughDemoLabel,
                          ),
                        ),
                      ),
                    ),
                  Positioned(
                    left: dt.x5,
                    right: dt.x5,
                    bottom: dt.x5,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.title,
                          style: typography.moduleCardTitle.copyWith(color: dt.white),
                        ),
                        SizedBox(height: dt.x1),
                        Text(
                          widget.subtitle,
                          style: typography.moduleCardSubtitle.copyWith(
                            color: dt.white.withValues(alpha: 0.82),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
                Positioned(
                  top: dt.x6,
                  left: dt.x6,
                  child: Opacity(
                    opacity: keepOpacity,
                    child: _Stamp(label: 'KEEP', color: dt.success),
                  ),
                ),
                Positioned(
                  top: dt.x6,
                  right: dt.x6,
                  child: Opacity(
                    opacity: deleteOpacity,
                    child: _Stamp(label: 'DELETE', color: dt.destructive),
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
