import 'dart:math';

import 'package:decluttr/gen/assets.gen.dart';
import 'package:flutter/material.dart';
import '../theme/app_motion.dart';

/// Lightweight confetti rain for session summary (handoff `confetti/c1..c8.png`).
class ConfettiCelebration extends StatefulWidget {
  const ConfettiCelebration({super.key});

  @override
  State<ConfettiCelebration> createState() => _ConfettiCelebrationState();
}

class _ConfettiCelebrationState extends State<ConfettiCelebration>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final List<_ConfettiPiece> _pieces;

  @override
  void initState() {
    super.initState();
    final random = Random(42);
    final confetti = Assets.handoff.confetti.values;
    _pieces = List.generate(24, (i) {
      return _ConfettiPiece(
        asset: confetti[i % confetti.length],
        leftFactor: random.nextDouble(),
        delay: random.nextDouble() * 0.35,
        size: 14 + random.nextDouble() * 18,
        drift: (random.nextDouble() - 0.5) * 40,
      );
    });
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2400),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, _) {
          return Stack(
            clipBehavior: Clip.none,
            children: [
              for (final piece in _pieces)
                _ConfettiTile(
                  piece: piece,
                  progress: (_controller.value + piece.delay) % 1,
                ),
            ],
          );
        },
      ),
    );
  }
}

class _ConfettiPiece {
  const _ConfettiPiece({
    required this.asset,
    required this.leftFactor,
    required this.delay,
    required this.size,
    required this.drift,
  });

  final AssetGenImage asset;
  final double leftFactor;
  final double delay;
  final double size;
  final double drift;
}

class _ConfettiTile extends StatelessWidget {
  const _ConfettiTile({required this.piece, required this.progress});

  final _ConfettiPiece piece;
  final double progress;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    final top = -40 + progress * (size.height + 80);
    final left = piece.leftFactor * size.width + piece.drift * progress;

    return Positioned(
      left: left,
      top: top,
      child: Opacity(
        opacity: (1 - progress).clamp(0.3, 1),
        child: Transform.rotate(
          angle: progress * pi * 2,
          child: piece.asset.image(
            width: piece.size,
            height: piece.size,
            fit: BoxFit.contain,
          ),
        ),
      ),
    );
  }
}

/// Gentle bob for permission illustrations (`declutterFloat` in handoff).
class HandoffFloat extends StatefulWidget {
  const HandoffFloat({super.key, required this.child});

  final Widget child;

  @override
  State<HandoffFloat> createState() => _HandoffFloatState();
}

class _HandoffFloatState extends State<HandoffFloat>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2800),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: CurvedAnimation(parent: _controller, curve: AppMotion.bouncyCurve),
      builder: (context, child) {
        return Transform.translate(
          offset: Offset(0, -8 * _controller.value),
          child: child,
        );
      },
      child: widget.child,
    );
  }
}
