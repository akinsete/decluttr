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
import '../../shared/domain/entities/photo_size_formatter.dart';
import 'session_summary_stat_card.dart';

@RoutePage()
class SessionSummaryPage extends ConsumerWidget {
  const SessionSummaryPage({
    super.key,
    this.kept = 0,
    this.deleted = 0,
    this.deletedBytes = 0,
    this.batchId = '',
    this.isPhotos = true,
  });

  final int kept;
  final int deleted;
  final int deletedBytes;
  final String batchId;
  final bool isPhotos;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    final dt = context.decluttrTheme;
    final typography = context.decluttrTypography;

    return Scaffold(
      key: WidgetKeys.sessionSummaryPage,
      backgroundColor: dt.canvas,
      body: SafeArea(
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            SizedBox(
              width: double.infinity,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: dt.x11 + dt.x10 + dt.x2,
                    height: dt.x11 + dt.x10 + dt.x2,
                    decoration: BoxDecoration(shape: BoxShape.circle, gradient: dt.primaryCtaGradient),
                    child: Icon(PhosphorIconsRegular.check, color: dt.white, size: dt.x8),
                  ),
                  SizedBox(height: dt.x5 + dt.x1),
                  Text(l10n.sessionSummaryTitle, textAlign: TextAlign.center, style: typography.walkthroughTitle),
                  SizedBox(height: dt.x3 - dt.x1),
                  Text(
                    isPhotos ? l10n.sessionSummarySubPhotos : l10n.sessionSummarySubContacts,
                    textAlign: TextAlign.center,
                    style: typography.walkthroughSubtitle,
                  ),
                  SizedBox(height: dt.x6 + dt.x1),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SessionSummaryStatCard(
                        key: WidgetKeys.sessionSummaryKeptStat,
                        count: kept,
                        label: l10n.sessionSummaryKeptLabel,
                        countColor: dt.walkthroughKeep,
                      ),

                      SizedBox(width: dt.x3 + dt.x1),
                      SessionSummaryStatCard(
                        key: WidgetKeys.sessionSummaryDeletedStat,
                        count: deleted,
                        label: l10n.sessionSummaryDeletedLabel,
                        countColor: dt.walkthroughDelete,
                      ),
                    ],
                  ),
                  if (isPhotos && deletedBytes > 0) ...[
                    SizedBox(height: dt.x4),
                    Text(
                      l10n.sessionSummaryDeletedSize(
                        formatPhotoSizeBytes(deletedBytes, Localizations.localeOf(context).toString()),
                      ),
                      textAlign: TextAlign.center,
                      style: typography.walkthroughSubtitle,
                    ),
                  ],
                  SizedBox(height: dt.x7 + dt.x1),
                  PrimaryButton(
                    keyId: WidgetKeys.sessionSummaryBackButton,
                    label: l10n.sessionSummaryBack,
                    expanded: false,
                    gradient: dt.primaryCtaGradient,
                    onPressed: () async {
                      if (isPhotos) {
                        await ref.read(batchPhotosProvider.notifier).markCleared(batchId);
                        if (context.mounted) {
                          context.router.replaceAll([const MainShellRoute(), const BatchPhotosRoute()]);
                        }
                      } else {
                        await ref.read(batchContactsProvider.notifier).markCleared(batchId);
                        if (context.mounted) {
                          context.router.replaceAll([const MainShellRoute(), const BatchContactsRoute()]);
                        }
                      }
                    },
                  ),
                ],
              ),
            ),
            const Positioned.fill(child: ConfettiCelebration()),
          ],
        ),
      ),
    );
  }
}
