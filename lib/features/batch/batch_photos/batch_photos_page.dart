import 'package:decluttr/gen/assets.gen.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:phosphoricons_flutter/phosphoricons_flutter.dart';

import '../../../app/router/app_router.dart';
import '../../../core/di/trash_dock_badge_providers.dart';
import '../../../core/testing/widget_keys.dart';
import '../../../core/theme/theme.dart';
import '../../../core/widgets/widgets.dart';
import '../../../l10n/l10n.dart';
import '../../shared/domain/entities/batch_item.dart';
import '../../shell/main_shell/main_shell_dock_intent.dart';
import 'batch_photos_loading_shimmer.dart';
import 'batch_photos_notifier.dart';

@RoutePage()
class BatchPhotosPage extends ConsumerWidget {
  const BatchPhotosPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final batchesAsync = ref.watch(batchPhotosProvider);
    final trashCount = ref.watch(trashItemCountProvider).value ?? 0;
    final l10n = context.l10n;

    return Scaffold(
      key: WidgetKeys.batchPhotosPage,
      backgroundColor: context.decluttrTheme.canvas,
      extendBody: true,
      body: Stack(
        fit: StackFit.expand,
        children: [
          batchesAsync.when(
            loading: () => _BatchPhotosLoading(onBack: () => _popToHome(context)),
            error: (_, _) => _BatchPhotosError(
              onRetry: () => ref.invalidate(batchPhotosProvider),
            ),
            data: (batches) {
              final duplicates =
                  batches.where((b) => b.isDuplicates).firstOrNull;
              final months = batches
                  .where((b) => !b.isDuplicates && b.count > 0)
                  .toList();

              if (duplicates == null && months.isEmpty) {
                return _BatchPhotosEmpty(onDone: () => _popToHome(context));
              }

              return _BatchPhotosContent(
                duplicates: duplicates,
                months: months,
                onOpenBatch: (batch) => _openBatch(context, batch),
              );
            },
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: AppDock(
              keyId: WidgetKeys.appDock,
              current: AppDockTab.home,
              trashBadgeCount: trashCount,
              trashBadgeSemanticsLabel: l10n.trashDockBadgeA11y(trashCount),
              onChanged: (tab) => _onDockTab(context, ref, tab),
            ),
          ),
        ],
      ),
    );
  }

  void _openBatch(BuildContext context, BatchItem batch) {
    context.router.push(
      SwipeSessionRoute(
        batchId: batch.id,
        batchTitle: batch.title,
        isPhotos: true,
        batchCount: batch.count,
      ),
    );
  }

  void _popToHome(BuildContext context) {
    if (context.router.canPop()) {
      context.router.pop();
    } else {
      context.router.replaceAll([const MainShellRoute()]);
    }
  }

  void _onDockTab(BuildContext context, WidgetRef ref, AppDockTab tab) {
    if (tab == AppDockTab.home) {
      _popToHome(context);
      return;
    }
    ref.read(mainShellDockIntentProvider.notifier).setTab(tab);
    _popToHome(context);
  }
}

class _BatchPhotosLoading extends StatelessWidget {
  const _BatchPhotosLoading({required this.onBack});

  final VoidCallback onBack;

  @override
  Widget build(BuildContext context) {
    final dt = context.decluttrTheme;

    return CustomScrollView(
      slivers: [
        SliverPadding(
          padding: EdgeInsets.fromLTRB(
            dt.screenH,
            dt.x10 + MediaQuery.paddingOf(context).top,
            dt.screenH,
            dt.dockClearance,
          ),
          sliver: SliverList(
            delegate: SliverChildListDelegate([
              _BatchPickerHeader(onBack: onBack),
              SizedBox(height: dt.x5),
              const BatchPhotosLoadingShimmer(),
            ]),
          ),
        ),
      ],
    );
  }
}

class _BatchPhotosContent extends StatelessWidget {
  const _BatchPhotosContent({
    required this.months,
    required this.onOpenBatch,
    this.duplicates,
  });

  final BatchItem? duplicates;
  final List<BatchItem> months;
  final ValueChanged<BatchItem> onOpenBatch;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final dt = context.decluttrTheme;
    final cardHeight = dt.batchPickerCardHeight;
    final overlap = dt.batchStackOverlap;
    final stackHeight = months.isEmpty
        ? 0.0
        : cardHeight + (months.length - 1) * (cardHeight - overlap);

    return CustomScrollView(
      slivers: [
        SliverPadding(
          padding: EdgeInsets.fromLTRB(
            dt.screenH,
            dt.x10 + MediaQuery.paddingOf(context).top,
            dt.screenH,
            dt.dockClearance,
          ),
          sliver: SliverList(
            delegate: SliverChildListDelegate([
              _BatchPickerHeader(onBack: () {
                if (context.router.canPop()) {
                  context.router.pop();
                } else {
                  context.router.replaceAll([const MainShellRoute()]);
                }
              }),
              if (duplicates != null) ...[
                SizedBox(height: dt.x5),
                _DuplicatesCard(
                  batch: duplicates!,
                  onTap: () => onOpenBatch(duplicates!),
                ),
              ],
              if (months.isNotEmpty) ...[
                SizedBox(height: dt.x5),
                Text(
                  l10n.batchChooseSection,
                  style: Theme.of(context).textTheme.labelLarge?.copyWith(
                        color: dt.textSecondary,
                        fontWeight: FontWeight.w800,
                      ),
                ),
                SizedBox(height: dt.x5),
                SizedBox(
                  height: stackHeight,
                  child: Stack(
                    clipBehavior: Clip.none,
                    children: [
                      for (var i = 0; i < months.length; i++)
                        Positioned(
                          top: i * (cardHeight - overlap),
                          left: 0,
                          right: 0,
                          child: _MonthBatchCard(
                            batch: months[i],
                            gradient: dt.batchPickerGradientAt(
                              months[i].gradientIndex != 0
                                  ? months[i].gradientIndex
                                  : i,
                            ),
                            onTap: () => onOpenBatch(months[i]),
                          ),
                        ),
                    ],
                  ),
                ),
              ],
            ]),
          ),
        ),
      ],
    );
  }
}

class _BatchPickerHeader extends StatelessWidget {
  const _BatchPickerHeader({required this.onBack});

  final VoidCallback onBack;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final dt = context.decluttrTheme;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppIconButton(
          icon: backIcon(),
          size: dt.x10,
          onPressed: onBack,
        ),
        SizedBox(width: dt.x3 + dt.x1),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                l10n.batchPhotosTitle,
                style: context.decluttrTypography.walkthroughTitle,
              ),
              SizedBox(height: dt.x1 + dt.x1),
              Text(
                l10n.batchPhotosSubtitle,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: dt.textSecondary,
                      fontWeight: FontWeight.w500,
                    ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _DuplicatesCard extends StatelessWidget {
  const _DuplicatesCard({
    required this.batch,
    required this.onTap,
  });

  final BatchItem batch;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final dt = context.decluttrTheme;

    return Material(
      key: WidgetKeys.batchPhotosDuplicatesCard,
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(dt.radiusXxl),
        child: Ink(
          padding: EdgeInsets.symmetric(
            horizontal: dt.x4,
            vertical: dt.x3 + dt.x1,
          ),
          decoration: BoxDecoration(
            gradient: dt.duplicatesPickerGradient,
            borderRadius: BorderRadius.circular(dt.radiusXxl),
          ),
          child: Row(
            children: [
              Container(
                width: dt.x11,
                height: dt.x11,
                decoration: BoxDecoration(
                  color: dt.duplicatesPickerIconSurface,
                  borderRadius: BorderRadius.circular(dt.radiusSm),
                ),
                alignment: Alignment.center,
                child: Icon(
                  PhosphorIconsRegular.copy,
                  color: dt.ink,
                  size: dt.x5,
                ),
              ),
              SizedBox(width: dt.x3 + dt.x1),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      l10n.batchDuplicatesTitle,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.w800,
                          ),
                    ),
                    SizedBox(height: dt.x1),
                    Text(
                      l10n.batchDuplicatesPhotosHint(batch.count),
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: dt.inkA(0.55),
                            fontWeight: FontWeight.w600,
                          ),
                    ),
                  ],
                ),
              ),
              Icon(
                PhosphorIconsRegular.caretRight,
                color: dt.inkA(0.4),
                size: dt.x5,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _MonthBatchCard extends StatelessWidget {
  const _MonthBatchCard({
    required this.batch,
    required this.gradient,
    required this.onTap,
  });

  final BatchItem batch;
  final LinearGradient gradient;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final dt = context.decluttrTheme;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(dt.radiusXl),
        child: Ink(
          height: dt.batchPickerCardHeight,
          padding: EdgeInsets.symmetric(
            horizontal: dt.screenH,
            vertical: dt.x5,
          ),
          decoration: BoxDecoration(
            gradient: gradient,
            borderRadius: BorderRadius.circular(dt.radiusXl),
            boxShadow: dt.batchPickerCardShadow,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                batch.title,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w800,
                    ),
              ),
              SizedBox(height: dt.x1),
              Text(
                l10n.batchPhotoCount(batch.count),
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: dt.inkA(0.55),
                      fontWeight: FontWeight.w600,
                    ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _BatchPhotosError extends StatelessWidget {
  const _BatchPhotosError({required this.onRetry});

  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return EmptyState(
      title: l10n.errorPhotosTitle,
      subtitle: l10n.errorPhotosMessage,
      actionLabel: l10n.errorTryAgain,
      onAction: onRetry,
    );
  }
}

class _BatchPhotosEmpty extends StatelessWidget {
  const _BatchPhotosEmpty({required this.onDone});

  final VoidCallback onDone;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return EmptyState(
      title: l10n.batchEmptyTitle,
      subtitle: l10n.batchEmptyPhotosSub,
      illustration: Assets.handoff.emptyPhotos.image(height: 140),
      actionLabel: l10n.sessionSummaryBack,
      onAction: onDone,
    );
  }
}
