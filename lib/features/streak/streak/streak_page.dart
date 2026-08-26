import 'package:auto_route/auto_route.dart';
import 'package:decluttr/gen/assets.gen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:phosphoricons_flutter/phosphoricons_flutter.dart';

import '../../../../core/formatting/display_number_formatter.dart';
import '../../../../core/platform/app_share.dart';
import '../../../../core/testing/widget_keys.dart';
import '../../../../core/theme/theme.dart';
import '../../../../core/widgets/widgets.dart';
import '../../../../l10n/generated/app_localizations.dart';
import '../../../../l10n/l10n.dart';
import 'streak_vm.dart';
import 'streak_vm_notifier.dart';
import 'widgets/streak_heatmap_card.dart';
import 'widgets/streak_stat_card.dart';
import 'widgets/streak_week_strip.dart';

@RoutePage()
class StreakPage extends ConsumerWidget {
  const StreakPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    final vmAsync = ref.watch(streakVmProvider);

    return Scaffold(
      key: WidgetKeys.streakPage,
      backgroundColor: context.decluttrTheme.canvas,
      body: SafeArea(
        child: vmAsync.when(
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (_, _) => Center(child: Text(l10n.errorGenericMessage)),
          data: (vm) => _StreakBody(vm: vm),
        ),
      ),
    );
  }
}

class _StreakBody extends StatelessWidget {
  const _StreakBody({required this.vm});

  final StreakVm vm;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final dt = context.decluttrTheme;
    final typography = context.decluttrTypography;

    return Column(
      children: [
        Expanded(
          child: SingleChildScrollView(
            padding: EdgeInsets.fromLTRB(dt.screenH, dt.x5, dt.screenH, dt.x4),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    AppIconButton(
                      icon: PhosphorIconsRegular.arrowLeft,
                      onPressed: () => context.router.maybePop(),
                    ),
                    AppIconButton(
                      keyId: WidgetKeys.streakShareButton,
                      icon: PhosphorIconsRegular.shareFat,
                      onPressed: () => AppShare.shareText(l10n.settingsShareMessage),
                    ),
                  ],
                ),
                SizedBox(height: dt.x2 + dt.x1),
                Center(
                  child: HandoffFloat(
                    child: Assets.handoff.streakBadge.image(
                      width: dt.x11 + dt.x10,
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
                SizedBox(height: dt.x2),
                Text(
                  context.formatDisplayCount(vm.currentStreak),
                  textAlign: TextAlign.center,
                  style: typography.streakHeroNumber,
                ),
                SizedBox(height: dt.x2),
                Text(
                  l10n.streakDayStreakLabel,
                  textAlign: TextAlign.center,
                  style: typography.streakDayStreakLabel,
                ),
                SizedBox(height: dt.x1 + dt.x1),
                Text(
                  l10n.streakKeepGoing,
                  textAlign: TextAlign.center,
                  style: typography.streakKeepGoing,
                ),
                SizedBox(height: dt.x4 + dt.x1),
                StreakWeekStrip(
                  weekdayLabels: _weekdayLabels(l10n),
                  weekActivity: vm.weekActivity,
                  todayIndex: vm.todayWeekdayIndex,
                ),
                SizedBox(height: dt.x4),
                StreakHeatmapCard(
                  title: l10n.streakLastWeeks,
                  rangeHint: l10n.streakWeekRangeHint,
                  lessLabel: l10n.streakLegendLess,
                  moreLabel: l10n.streakLegendMore,
                  levels: vm.heatmap,
                  todayIndex: vm.heatmapTodayIndex,
                ),
                SizedBox(height: dt.x3),
                Row(
                  children: [
                    StreakStatCard(
                      key: WidgetKeys.streakLongestStat,
                      value: vm.longestStreak,
                      label: l10n.streakLongest,
                    ),
                    SizedBox(width: dt.x3),
                    StreakStatCard(
                      key: WidgetKeys.streakItemsCleanedStat,
                      value: vm.itemsCleaned,
                      label: l10n.streakItemsCleaned,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.fromLTRB(dt.screenH, 0, dt.screenH, dt.x4 + dt.x1),
          child: PrimaryButton(
            keyId: WidgetKeys.streakKeepCleaningButton,
            label: l10n.streakKeepCleaning,
            height: dt.x11 + dt.x1,
            gradient: dt.primaryCtaGradient,
            onPressed: () => context.router.maybePop(),
          ),
        ),
      ],
    );
  }

  List<String> _weekdayLabels(AppLocalizations l10n) {
    return [
      l10n.streakWeekdayMon,
      l10n.streakWeekdayTue,
      l10n.streakWeekdayWed,
      l10n.streakWeekdayThu,
      l10n.streakWeekdayFri,
      l10n.streakWeekdaySat,
      l10n.streakWeekdaySun,
    ];
  }
}
