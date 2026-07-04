import 'dart:ui' show lerpDouble;

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:phosphoricons_flutter/phosphoricons_flutter.dart';

import 'package:decluttr/gen/assets.gen.dart';
import '../../../../core/di/providers.dart';
import '../../../../core/testing/widget_keys.dart';
import '../../../../core/theme/theme.dart';
import '../../../../core/widgets/widgets.dart';
import '../../../../l10n/l10n.dart';
import '../../../app/router/app_router.dart';

@RoutePage()
class WalkthroughPage extends ConsumerWidget {
  const WalkthroughPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    final typography = context.decluttrTypography;

    return Scaffold(
      key: WidgetKeys.walkthroughPage,
      backgroundColor: context.decluttrTheme.canvas,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.fromLTRB(
            context.decluttrTheme.x7,
            60,
            context.decluttrTheme.x7,
            context.decluttrTheme.x9,
          ),
          child: Column(
            children: [
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      l10n.walkthroughTitle,
                      textAlign: TextAlign.center,
                      style: typography.walkthroughTitle,
                    ),
                    SizedBox(height: context.decluttrTheme.x2 - 2),
                    Text(
                      l10n.walkthroughSubtitle,
                      textAlign: TextAlign.center,
                      style: typography.walkthroughSubtitle,
                    ),
                    SizedBox(height: 30),
                    const _WalkthroughDemoStack(),
                    SizedBox(height: 34),
                    SizedBox(
                      width: 272,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _WalkthroughHintRow(
                            circleColor: context.decluttrTheme.walkthroughKeep,
                            icon: PhosphorIconsRegular.arrowRight,
                            label: l10n.walkthroughKeepHint,
                          ),
                          SizedBox(height: 11),
                          _WalkthroughHintRow(
                            circleColor: context.decluttrTheme.walkthroughDelete,
                            icon: PhosphorIconsRegular.arrowLeft,
                            label: l10n.walkthroughDeleteHint,
                          ),
                          SizedBox(height: 11),
                          _WalkthroughHintRow(
                            circleColor: context.decluttrTheme.walkthroughTap,
                            icon: null,
                            label: l10n.walkthroughTapHint,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              PrimaryButton(
                keyId: WidgetKeys.walkthroughContinue,
                label: l10n.walkthroughContinue,
                gradient: context.decluttrTheme.primaryCtaGradient,
                height: 56,
                onPressed: () async {
                  await ref.read(appStateProvider.notifier).completeOnboarding();
                  if (context.mounted) {
                    context.router.replaceAll([const MainShellRoute()]);
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _WalkthroughDemoStack extends StatefulWidget {
  const _WalkthroughDemoStack();

  @override
  State<_WalkthroughDemoStack> createState() => _WalkthroughDemoStackState();
}

class _WalkthroughDemoStackState extends State<_WalkthroughDemoStack>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 5000),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  double _keyframe(
    double t,
    List<(double time, double value)> keys,
  ) {
    for (var i = 0; i < keys.length - 1; i++) {
      final (start, startValue) = keys[i];
      final (end, endValue) = keys[i + 1];
      if (t >= start && t <= end) {
        final span = end - start;
        final p = span == 0 ? 1.0 : (t - start) / span;
        return lerpDouble(startValue, endValue, Curves.easeInOut.transform(p))!;
      }
    }
    return keys.last.$2;
  }

  double _keepOpacity(double t) {
    if (t >= 0.20 && t <= 0.30) return 1;
    if (t >= 0.12 && t < 0.20) return (t - 0.12) / 0.08;
    if (t > 0.30 && t <= 0.38) return 1 - (t - 0.30) / 0.08;
    return 0;
  }

  double _deleteOpacity(double t) {
    if (t >= 0.62 && t <= 0.72) return 1;
    if (t >= 0.54 && t < 0.62) return (t - 0.54) / 0.08;
    if (t > 0.72 && t <= 0.80) return 1 - (t - 0.72) / 0.08;
    return 0;
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        final t = _controller.value;
        final translateX = _keyframe(t, const [
          (0.00, 0),
          (0.08, 0),
          (0.20, 66),
          (0.30, 66),
          (0.42, 0),
          (0.50, 0),
          (0.62, -66),
          (0.72, -66),
          (0.84, 0),
          (1.00, 0),
        ]);
        final rotation = _keyframe(t, const [
          (0.00, 0),
          (0.08, 0),
          (0.20, 8),
          (0.30, 8),
          (0.42, 0),
          (0.50, 0),
          (0.62, -8),
          (0.72, -8),
          (0.84, 0),
          (1.00, 0),
        ]);

        return SizedBox(
          width: 190,
          height: 280,
          child: Stack(
            clipBehavior: Clip.none,
            alignment: Alignment.center,
            children: [
              Transform.translate(
                offset: const Offset(0, 10),
                child: Transform.scale(
                  scale: 0.92,
                  child: Opacity(
                    opacity: 0.6,
                    child: _DemoPhotoCard(
                      image: Assets.handoff.walkFamily,
                      gradient: context.decluttrTheme.walkthroughBackGradient,
                    ),
                  ),
                ),
              ),
              Transform.translate(
                offset: Offset(translateX, 0),
                child: Transform.rotate(
                  angle: rotation * 3.1415926535 / 180,
                  child: _DemoPhotoCard(
                    image: Assets.handoff.walkParty,
                    gradient: context.decluttrTheme.walkthroughFrontGradient,
                    shadow: context.decluttrTheme.shadowCardActive,
                    showOverlay: true,
                    assetLabel: 'IMG_0142',
                    keepOpacity: _keepOpacity(t),
                    deleteOpacity: _deleteOpacity(t),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _DemoPhotoCard extends StatelessWidget {
  const _DemoPhotoCard({
    required this.gradient,
    this.image,
    this.shadow,
    this.showOverlay = false,
    this.assetLabel,
    this.keepOpacity = 0,
    this.deleteOpacity = 0,
  });

  final Gradient gradient;
  final AssetGenImage? image;
  final List<BoxShadow>? shadow;
  final bool showOverlay;
  final String? assetLabel;
  final double keepOpacity;
  final double deleteOpacity;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 190,
      height: 280,
      decoration: BoxDecoration(
        gradient: gradient,
        image: image == null
            ? null
            : DecorationImage(
                image: image!.provider(),
                fit: BoxFit.cover,
              ),
        borderRadius: BorderRadius.circular(context.decluttrTheme.radiusCard),
        boxShadow: shadow,
      ),
      clipBehavior: Clip.antiAlias,
      child: Stack(
        children: [
          if (showOverlay)
            Positioned.fill(
              child: DecoratedBox(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                    colors: [
                      Colors.black.withValues(alpha: 0.24),
                      Colors.transparent,
                    ],
                    stops: const [0, 0.46],
                  ),
                ),
              ),
            ),
          if (assetLabel != null)
            Positioned(
              top: context.decluttrTheme.x4,
              left: context.decluttrTheme.x4,
              child: Container(
                padding: EdgeInsets.symmetric(
                  horizontal: context.decluttrTheme.x3,
                  vertical: context.decluttrTheme.x2 - 2,
                ),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.9),
                  borderRadius: BorderRadius.circular(context.decluttrTheme.radiusFull),
                ),
                child: Text(
                  assetLabel!,
                  style: context.decluttrTypography.walkthroughDemoLabel,
                ),
              ),
            ),
          if (keepOpacity > 0)
            Positioned(
              top: 22,
              left: 18,
              child: Opacity(
                opacity: keepOpacity.clamp(0, 1),
                child: _SwipeStamp(
                  label: 'KEEP',
                  color: context.decluttrTheme.walkthroughKeep,
                  rotation: -12,
                ),
              ),
            ),
          if (deleteOpacity > 0)
            Positioned(
              top: 22,
              right: 18,
              child: Opacity(
                opacity: deleteOpacity.clamp(0, 1),
                child: _SwipeStamp(
                  label: 'DELETE',
                  color: context.decluttrTheme.walkthroughDelete,
                  rotation: 12,
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class _SwipeStamp extends StatelessWidget {
  const _SwipeStamp({
    required this.label,
    required this.color,
    required this.rotation,
  });

  final String label;
  final Color color;
  final double rotation;

  @override
  Widget build(BuildContext context) {
    return Transform.rotate(
      angle: rotation * 3.1415926535 / 180,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 13, vertical: 6),
        decoration: BoxDecoration(
          border: Border.all(color: color, width: 3),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Text(
          label,
          style: context.decluttrTypography.walkthroughSwipeStamp.copyWith(color: color),
        ),
      ),
    );
  }
}

class _WalkthroughHintRow extends StatelessWidget {
  const _WalkthroughHintRow({
    required this.circleColor,
    required this.label,
    this.icon,
  });

  final Color circleColor;
  final IconData? icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          width: 34,
          height: 34,
          decoration: BoxDecoration(
            color: circleColor,
            shape: BoxShape.circle,
          ),
          child: Center(
            child: icon != null
                ? Icon(icon, size: 17, color: context.decluttrTheme.white)
                : const _TapTargetIcon(),
          ),
        ),
        SizedBox(width: context.decluttrTheme.x3),
        Expanded(
          child: Text(
            label,
            style: context.decluttrTypography.walkthroughHint,
          ),
        ),
      ],
    );
  }
}

class _TapTargetIcon extends StatelessWidget {
  const _TapTargetIcon();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 16,
      height: 16,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            width: 17,
            height: 17,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: context.decluttrTheme.white.withValues(alpha: 0.55),
                width: 2,
              ),
            ),
          ),
          Container(
            width: 7,
            height: 7,
            decoration: BoxDecoration(
              color: context.decluttrTheme.white,
              shape: BoxShape.circle,
            ),
          ),
        ],
      ),
    );
  }
}
