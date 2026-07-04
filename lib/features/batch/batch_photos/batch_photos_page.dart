import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:decluttr/gen/assets.gen.dart';
import '../../../../core/testing/widget_keys.dart';
import '../../../../core/theme/theme.dart';
import '../../../../core/widgets/widgets.dart';
import '../../../../l10n/l10n.dart';
import '../../../app/router/app_router.dart';
import '../../shared/domain/entities/batch_item.dart';
import 'batch_photos_notifier.dart';

@RoutePage()
class BatchPhotosPage extends ConsumerWidget {
  const BatchPhotosPage({super.key});

  static const _batchGradients = [
    [Color(0xFFE9F3FF), Color(0xFFCFE6FF)],
    [Color(0xFFFFF0F6), Color(0xFFFBD3E4)],
    [Color(0xFFFFF6D6), Color(0xFFFFE4A8)],
    [Color(0xFFE8F9EC), Color(0xFFC8EFD4)],
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    final batchesAsync = ref.watch(batchPhotosProvider);

    return Scaffold(
      key: WidgetKeys.batchPhotosPage,
      backgroundColor: context.decluttrTheme.canvas,
      appBar: AppBar(title: Text(l10n.batchPhotosTitle)),
      body: batchesAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (_, __) => EmptyState(
          title: l10n.errorPhotosTitle,
          subtitle: l10n.errorPhotosMessage,
          actionLabel: l10n.errorTryAgain,
          onAction: () => ref.invalidate(batchPhotosProvider),
        ),
        data: (batches) {
          if (batches.isEmpty) {
            return EmptyState(
              title: l10n.batchEmptyTitle,
              subtitle: l10n.batchEmptyPhotosSub,
              illustration: Assets.handoff.emptyPhotos.image(height: 140),
            );
          }
          return ListView.builder(
            padding: EdgeInsets.fromLTRB(
              context.decluttrTheme.screenH,
              context.decluttrTheme.x4,
              context.decluttrTheme.screenH,
              context.decluttrTheme.dockClearance,
            ),
            itemCount: batches.length,
            itemBuilder: (context, index) {
              final batch = batches[index];
              final gradient = _batchGradients[index % _batchGradients.length];
              return Transform.translate(
                offset: Offset(0, index == 0 ? 0 : -28.0 * index),
                child: _BatchCard(
                  batch: batch,
                  gradient: gradient,
                  onTap: () {
                    context.router.push(
                      SwipeSessionRoute(
                        batchId: batch.id,
                        batchTitle: batch.title,
                        isPhotos: true,
                      ),
                    );
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}

class _BatchCard extends StatelessWidget {
  const _BatchCard({
    required this.batch,
    required this.gradient,
    required this.onTap,
  });

  final BatchItem batch;
  final List<Color> gradient;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: context.decluttrTheme.x5),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(context.decluttrTheme.radiusXl),
          child: Ink(
            height: 88,
            padding: EdgeInsets.all(context.decluttrTheme.x5),
            decoration: BoxDecoration(
              gradient: LinearGradient(colors: gradient),
              borderRadius: BorderRadius.circular(context.decluttrTheme.radiusXl),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    '${batch.title} · ${batch.count}',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
