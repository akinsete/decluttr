import 'package:flutter/material.dart';

import '../theme/app_motion.dart';
import '../theme/theme.dart';

/// Provides an animated shimmer gradient to descendant [ShimmerBox] widgets.
class Shimmer extends StatefulWidget {
  const Shimmer({super.key, required this.child});

  final Widget child;

  @override
  State<Shimmer> createState() => _ShimmerState();
}

class _ShimmerState extends State<Shimmer> with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: AppMotion.standard.inMilliseconds * 4),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return _ShimmerScope(
          progress: _controller.value,
          child: child!,
        );
      },
      child: widget.child,
    );
  }
}

class _ShimmerScope extends InheritedWidget {
  const _ShimmerScope({
    required this.progress,
    required super.child,
  });

  final double progress;

  static _ShimmerScope of(BuildContext context) {
    final scope = context.dependOnInheritedWidgetOfExactType<_ShimmerScope>();
    assert(scope != null, 'ShimmerBox must be wrapped in a Shimmer widget.');
    return scope!;
  }

  @override
  bool updateShouldNotify(_ShimmerScope oldWidget) =>
      oldWidget.progress != progress;
}

/// A rounded placeholder block with a moving highlight.
class ShimmerBox extends StatelessWidget {
  const ShimmerBox({
    super.key,
    this.width,
    this.height,
    this.borderRadius,
    this.baseColor,
    this.highlightColor,
  });

  final double? width;
  final double? height;
  final BorderRadius? borderRadius;
  final Color? baseColor;
  final Color? highlightColor;

  @override
  Widget build(BuildContext context) {
    final dt = context.decluttrTheme;
    final progress = _ShimmerScope.of(context).progress;
    final radius = borderRadius ?? BorderRadius.circular(dt.radiusSm);
    final base = baseColor ?? dt.surfaceCard;
    final highlight = highlightColor ?? dt.white;

    return ShaderMask(
      blendMode: BlendMode.srcATop,
      shaderCallback: (bounds) {
        return LinearGradient(
          begin: Alignment(-1 + progress * 2, 0),
          end: Alignment(progress * 2, 0),
          colors: [
            base,
            highlight,
            base,
          ],
          stops: const [0.25, 0.5, 0.75],
        ).createShader(bounds);
      },
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: base,
          borderRadius: radius,
        ),
      ),
    );
  }
}
