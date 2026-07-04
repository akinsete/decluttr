import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart' hide Banner;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:phosphoricons_flutter/phosphoricons_flutter.dart';

import '../../../../core/testing/widget_keys.dart';
import '../../../../core/theme/theme.dart';
import '../../../../core/widgets/widgets.dart';
import '../../../../l10n/l10n.dart';
import '../../../app/router/app_router.dart';
import '../../shared/domain/entities/swipe_item.dart';
import 'swipe_session_notifier.dart';
import 'swipe_session_state.dart';

@RoutePage()
class SwipeSessionPage extends ConsumerWidget {
  const SwipeSessionPage({
    super.key,
    @PathParam('batchId') this.batchId = '',
    this.batchTitle = '',
    @QueryParam('isPhotos') this.isPhotos = true,
  });

  final String batchId;
  final String batchTitle;
  final bool isPhotos;

  SwipeSessionArgs get _args => SwipeSessionArgs(
        batchId: batchId,
        batchTitle: batchTitle,
        isPhotos: isPhotos,
      );

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    final state = ref.watch(swipeSessionProvider(_args));

    ref.listen(swipeSessionProvider(_args), (prev, next) {
      if (next.isComplete && prev?.isComplete != true) {
        context.router.replace(
          SessionSummaryRoute(
            kept: next.kept,
            deleted: next.deleted,
            batchId: batchId,
            isPhotos: isPhotos,
          ),
        );
      }
    });

    if (state.isLoading) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    final current = state.currentIndex + 1;
    final total = state.total;

    return Scaffold(
      key: WidgetKeys.swipeSessionPage,
      backgroundColor: context.decluttrTheme.canvas,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.fromLTRB(
            context.decluttrTheme.screenH,
            context.decluttrTheme.x8,
            context.decluttrTheme.screenH,
            context.decluttrTheme.x7,
          ),
          child: Column(
            children: [
              Row(
                children: [
                  AppIconButton(
                    icon: PhosphorIconsRegular.arrowLeft,
                    onPressed: () => context.router.maybePop(),
                  ),
                  SizedBox(width: context.decluttrTheme.x4),
                  Expanded(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(context.decluttrTheme.radiusFull),
                      child: LinearProgressIndicator(
                        value: total == 0 ? 0 : current / total,
                        minHeight: 6,
                        backgroundColor: context.decluttrTheme.surfaceCard,
                        color: context.decluttrTheme.pinkHot,
                      ),
                    ),
                  ),
                  SizedBox(width: context.decluttrTheme.x4),
                  Text(l10n.swipeProgress(current, total)),
                ],
              ),
              SizedBox(height: context.decluttrTheme.x6),
              Expanded(
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    if (state.currentIndex + 1 < state.items.length)
                      Opacity(
                        opacity: 0.5,
                        child: SwipeCard(
                          title: state.items[state.currentIndex + 1].title,
                          subtitle: state.items[state.currentIndex + 1].subtitle,
                          isTop: false,
                        ),
                      ),
                    if (state.currentItem != null)
                      SwipeCard(
                        title: state.currentItem!.title,
                        subtitle: state.currentItem!.subtitle,
                        gradientIndex: state.currentItem!.gradientIndex,
                        onSwipeKeep: () => ref
                            .read(swipeSessionProvider(_args).notifier)
                            .keepCurrent(),
                        onSwipeDelete: () => ref
                            .read(swipeSessionProvider(_args).notifier)
                            .deleteCurrent(),
                        onTap: () => _showDetail(context, ref, state.currentItem!),
                      ),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _CircleAction(
                    keyId: WidgetKeys.swipeDeleteButton,
                    icon: PhosphorIconsRegular.trash,
                    color: context.decluttrTheme.destructive,
                    onTap: () =>
                        ref.read(swipeSessionProvider(_args).notifier).deleteCurrent(),
                  ),
                  SecondaryButton(
                    label: l10n.swipeUndo,
                    expanded: false,
                    onPressed: () =>
                        ref.read(swipeSessionProvider(_args).notifier).undoLast(),
                  ),
                  _CircleAction(
                    keyId: WidgetKeys.swipeKeepButton,
                    icon: PhosphorIconsRegular.check,
                    color: context.decluttrTheme.success,
                    onTap: () =>
                        ref.read(swipeSessionProvider(_args).notifier).keepCurrent(),
                  ),
                ],
              ),
              if (state.showTutorial) ...[
                SizedBox(height: context.decluttrTheme.x4),
                Banner(
                  message: l10n.swipeTutorial,
                  actionLabel: l10n.swipeDismissTutorial,
                  onAction: () => ref
                      .read(swipeSessionProvider(_args).notifier)
                      .dismissTutorial(),
                  onDismiss: () => ref
                      .read(swipeSessionProvider(_args).notifier)
                      .dismissTutorial(),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  void _showDetail(BuildContext context, WidgetRef ref, SwipeItem item) {
    final l10n = context.l10n;
    showModalBottomSheet<void>(
      context: context,
      backgroundColor: context.decluttrTheme.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(context.decluttrTheme.radiusXxl)),
      ),
      builder: (context) {
        return Padding(
          padding: EdgeInsets.all(context.decluttrTheme.x6),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(item.title, style: Theme.of(context).textTheme.headlineSmall),
              SizedBox(height: context.decluttrTheme.x2),
              Text(item.subtitle),
              if (item.detailBody != null) ...[
                SizedBox(height: context.decluttrTheme.x2),
                Text(item.detailBody!),
              ],
              SizedBox(height: context.decluttrTheme.x6),
              PrimaryButton(
                label: l10n.swipeKeep,
                onPressed: () {
                  Navigator.pop(context);
                  ref.read(swipeSessionProvider(_args).notifier).keepCurrent();
                },
              ),
              SizedBox(height: context.decluttrTheme.x3),
              SecondaryButton(
                label: l10n.swipeDelete,
                onPressed: () {
                  Navigator.pop(context);
                  ref.read(swipeSessionProvider(_args).notifier).deleteCurrent();
                },
              ),
            ],
          ),
        );
      },
    );
  }
}

class _CircleAction extends StatelessWidget {
  const _CircleAction({
    required this.icon,
    required this.color,
    required this.onTap,
    this.keyId,
  });

  final IconData icon;
  final Color color;
  final VoidCallback onTap;
  final Key? keyId;

  @override
  Widget build(BuildContext context) {
    return Material(
      key: keyId,
      color: context.decluttrTheme.white,
      shape: const CircleBorder(),
      elevation: 2,
      child: InkWell(
        onTap: onTap,
        customBorder: const CircleBorder(),
        child: SizedBox(
          width: 56,
          height: 56,
          child: Icon(icon, color: color),
        ),
      ),
    );
  }
}
