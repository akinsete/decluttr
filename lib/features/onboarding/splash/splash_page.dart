import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:decluttr/gen/assets.gen.dart';
import '../../../../core/di/providers.dart';
import '../../../../core/testing/widget_keys.dart';
import '../../../../core/theme/theme.dart';
import '../../../../core/widgets/splash_cluster_hero.dart';
import '../../../../l10n/l10n.dart';
import '../../../app/router/app_router.dart';
import 'splash_notifier.dart';

@RoutePage()
class SplashPage extends ConsumerStatefulWidget {
  const SplashPage({super.key});

  @override
  ConsumerState<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends ConsumerState<SplashPage>
    with SingleTickerProviderStateMixin {
  Timer? _timer;
  late final AnimationController _entryController;
  late final Animation<double> _entryFade;
  late final Animation<Offset> _entrySlide;

  @override
  void initState() {
    super.initState();
    _entryController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    );
    _entryFade = CurvedAnimation(
      parent: _entryController,
      curve: Curves.easeOut,
    );
    _entrySlide = Tween<Offset>(
      begin: const Offset(0, 0.03),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _entryController,
      curve: Curves.easeOut,
    ));
    _entryController.forward();
    _timer = Timer(const Duration(milliseconds: 2200), () => unawaited(_goNext()));
  }

  Future<void> _goNext() async {
    if (!mounted) return;

    final deadline = DateTime.now().add(const Duration(seconds: 5));
    while (mounted && ref.read(appStateProvider).isLoading) {
      if (DateTime.now().isAfter(deadline)) break;
      await Future<void>.delayed(const Duration(milliseconds: 50));
    }
    if (!mounted) return;

    if (ref.read(appStateProvider).onboardingComplete) {
      context.router.replaceAll([const MainShellRoute()]);
    } else {
      context.router.replace(const WelcomeRoute());
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    _entryController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final typography = context.decluttrTypography;
    ref.watch(appStateProvider);
    final progress = ref.watch(splashProgressProvider);

    return Scaffold(
      key: WidgetKeys.splashPage,
      backgroundColor: context.decluttrTheme.canvas,
      body: Stack(
        children: [
          Positioned(
            left: context.decluttrTheme.x7,
            right: context.decluttrTheme.x7,
            top: 62,
            bottom: 120,
            child: FadeTransition(
              opacity: _entryFade,
              child: SlideTransition(
                position: _entrySlide,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SplashClusterHero(),
                    SizedBox(height: 30),
                    Assets.handoff.declutterLogo.svg(width: 172),
                    SizedBox(height: context.decluttrTheme.x4),
                    Text(
                      l10n.splashTagline,
                      textAlign: TextAlign.center,
                      textHeightBehavior: const TextHeightBehavior(
                        applyHeightToFirstAscent: false,
                        applyHeightToLastDescent: false,
                      ),
                      style: typography.splashTagline,
                    ),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 72,
            child: Center(
              child: _SplashProgressBar(progress: progress),
            ),
          ),
        ],
      ),
    );
  }
}

class _SplashProgressBar extends StatelessWidget {
  const _SplashProgressBar({required this.progress});

  final double progress;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      key: WidgetKeys.splashProgress,
      borderRadius: BorderRadius.circular(context.decluttrTheme.radiusFull),
      child: SizedBox(
        width: 150,
        height: 6,
        child: Stack(
          fit: StackFit.expand,
          children: [
            ColoredBox(color: context.decluttrTheme.pinkHot.withValues(alpha: 0.14)),
            FractionallySizedBox(
              alignment: Alignment.centerLeft,
              widthFactor: progress.clamp(0, 1),
              child: const DecoratedBox(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Color(0xFFFF4F93), Color(0xFFFF7BB8)],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
