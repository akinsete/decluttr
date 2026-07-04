import 'package:auto_route/auto_route.dart';
import 'package:decluttr/gen/assets.gen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/di/providers.dart';
import '../../../../core/testing/widget_keys.dart';
import '../../../../core/theme/theme.dart';
import '../../../../core/widgets/widgets.dart';
import '../../../../l10n/l10n.dart';
import '../../../app/router/app_router.dart';
import 'home_vm_notifier.dart';

@RoutePage()
class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  static const _contentGap = 18.0;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    final typography = context.decluttrTypography;
    final vmAsync = ref.watch(homeScreenVmProvider);

    return vmAsync.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (_, __) => Center(
        child: PrimaryButton(label: l10n.errorTryAgain, onPressed: () => ref.invalidate(homeScreenVmProvider)),
      ),
      data: (vm) {
        return SingleChildScrollView(
          key: WidgetKeys.homePage,
          padding: EdgeInsets.fromLTRB(
            context.decluttrTheme.x6,
            78,
            context.decluttrTheme.x6,
            context.decluttrTheme.dockClearance,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                vm.isFirstVisit ? l10n.homeGreetingFirst : l10n.homeGreetingReturn,
                style: typography.homeEyebrow,
              ),
              SizedBox(height: context.decluttrTheme.x2),
              Text.rich(
                TextSpan(
                  style: typography.homeHero,
                  children: [
                    TextSpan(text: '${l10n.homeHeroLine1}\n'),
                    TextSpan(text: l10n.homeHeroLine2Lead),
                    TextSpan(
                      text: l10n.homeHeroAccent,
                      style: typography.homeHeroAccent,
                    ),
                  ],
                ),
              ),
              SizedBox(height: 10),
              Text(
                l10n.homeHeroSub,
                style: typography.homeHeroSub,
              ),
              SizedBox(height: _contentGap),
              if (!vm.isFirstVisit) ...[
                StreakCard(
                  keyId: WidgetKeys.homeStreakCard,
                  streakDays: vm.streakDays,
                  subtitle: l10n.homeStreakSubtitle,
                  onTap: () => context.router.push(const StreakRoute()),
                ),
                SizedBox(height: _contentGap),
              ],
              ModuleCard(
                keyId: WidgetKeys.homeContactsCard,
                title: l10n.homeContactsTitle,
                subtitle: vm.isFirstVisit ? l10n.homeTapToStart : l10n.homeContactsWaiting(vm.contactsCount),
                gradient: context.decluttrTheme.contactsCardGradient,
                subtitleColor: context.decluttrTheme.walkthroughTap,
                leading: Assets.handoff.cardContacts.image(height: 44),
                onTap: () => _openContacts(context, ref),
              ),
              SizedBox(height: _contentGap),
              ModuleCard(
                keyId: WidgetKeys.homePhotosCard,
                title: l10n.homePhotosTitle,
                subtitle: vm.isFirstVisit ? l10n.homeTapToStart : l10n.homePhotosWaiting(vm.photosCount),
                gradient: context.decluttrTheme.photosCardGradient,
                subtitleColor: context.decluttrTheme.pinkHot,
                leading: Assets.handoff.cardPhotos.image(height: 44),
                onTap: () => _openPhotos(context, ref),
              ),
              if (!vm.isFirstVisit) ...[
                SizedBox(height: _contentGap),
                ProgressCard(
                  title: l10n.homeProgressTitle,
                  progress: vm.progress,
                  statsLabel: l10n.homeProgressStats(vm.kept, vm.deleted),
                ),
              ],
            ],
          ),
        );
      },
    );
  }

  void _openContacts(BuildContext context, WidgetRef ref) {
    final granted = ref.read(appStateProvider).contactsGranted;
    if (granted) {
      context.router.push(const BatchContactsRoute());
    } else {
      context.router.push(const ContactsPermissionRoute());
    }
  }

  void _openPhotos(BuildContext context, WidgetRef ref) {
    final granted = ref.read(appStateProvider).photosGranted;
    if (granted) {
      context.router.push(const BatchPhotosRoute());
    } else {
      context.router.push(const PhotosPermissionRoute());
    }
  }
}
