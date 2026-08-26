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
import 'home_loading_shimmer.dart';
import 'home_vm_notifier.dart';

@RoutePage()
class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  static const _contentGap = 18.0;
  static const _topPadding = 78.0;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    final typography = context.decluttrTypography;
    final dt = context.decluttrTheme;
    final vmAsync = ref.watch(homeScreenVmProvider);
    final isReturning = ref.watch(appStateProvider.select((s) => s.hasActivity));

    return SingleChildScrollView(
      key: vmAsync.hasValue ? WidgetKeys.homePage : null,
      padding: EdgeInsets.fromLTRB(
        dt.x6,
        _topPadding,
        dt.x6,
        dt.dockClearance,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            isReturning ? l10n.homeGreetingReturn : l10n.homeGreetingFirst,
            style: typography.homeEyebrow,
          ),
          SizedBox(height: dt.x2),
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
          vmAsync.when(
            skipLoadingOnReload: true,
            loading: () => HomeContentLoadingShimmer(isReturning: isReturning),
            error: (_, _) => PrimaryButton(
              label: l10n.errorTryAgain,
              onPressed: () => ref.invalidate(homeScreenVmProvider),
            ),
            data: (vm) => _HomeDashboardContent(
              vm: vm,
              onOpenContacts: () => _openContacts(context, ref),
              onOpenPhotos: () => _openPhotos(context, ref),
              onOpenStreak: () => context.router.push(const StreakRoute()),
              onOpenInsights: () => context.router.push(const InsightsRoute()),
            ),
          ),
        ],
      ),
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

class _HomeDashboardContent extends StatelessWidget {
  const _HomeDashboardContent({
    required this.vm,
    required this.onOpenContacts,
    required this.onOpenPhotos,
    required this.onOpenStreak,
    required this.onOpenInsights,
  });

  final HomeScreenVm vm;
  final VoidCallback onOpenContacts;
  final VoidCallback onOpenPhotos;
  final VoidCallback onOpenStreak;
  final VoidCallback onOpenInsights;

  static const _contentGap = 18.0;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final dt = context.decluttrTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        if (!vm.isFirstVisit) ...[
          StreakCard(
            keyId: WidgetKeys.homeStreakCard,
            title: l10n.homeStreakTitle(vm.streakDays),
            subtitle: l10n.homeStreakSubtitle,
            onTap: onOpenStreak,
          ),
          SizedBox(height: _contentGap),
        ],
        ModuleCard(
          keyId: WidgetKeys.homeContactsCard,
          title: l10n.homeContactsTitle,
          subtitle: vm.isFirstVisit ? l10n.homeTapToStart : l10n.homeContactsWaiting(vm.contactsCount),
          gradient: dt.contactsCardGradient,
          subtitleColor: dt.walkthroughTap,
          leading: Assets.handoff.cardContacts.image(height: 44),
          onTap: onOpenContacts,
        ),
        SizedBox(height: _contentGap),
        ModuleCard(
          keyId: WidgetKeys.homePhotosCard,
          title: l10n.homePhotosTitle,
          subtitle: vm.isFirstVisit ? l10n.homeTapToStart : l10n.homePhotosWaiting(vm.photosCount),
          gradient: dt.photosCardGradient,
          subtitleColor: dt.pinkHot,
          leading: Assets.handoff.cardPhotos.image(height: 44),
          onTap: onOpenPhotos,
        ),
        if (!vm.isFirstVisit) ...[
          SizedBox(height: _contentGap),
          ProgressCard(
            title: l10n.homeProgressTitle,
            kept: vm.kept,
            deleted: vm.deleted,
            itemsRemaining: vm.itemsRemaining,
            progress: vm.progress,
            viewAllLabel: l10n.homeProgressViewAll,
            keptLabel: l10n.sessionSummaryKeptLabel,
            deletedLabel: l10n.sessionSummaryDeletedLabel,
            itemsRemainingLabel: l10n.homeProgressItemsRemaining,
            onViewAll: onOpenInsights,
          ),
        ],
      ],
    );
  }
}
