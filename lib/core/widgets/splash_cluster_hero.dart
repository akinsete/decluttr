import 'package:decluttr/gen/assets.gen.dart';
import 'package:flutter/material.dart';

/// Splash logo cluster with spark accents (handoff `splash-cluster.png`).
class SplashClusterHero extends StatelessWidget {
  const SplashClusterHero({super.key});

  static final _sparkSpecs = [
    _SparkSpec(
      asset: Assets.handoff.spark2,
      top: 4,
      right: 38,
      size: 30,
      durationMs: 2400,
    ),
    _SparkSpec(
      asset: Assets.handoff.spark1,
      top: 38,
      left: 28,
      size: 26,
      durationMs: 2800,
    ),
    _SparkSpec(
      asset: Assets.handoff.spark3,
      top: 0,
      right: 122,
      size: 20,
      durationMs: 3100,
    ),
    _SparkSpec(
      asset: Assets.handoff.spark1,
      top: 162,
      right: 16,
      size: 18,
      durationMs: 2600,
    ),
    _SparkSpec(
      asset: Assets.handoff.spark2,
      bottom: 38,
      left: 50,
      size: 17,
      durationMs: 3000,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 352,
      height: 296,
      child: Stack(
        alignment: Alignment.center,
        clipBehavior: Clip.none,
        children: [
          const _FloatingCluster(),
          for (final spec in _sparkSpecs) _TwinklingSpark(spec: spec),
        ],
      ),
    );
  }
}

class _SparkSpec {
  const _SparkSpec({
    required this.asset,
    this.top,
    this.right,
    this.bottom,
    this.left,
    required this.size,
    required this.durationMs,
  });

  final AssetGenImage asset;
  final double? top;
  final double? right;
  final double? bottom;
  final double? left;
  final double size;
  final int durationMs;
}

class _FloatingCluster extends StatefulWidget {
  const _FloatingCluster();

  @override
  State<_FloatingCluster> createState() => _FloatingClusterState();
}

class _FloatingClusterState extends State<_FloatingCluster>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _offset;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 5200),
    )..repeat(reverse: true);
    _offset = Tween<double>(begin: 0, end: -9).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _offset,
      builder: (context, child) {
        return Transform.translate(
          offset: Offset(0, _offset.value),
          child: child,
        );
      },
      child: Assets.handoff.splashCluster.image(
        width: 280,
        fit: BoxFit.contain,
      ),
    );
  }
}

class _TwinklingSpark extends StatefulWidget {
  const _TwinklingSpark({required this.spec});

  final _SparkSpec spec;

  @override
  State<_TwinklingSpark> createState() => _TwinklingSparkState();
}

class _TwinklingSparkState extends State<_TwinklingSpark>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _scale;
  late final Animation<double> _opacity;
  late final Animation<double> _rotation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: widget.spec.durationMs),
    )..repeat(reverse: true);
    _scale = Tween<double>(begin: 0.82, end: 1.12).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
    _opacity = Tween<double>(begin: 0.55, end: 1).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
    _rotation = Tween<double>(begin: 0, end: 8 * 3.1415926535 / 180).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final spec = widget.spec;
    return Positioned(
      top: spec.top,
      right: spec.right,
      bottom: spec.bottom,
      left: spec.left,
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return Opacity(
            opacity: _opacity.value,
            child: Transform.rotate(
              angle: _rotation.value,
              child: Transform.scale(
                scale: _scale.value,
                child: child,
              ),
            ),
          );
        },
        child: spec.asset.image(width: spec.size, fit: BoxFit.contain),
      ),
    );
  }
}

/// Module / permission illustration helper.
class HandoffIllustration extends StatelessWidget {
  const HandoffIllustration({
    super.key,
    required this.asset,
    this.width = 120,
    this.height,
  });

  final AssetGenImage asset;
  final double width;
  final double? height;

  @override
  Widget build(BuildContext context) {
    return asset.image(width: width, height: height, fit: BoxFit.contain);
  }
}

/// Gentle vertical float used on welcome, permissions, and empty states.
class FloatingHandoffIllustration extends StatefulWidget {
  const FloatingHandoffIllustration({
    super.key,
    required this.asset,
    this.width = 280,
    this.duration = const Duration(milliseconds: 5600),
    this.amplitude = 9,
  });

  final AssetGenImage asset;
  final double width;
  final Duration duration;
  final double amplitude;

  @override
  State<FloatingHandoffIllustration> createState() =>
      _FloatingHandoffIllustrationState();
}

class _FloatingHandoffIllustrationState extends State<FloatingHandoffIllustration>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _offset;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: widget.duration)
      ..repeat(reverse: true);
    _offset = Tween<double>(begin: 0, end: -widget.amplitude).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _offset,
      builder: (context, child) {
        return Transform.translate(
          offset: Offset(0, _offset.value),
          child: child,
        );
      },
      child: widget.asset.image(width: widget.width, fit: BoxFit.contain),
    );
  }
}
