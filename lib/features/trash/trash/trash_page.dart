import 'package:auto_route/auto_route.dart';
import 'package:decluttr/gen/assets.gen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/testing/widget_keys.dart';
import '../../../../core/theme/theme.dart';
import '../../../../core/widgets/widgets.dart';
import '../../../../l10n/l10n.dart';
import 'trash_notifier.dart';
import 'trash_state.dart';

@RoutePage()
class TrashPage extends ConsumerWidget {
  const TrashPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    final ui = ref.watch(trashUiProvider);
    final notifier = ref.read(trashUiProvider.notifier);
    final items = notifier.filteredItems;

    return Scaffold(
      key: WidgetKeys.trashPage,
      backgroundColor: context.decluttrTheme.canvas,
      appBar: AppBar(
        title: Text(l10n.trashTitle),
        actions: [TextButton(onPressed: notifier.toggleSelectMode, child: Text(l10n.trashSelectMode))],
      ),
      body: ui.isLoading
          ? const Center(child: CircularProgressIndicator())
          : Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: context.decluttrTheme.screenH),
                  child: Text(
                    l10n.trashReclaimable(ui.reclaimableLabel),
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ),
                SizedBox(height: context.decluttrTheme.x4),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: context.decluttrTheme.screenH),
                  child: SegmentedControl<TrashTab>(
                    segments: TrashTab.values,
                    selected: ui.tab,
                    onChanged: notifier.setTab,
                    labelBuilder: (tab) => tab == TrashTab.photos ? l10n.trashTabPhotos : l10n.trashTabContacts,
                  ),
                ),
                SizedBox(height: context.decluttrTheme.x4),
                Expanded(
                  child: items.isEmpty
                      ? EmptyState(
                          title: l10n.trashEmpty,
                          subtitle: l10n.trashEmpty,
                          illustration: Assets.handoff.trashEmpty.image(height: 140),
                        )
                      : ListView.builder(
                          padding: EdgeInsets.fromLTRB(
                            context.decluttrTheme.screenH,
                            0,
                            context.decluttrTheme.screenH,
                            context.decluttrTheme.dockClearance,
                          ),
                          itemCount: items.length,
                          itemBuilder: (context, index) {
                            final item = items[index];
                            final selected = ui.selectedIds.contains(item.id);
                            return ListTile(
                              onTap: () {
                                if (ui.selectMode) {
                                  notifier.toggleSelection(item.id);
                                } else {
                                  notifier.toggleSelection(item.id);
                                }
                              },
                              leading: ui.tab == TrashTab.contacts
                                  ? CircleAvatar(child: Text(item.initial ?? '?'))
                                  : Container(
                                      width: 48,
                                      height: 48,
                                      decoration: BoxDecoration(
                                        color: context.decluttrTheme.surfaceCard,
                                        borderRadius: BorderRadius.circular(context.decluttrTheme.radiusSm),
                                      ),
                                    ),
                              title: Text(item.title),
                              subtitle: Text(l10n.trashPurgesIn(item.daysUntilPurge())),
                              trailing: selected ? Icon(Icons.check_circle, color: context.decluttrTheme.success) : null,
                            );
                          },
                        ),
                ),
                if (ui.selectMode || ui.selectedIds.isNotEmpty)
                  Padding(
                    padding: EdgeInsets.all(context.decluttrTheme.screenH),
                    child: Row(
                      children: [
                        Expanded(
                          child: SecondaryButton(label: l10n.trashRestore, onPressed: notifier.restoreSelected),
                        ),
                        SizedBox(width: context.decluttrTheme.x3),
                        Expanded(
                          child: PrimaryButton(
                            label: l10n.trashDeleteForever,
                            backgroundColor: context.decluttrTheme.destructive,
                            onPressed: notifier.deleteForeverSelected,
                          ),
                        ),
                      ],
                    ),
                  ),
              ],
            ),
    );
  }
}
