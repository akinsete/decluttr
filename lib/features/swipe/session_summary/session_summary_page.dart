import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:phosphoricons_flutter/phosphoricons_flutter.dart';

import '../../../../core/testing/widget_keys.dart';
import '../../../../core/theme/theme.dart';
import '../../../../core/widgets/widgets.dart';
import '../../../../l10n/l10n.dart';
import '../../../app/router/app_router.dart';
import '../../batch/batch_contacts/batch_contacts_notifier.dart';
import '../../batch/batch_photos/batch_photos_notifier.dart';

@RoutePage()
class SessionSummaryPage extends ConsumerWidget {
  const SessionSummaryPage({
    super.key,
    this.kept = 0,
    this.deleted = 0,
    this.batchId = '',
    this.isPhotos = true,
  });

  final int kept;
  final int deleted;
  final String batchId;
  final bool isPhotos;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    final theme = Theme.of(context);

    return Scaffold(
      key: WidgetKeys.sessionSummaryPage,
      backgroundColor: context.decluttrTheme.canvas,
      body: Stack(
        children: [
          const Positioned.fill(child: ConfettiCelebration()),
          SafeArea(
            child: Padding(
              padding: EdgeInsets.all(context.decluttrTheme.x6),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    PhosphorIconsFill.sealCheck,
                    size: 96,
                    color: context.decluttrTheme.success,
                  ),
                  SizedBox(height: context.decluttrTheme.x6),
                  Text(l10n.sessionSummaryTitle, style: theme.textTheme.headlineMedium),
                  SizedBox(height: context.decluttrTheme.x3),
                  Text(l10n.sessionSummarySub, style: theme.textTheme.bodyMedium),
                  SizedBox(height: context.decluttrTheme.x8),
                  Text(l10n.sessionSummaryKept(kept), style: theme.textTheme.titleLarge),
                  Text(l10n.sessionSummaryDeleted(deleted), style: theme.textTheme.titleLarge),
                  SizedBox(height: context.decluttrTheme.x10),
                  PrimaryButton(
                    label: l10n.sessionSummaryBack,
                    onPressed: () async {
                      if (isPhotos) {
                        await ref
                            .read(batchPhotosProvider.notifier)
                            .markCleared(batchId);
                        if (context.mounted) {
                          context.router.replaceAll([
                            const MainShellRoute(),
                            const BatchPhotosRoute(),
                          ]);
                        }
                      } else {
                        await ref
                            .read(batchContactsProvider.notifier)
                            .markCleared(batchId);
                        if (context.mounted) {
                          context.router.replaceAll([
                            const MainShellRoute(),
                            const BatchContactsRoute(),
                          ]);
                        }
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
