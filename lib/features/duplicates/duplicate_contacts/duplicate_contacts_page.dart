import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/testing/widget_keys.dart';
import '../../../../core/theme/theme.dart';
import '../../../../core/widgets/widgets.dart';
import '../../../../l10n/generated/app_localizations.dart';
import '../../../../l10n/l10n.dart';
import '../../../app/router/app_router.dart';
import '../../shared/domain/entities/contact_record.dart';
import '../../shared/domain/entities/duplicate_group.dart';
import 'duplicate_contacts_notifier.dart';

@RoutePage()
class DuplicateContactsPage extends ConsumerWidget {
  const DuplicateContactsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    final stateAsync = ref.watch(duplicateContactsProvider);

    ref.listen(duplicateContactsProvider, (prev, next) {
      final data = next.value;
      if (data != null && data.isComplete && prev?.value?.isComplete != true) {
        context.router.replaceAll([const MainShellRoute(), const BatchContactsRoute()]);
      }
    });

    return Scaffold(
      key: WidgetKeys.duplicateContactsPage,
      backgroundColor: context.decluttrTheme.canvas,
      appBar: AppBar(title: Text(l10n.duplicatesTitle)),
      body: stateAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (_, __) => EmptyState(
          title: l10n.errorGenericTitle,
          subtitle: l10n.errorGenericMessage,
        ),
        data: (state) {
          final group = state.currentGroup;
          if (group == null) {
            return EmptyState(
              title: l10n.batchEmptyTitle,
              subtitle: l10n.batchEmptyContactsSub,
            );
          }

          return SingleChildScrollView(
            padding: EdgeInsets.all(context.decluttrTheme.screenH),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  l10n.duplicatesProgress(state.index + 1, state.groups.length),
                ),
                SizedBox(height: context.decluttrTheme.x3),
                LinearProgressIndicator(
                  value: (state.index + 1) / state.groups.length,
                  backgroundColor: context.decluttrTheme.surfaceCard,
                  color: context.decluttrTheme.pinkHot,
                ),
                SizedBox(height: context.decluttrTheme.x6),
                _IdentityHeader(group: group, l10n: l10n),
                SizedBox(height: context.decluttrTheme.x5),
                Row(
                  children: group.contacts
                      .take(2)
                      .map((c) => Expanded(child: _SourceCard(contact: c)))
                      .toList(),
                ),
                SizedBox(height: context.decluttrTheme.x5),
                Container(
                  padding: EdgeInsets.all(context.decluttrTheme.x5),
                  decoration: BoxDecoration(
                    color: context.decluttrTheme.white,
                    borderRadius: BorderRadius.circular(context.decluttrTheme.radiusLg),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(l10n.duplicatesAfterMerge,
                          style: Theme.of(context).textTheme.titleLarge),
                      SizedBox(height: context.decluttrTheme.x3),
                      Text(group.mergedPreview?.displayName ?? group.displayName),
                      if (group.mergedPreview?.phone != null)
                        Text(group.mergedPreview!.phone!),
                      if (group.mergedPreview?.email != null)
                        Text(group.mergedPreview!.email!),
                    ],
                  ),
                ),
                SizedBox(height: context.decluttrTheme.x6),
                PrimaryButton(
                  label: l10n.duplicatesMerge,
                  onPressed: () =>
                      ref.read(duplicateContactsProvider.notifier).mergeCurrent(),
                ),
                SizedBox(height: context.decluttrTheme.x3),
                SecondaryButton(
                  label: l10n.duplicatesKeepBoth,
                  onPressed: () =>
                      ref.read(duplicateContactsProvider.notifier).keepBoth(),
                ),
                SizedBox(height: context.decluttrTheme.x3),
                SecondaryButton(
                  label: l10n.duplicatesDeleteOne,
                  onPressed: () =>
                      ref.read(duplicateContactsProvider.notifier).deleteOne(),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class _IdentityHeader extends StatelessWidget {
  const _IdentityHeader({required this.group, required this.l10n});

  final DuplicateGroup group;
  final AppLocalizations l10n;

  String _reason(DuplicateReason reason) {
    return switch (reason) {
      DuplicateReason.samePhone => l10n.duplicatesReasonSamePhone,
      DuplicateReason.sameEmail => l10n.duplicatesReasonSameEmail,
      DuplicateReason.similarName => l10n.duplicatesReasonSimilarName,
    };
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          radius: 36,
          backgroundColor: context.decluttrTheme.lavender,
          child: Text(
            group.displayName.characters.first.toUpperCase(),
            style: Theme.of(context).textTheme.headlineSmall,
          ),
        ),
        SizedBox(height: context.decluttrTheme.x3),
        Text(group.displayName, style: Theme.of(context).textTheme.headlineSmall),
        SizedBox(height: context.decluttrTheme.x2),
        StatusPill(label: _reason(group.reason)),
      ],
    );
  }
}

class _SourceCard extends StatelessWidget {
  const _SourceCard({required this.contact});

  final ContactRecord contact;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(context.decluttrTheme.x1),
      padding: EdgeInsets.all(context.decluttrTheme.x4),
      decoration: BoxDecoration(
        color: context.decluttrTheme.surfaceCard,
        borderRadius: BorderRadius.circular(context.decluttrTheme.radiusMd),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(contact.displayName, style: Theme.of(context).textTheme.titleMedium),
          if (contact.phone != null) Text(contact.phone!),
          if (contact.email != null) Text(contact.email!),
        ],
      ),
    );
  }
}
