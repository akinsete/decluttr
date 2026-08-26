import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:decluttr/gen/assets.gen.dart';
import '../../../../core/formatting/display_number_formatter.dart';
import '../../../../core/testing/widget_keys.dart';
import '../../../../core/theme/theme.dart';
import '../../../../core/widgets/widgets.dart';
import '../../../../l10n/l10n.dart';
import '../../../app/router/app_router.dart';
import 'batch_contacts_notifier.dart';

@RoutePage()
class BatchContactsPage extends ConsumerWidget {
  const BatchContactsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    final batchesAsync = ref.watch(batchContactsProvider);

    return Scaffold(
      key: WidgetKeys.batchContactsPage,
      backgroundColor: context.decluttrTheme.canvas,
      appBar: AppBar(title: Text(l10n.batchContactsTitle)),
      body: batchesAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (_, __) => EmptyState(
          title: l10n.errorContactsTitle,
          subtitle: l10n.errorContactsMessage,
          actionLabel: l10n.errorTryAgain,
          onAction: () => ref.invalidate(batchContactsProvider),
        ),
        data: (batches) {
          if (batches.isEmpty) {
            return EmptyState(
              title: l10n.batchEmptyTitle,
              subtitle: l10n.batchEmptyContactsSub,
              illustration: Assets.handoff.emptyContacts.image(height: 140),
            );
          }
          return ListView.separated(
            padding: EdgeInsets.fromLTRB(
              context.decluttrTheme.screenH,
              context.decluttrTheme.x4,
              context.decluttrTheme.screenH,
              context.decluttrTheme.dockClearance,
            ),
            itemCount: batches.length,
            separatorBuilder: (_, __) => SizedBox(height: context.decluttrTheme.x4),
            itemBuilder: (context, index) {
              final batch = batches[index];
              return ListTile(
                tileColor: context.decluttrTheme.surfaceCard,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(context.decluttrTheme.radiusLg),
                ),
                title: Text(batch.title, style: Theme.of(context).textTheme.titleLarge),
                subtitle: Text(batch.subtitle),
                trailing: batch.isDuplicates
                    ? StatusPill(label: context.formatDisplayCount(batch.count))
                    : null,
                onTap: () {
                  if (batch.isDuplicates) {
                    context.router.push(const DuplicateContactsRoute());
                  } else {
                    context.router.push(
                      SwipeSessionRoute(
                        batchId: batch.id,
                        batchTitle: batch.title,
                        isPhotos: false,
                      ),
                    );
                  }
                },
              );
            },
          );
        },
      ),
    );
  }
}
