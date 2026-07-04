import 'package:auto_route/auto_route.dart';
import 'package:decluttr/gen/assets.gen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:phosphoricons_flutter/phosphoricons_flutter.dart';

import '../../../../core/di/providers.dart';
import '../../../../core/testing/widget_keys.dart';
import '../../../../core/theme/theme.dart';
import '../../../../core/widgets/widgets.dart';
import '../../../../l10n/l10n.dart';
import '../../../app/router/app_router.dart';

@RoutePage()
class WelcomePage extends ConsumerWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    final typography = context.decluttrTypography;

    return Scaffold(
      key: WidgetKeys.welcomePage,
      backgroundColor: context.decluttrTheme.canvas,
      body: SafeArea(
        child: Stack(
          children: [
            Padding(
              padding: EdgeInsets.fromLTRB(
                context.decluttrTheme.x7,
                context.decluttrTheme.x10,
                context.decluttrTheme.x7,
                context.decluttrTheme.x9,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: context.decluttrTheme.x6),
                  Assets.handoff.declutterLogo.svg(height: 58),
                  SizedBox(height: context.decluttrTheme.x1),
                  Padding(
                    padding: EdgeInsets.only(bottom: 2),
                    child: ShaderMask(
                      shaderCallback: (bounds) =>
                          context.decluttrTheme.headlinePinkGradient.createShader(
                        Rect.fromLTWH(0, 0, bounds.width, bounds.height + 4),
                      ),
                      blendMode: BlendMode.srcIn,
                      child: Text(
                        l10n.welcomeHeadlineSuffix,
                        textHeightBehavior: const TextHeightBehavior(
                          applyHeightToFirstAscent: false,
                          applyHeightToLastDescent: false,
                        ),
                        style: typography.welcomeHeadlineMasked,
                      ),
                    ),
                  ),
                  SizedBox(height: context.decluttrTheme.x4),
                  ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 252),
                    child: Text(
                      l10n.welcomeSubtitle,
                      textHeightBehavior: const TextHeightBehavior(
                        applyHeightToFirstAscent: false,
                        applyHeightToLastDescent: false,
                      ),
                      style: typography.welcomeSubtitle,
                    ),
                  ),
                  Expanded(
                    child: Center(
                      child: OverflowBox(
                        maxWidth: 450,
                        child: FloatingHandoffIllustration(
                          asset: Assets.handoff.welcomeTrash,
                          width: MediaQuery.sizeOf(context).width * 1.15,
                        ),
                      ),
                    ),
                  ),
                  PrimaryButton(
                    keyId: WidgetKeys.welcomeGetStarted,
                    label: l10n.welcomeGetStarted,
                    gradient: context.decluttrTheme.primaryCtaGradient,
                    height: 56,
                    onPressed: () =>
                        context.router.push(const WalkthroughRoute()),
                  ),
                  SizedBox(height: context.decluttrTheme.x4),
                  Center(
                    child: TextButton(
                      key: WidgetKeys.welcomeDoItLater,
                      onPressed: () async {
                        await ref
                            .read(appStateProvider.notifier)
                            .completeOnboarding();
                        if (context.mounted) {
                          context.router.replaceAll([const MainShellRoute()]);
                        }
                      },
                      style: TextButton.styleFrom(
                        foregroundColor: context.decluttrTheme.textSecondary,
                        padding: EdgeInsets.symmetric(
                          horizontal: context.decluttrTheme.x3,
                          vertical: context.decluttrTheme.x2,
                        ),
                      ),
                      child: Text(
                        l10n.welcomeDoItLater,
                        style: typography.welcomeSecondaryAction,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              top: context.decluttrTheme.x3,
              right: context.decluttrTheme.x5,
              child: _ReplaySplashButton(
                label: l10n.welcomeReplay,
                onPressed: () => context.router.replace(const SplashRoute()),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ReplaySplashButton extends StatelessWidget {
  const _ReplaySplashButton({
    required this.label,
    required this.onPressed,
  });

  final String label;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    final typography = context.decluttrTypography;
    return Material(
      color: context.decluttrTheme.pinkHot.withValues(alpha: 0.12),
      borderRadius: BorderRadius.circular(context.decluttrTheme.radiusFull),
      child: InkWell(
        onTap: onPressed,
        borderRadius: BorderRadius.circular(context.decluttrTheme.radiusFull),
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: context.decluttrTheme.x3 + 1,
            vertical: context.decluttrTheme.x2 - 1,
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                PhosphorIconsRegular.arrowCounterClockwise,
                size: 14,
                color: context.decluttrTheme.pinkHot,
              ),
              SizedBox(width: context.decluttrTheme.x1),
              Text(
                label,
                style: typography.welcomeReplayLabel,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
