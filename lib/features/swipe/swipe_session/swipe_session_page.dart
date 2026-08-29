import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart' hide Banner;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:phosphoricons_flutter/phosphoricons_flutter.dart';

import '../../../../core/di/providers.dart';
import '../../../../core/error/result.dart';
import '../../../../core/testing/widget_keys.dart';
import '../../../../core/theme/theme.dart';
import '../../../../core/widgets/widgets.dart';
import '../../../../l10n/l10n.dart';
import '../../../app/router/app_router.dart';
import '../../shared/domain/entities/swipe_item.dart';
import 'swipe_action_bar.dart';
import 'swipe_progress_bar.dart';
import 'swipe_session_notifier.dart';
import 'swipe_session_state.dart';
import 'swipe_session_loading_shimmer.dart';
import 'swipe_tutorial_overlay.dart';

@RoutePage()
class SwipeSessionPage extends ConsumerStatefulWidget {
  const SwipeSessionPage({
    super.key,
    @PathParam('batchId') this.batchId = '',
    this.batchTitle = '',
    @QueryParam('isPhotos') this.isPhotos = true,
    @QueryParam('batchCount') this.batchCount,
  });

  final String batchId;
  final String batchTitle;
  final bool isPhotos;
  final int? batchCount;

  @override
  ConsumerState<SwipeSessionPage> createState() => _SwipeSessionPageState();
}

class _SwipeSessionPageState extends ConsumerState<SwipeSessionPage> {
  final _topCardController = SwipeCardController();
  bool _completionHandled = false;

  SwipeSessionArgs get _args => SwipeSessionArgs(
        batchId: widget.batchId,
        batchTitle: widget.batchTitle,
        isPhotos: widget.isPhotos,
        batchCount: widget.batchCount,
      );

  Future<void> _onSwipeDecision(Future<void> Function() decide) async {
    await decide();
    if (!mounted) return;
    await ref.read(swipeSessionProvider(_args).notifier).loadMoreIfNeeded();
    if (!mounted) return;
    _handleSessionComplete(ref.read(swipeSessionProvider(_args)));
  }

  void _handleSessionComplete(SwipeSessionState state) {
    if (!state.isComplete || _completionHandled) return;
    _completionHandled = true;
    _onSessionComplete(state);
  }

  Future<void> _triggerSwipe({required bool delete}) async {
    final notifier = ref.read(swipeSessionProvider(_args).notifier);
    // Prefer the card fly-away animation; fall back if the controller is unbound
    // (e.g. mid rebuild) so keep/delete never become silent no-ops.
    if (_topCardController.isBound) {
      if (delete) {
        await _topCardController.swipeDelete();
      } else {
        await _topCardController.swipeKeep();
      }
    } else if (delete) {
      await notifier.deleteCurrent();
    } else {
      await notifier.keepCurrent();
    }
    if (!mounted) return;
    await notifier.loadMoreIfNeeded();
    if (!mounted) return;
    _handleSessionComplete(ref.read(swipeSessionProvider(_args)));
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final state = ref.watch(swipeSessionProvider(_args));

    ref.listen(swipeSessionProvider(_args), (prev, next) {
      _handleSessionComplete(next);
      if (next.shouldPrefetchMore) {
        ref.read(swipeSessionProvider(_args).notifier).loadMoreIfNeeded();
      }
    });

    if (state.isComplete) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (!mounted) return;
        _handleSessionComplete(ref.read(swipeSessionProvider(_args)));
      });
    }

    final current = state.displayedProgress;
    final total = state.total;
    final dt = context.decluttrTheme;
    final typography = context.decluttrTypography;

    return Scaffold(
      key: WidgetKeys.swipeSessionPage,
      backgroundColor: dt.canvas,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.fromLTRB(dt.screenH, dt.x5, dt.screenH, 0),
          child: Column(
            children: [
              Row(
                children: [
                  AppIconButton(
                    keyId: WidgetKeys.swipeCloseButton,
                    icon: PhosphorIconsRegular.x,
                    size: dt.x9,
                    onPressed: () => _exitSession(completed: false),
                  ),
                  SizedBox(width: dt.x3 + dt.x1),
                  Expanded(child: SwipeProgressBar(value: total == 0 ? 0 : current / total)),
                  SizedBox(width: dt.x3 + dt.x1),
                  SizedBox(
                    width: dt.x10,
                    child: Text(
                      l10n.swipeProgress(current, total),
                      textAlign: TextAlign.right,
                      style: typography.statusPill.copyWith(color: dt.walkthroughMuted),
                    ),
                  ),
                ],
              ),
              SizedBox(height: dt.x5),
              Expanded(
                child: state.isLoading
                    ? const SwipeSessionLoadingShimmer()
                    : Stack(
                        clipBehavior: Clip.none,
                        children: [
                          if (state.currentIndex + 1 < state.items.length)
                            Positioned.fill(
                              child: Transform.translate(
                                offset: Offset(0, context.decluttrTheme.x3),
                                child: Transform.scale(
                                  scale: 0.95,
                                  child: Opacity(
                                    opacity: 0.5,
                                    child: _buildSwipeCard(
                                      context,
                                      item: state.items[state.currentIndex + 1],
                                      isTop: false,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          if (state.currentItem != null)
                            Positioned.fill(
                              child: Stack(
                                clipBehavior: Clip.antiAlias,
                                children: [
                                  _buildSwipeCard(
                                    context,
                                    ref: ref,
                                    item: state.currentItem!,
                                    isTop: true,
                                  ),
                                  if (state.showTutorial)
                                    SwipeTutorialOverlay(
                                      onDismiss: () =>
                                          ref.read(swipeSessionProvider(_args).notifier).dismissTutorial(),
                                    ),
                                ],
                              ),
                            ),
                          if (state.isLoadingMore && state.currentItem == null)
                            const Center(child: CircularProgressIndicator()),
                        ],
                      ),
              ),
              SizedBox(height: dt.x8),
              Padding(
                padding: EdgeInsets.only(bottom: dt.x5),
                child: SwipeActionBar(
                  onUndo: state.isLoading
                      ? () {}
                      : () => ref.read(swipeSessionProvider(_args).notifier).undoLast(),
                  onDelete: state.isLoading ? () {} : () => _triggerSwipe(delete: true),
                  onKeep: state.isLoading ? () {} : () => _triggerSwipe(delete: false),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _onSessionComplete(SwipeSessionState next) async {
    // Navigate immediately; persist stats in the background.
    unawaited(
      ref.read(swipeSessionProvider(_args).notifier).flushSession(completed: true),
    );
    if (!mounted) return;
    context.router.replace(
      SessionSummaryRoute(
        kept: next.kept,
        deleted: next.deleted,
        deletedBytes: next.deletedBytes,
        batchId: widget.batchId,
        isPhotos: widget.isPhotos,
      ),
    );
  }

  void _exitSession({required bool completed}) {
    // Never await flush — back must feel instant even if Firestore is slow.
    unawaited(
      ref.read(swipeSessionProvider(_args).notifier).flushSession(completed: completed),
    );
    if (context.router.canPop()) {
      context.router.pop();
      return;
    }
    context.router.replace(const MainShellRoute());
  }

  Widget _buildSwipeCard(BuildContext context, {WidgetRef? ref, required SwipeItem item, required bool isTop}) {
    final dt = context.decluttrTheme;
    final l10n = context.l10n;
    final gradient = dt.batchPickerGradientAt(item.gradientIndex);

    return SwipeCard(
      key: isTop ? ValueKey(item.id) : null,
      controller: isTop ? _topCardController : null,
      title: widget.isPhotos ? widget.batchTitle : item.title,
      subtitle: item.subtitle,
      gradientIndex: item.gradientIndex,
      tagLabel: widget.isPhotos ? item.title : null,
      mediaBackground: widget.isPhotos ? PhotoAssetThumbnail(assetId: item.id, fallbackGradient: gradient) : null,
      isTop: isTop,
      durationLabel: item.isVideo ? item.durationLabel : null,
      playLabel: item.isVideo ? l10n.swipePlayVideo : null,
      onPlay: isTop && ref != null && item.isVideo
          ? () => _playVideo(ref, item.id)
          : null,
      onSwipeKeep: isTop && ref != null
          ? () => _onSwipeDecision(
                () => ref.read(swipeSessionProvider(_args).notifier).keepCurrent(),
              )
          : null,
      onSwipeDelete: isTop && ref != null
          ? () => _onSwipeDecision(
                () => ref.read(swipeSessionProvider(_args).notifier).deleteCurrent(),
              )
          : null,
      onTap: isTop && ref != null ? () => _showDetail(context, ref, item) : null,
    );
  }

  Future<void> _playVideo(WidgetRef ref, String assetId) async {
    final l10n = context.l10n;
    final result = await ref.read(photosRepositoryProvider).resolvePlayablePath(assetId);
    if (!mounted) return;

    final path = result is Success<String?> ? result.value : null;
    if (path == null || path.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(l10n.swipeVideoUnavailable)),
      );
      return;
    }

    await showDialog<void>(
      context: context,
      builder: (_) => PhotoAssetVideoPlayerDialog(filePath: path),
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
              if (item.detailBody != null) ...[SizedBox(height: context.decluttrTheme.x2), Text(item.detailBody!)],
              SizedBox(height: context.decluttrTheme.x6),
              PrimaryButton(
                label: l10n.swipeKeep,
                onPressed: () {
                  Navigator.pop(context);
                  _topCardController.swipeKeep();
                },
              ),
              SizedBox(height: context.decluttrTheme.x3),
              SecondaryButton(
                label: l10n.swipeDelete,
                onPressed: () {
                  Navigator.pop(context);
                  _topCardController.swipeDelete();
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
