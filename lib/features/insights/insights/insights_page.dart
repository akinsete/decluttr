import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:phosphoricons_flutter/phosphoricons_flutter.dart';

import '../../../../core/testing/widget_keys.dart';
import '../../../../core/theme/theme.dart';
import '../../../../core/widgets/widgets.dart';
import '../../../../l10n/generated/app_localizations.dart';
import '../../../../l10n/l10n.dart';
import '../../../app/router/app_router.dart';
import 'insights_vm.dart';
import 'insights_vm_notifier.dart';
import 'widgets/insights_stat_card.dart';
import 'widgets/insights_storage_hero.dart';
import 'widgets/insights_streak_row.dart';
import 'widgets/insights_type_breakdown.dart';
import 'widgets/insights_week_chart.dart';

@RoutePage()
class InsightsPage extends ConsumerWidget {
  const InsightsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    final vmAsync = ref.watch(insightsVmProvider);

    return Scaffold(
      key: WidgetKeys.insightsPage,
      backgroundColor: context.decluttrTheme.canvas,
      body: SafeArea(
        child: vmAsync.when(
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (_, _) => Center(child: Text(l10n.errorGenericMessage)),
          data: (vm) => _InsightsBody(vm: vm),
        ),
      ),
    );
  }
}

class _InsightsBody extends StatelessWidget {
  const _InsightsBody({required this.vm});

  final InsightsVm vm;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final dt = context.decluttrTheme;
    final typography = context.decluttrTypography;
    final locale = Localizations.localeOf(context).toString();

    return SingleChildScrollView(
      padding: EdgeInsets.fromLTRB(dt.screenH, dt.x5, dt.screenH, dt.dockClearance),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              AppIconButton(
                icon: PhosphorIconsRegular.arrowLeft,
                onPressed: () => context.router.maybePop(),
              ),
              SizedBox(width: dt.x3),
              Text(l10n.insightsTitle, style: typography.walkthroughTitle),
            ],
          ),
          SizedBox(height: dt.x5),
          InsightsStorageHero(
            bytes: vm.committedDeletedBytes,
            label: l10n.insightsStorageFreed,
            localeName: locale,
          ),
          SizedBox(height: dt.x3 + dt.x1),
          Row(
            children: [
              InsightsStatCard(
                key: WidgetKeys.insightsKeptStat,
                icon: PhosphorIconsFill.checkCircle,
                count: vm.totalKept,
                label: l10n.sessionSummaryKeptLabel,
                accentColor: dt.walkthroughKeep,
              ),
              SizedBox(width: dt.x3),
              InsightsStatCard(
                key: WidgetKeys.insightsDeletedStat,
                icon: PhosphorIconsFill.trash,
                count: vm.totalDeleted,
                label: l10n.sessionSummaryDeletedLabel,
                accentColor: dt.pinkHot,
              ),
            ],
          ),
          SizedBox(height: dt.x5),
          Row(
            children: [
              Text(l10n.insightsThisWeek, style: typography.walkthroughDemoLabel),
              const Spacer(),
              Text(
                l10n.insightsWeekCleaned(vm.weekCleanedTotal),
                style: typography.walkthroughDemoLabel.copyWith(color: dt.pinkHot),
              ),
            ],
          ),
          SizedBox(height: dt.x3),
          InsightsWeekChart(
            counts: vm.weekCleanedCounts,
            todayIndex: vm.todayWeekdayIndex,
            weekdayLabels: _weekdayLabels(l10n),
          ),
          SizedBox(height: dt.x5),
          InsightsTypeBreakdown(
            title: l10n.insightsCleanedByType,
            photosLabel: l10n.insightsPhotosVideos,
            contactsLabel: l10n.insightsContacts,
            photosCount: vm.photosDeleted,
            contactsCount: vm.contactsDeleted,
          ),
          SizedBox(height: dt.x5),
          InsightsStreakRow(
            title: l10n.insightsStreakSummary(vm.currentStreak, vm.longestStreak),
            subtitle: l10n.insightsStreakSubtitle,
            onTap: () => context.router.push(const StreakRoute()),
          ),
        ],
      ),
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
