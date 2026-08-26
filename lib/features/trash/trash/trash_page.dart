import 'package:auto_route/auto_route.dart';
import 'package:decluttr/gen/assets.gen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:phosphoricons_flutter/phosphoricons_flutter.dart';

import '../../../core/testing/widget_keys.dart';
import '../../../core/theme/theme.dart';
import '../../../core/widgets/widgets.dart';
import '../../../l10n/l10n.dart';
import 'trash_bottom_bar.dart';
import 'trash_contact_list_section.dart';
import 'trash_notifier.dart';
import 'trash_photo_grid_section.dart';
import 'trash_state.dart';
import 'trash_tab_bar.dart';

@RoutePage()
class TrashPage extends ConsumerStatefulWidget {
  const TrashPage({super.key});

  @override
  ConsumerState<TrashPage> createState() => _TrashPageState();
}

class _TrashPageState extends ConsumerState<TrashPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(trashUiProvider.notifier).refresh();
    });
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final dt = context.decluttrTheme;
    final ui = ref.watch(trashUiProvider);
    final notifier = ref.read(trashUiProvider.notifier);
    final locale = Localizations.localeOf(context).toString();
    final isPhotosTab = ui.tab == TrashTab.photos;
    final groups = isPhotosTab ? notifier.photoGroups : notifier.contactGroups;
    final filtered = notifier.filteredItems;
    final showBar = filtered.isNotEmpty;
    final typography = context.decluttrTypography;
    final allSelected = notifier.allFilteredSelected;

    return Scaffold(
      key: WidgetKeys.trashPage,
      backgroundColor: dt.canvas,
      body: ui.isLoading
          ? const Center(child: CircularProgressIndicator())
          : Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SafeArea(
                  bottom: false,
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(dt.screenH, dt.x3, dt.screenH, dt.x5),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _BackButton(onPressed: () => _navigateBack(context)),
                            SizedBox(width: dt.x3 + dt.x1),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(l10n.trashTitle, style: typography.walkthroughTitle),
                                  SizedBox(height: dt.x1),
                                  Text(l10n.trashSubtitle, style: typography.walkthroughSubtitle),
                                ],
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: dt.x5),
                        TrashTabBar(
                          selected: ui.tab,
                          photoCount: notifier.photoCount,
                          contactCount: notifier.contactCount,
                          photoLabel: l10n.trashTabPhotosCount,
                          contactLabel: l10n.trashTabContactsCount,
                          onChanged: notifier.setTab,
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: filtered.isEmpty
                      ? Padding(
                          padding: EdgeInsets.fromLTRB(
                            dt.screenH,
                            0,
                            dt.screenH,
                            dt.dockClearance,
                          ),
                          child: EmptyState(
                            title: isPhotosTab ? l10n.trashEmpty : l10n.trashEmptyContactsTitle,
                            subtitle: isPhotosTab ? l10n.trashEmptyPhotosSub : l10n.trashEmptyContactsSub,
                            illustration: Assets.handoff.trashEmpty.image(width: dt.x11 + dt.x11),
                          ),
                        )
                      : Stack(
                          children: [
                            CustomScrollView(
                              slivers: [
                                SliverPadding(
                                  padding: EdgeInsets.fromLTRB(
                                    dt.screenH,
                                    0,
                                    dt.screenH,
                                    showBar ? dt.dockClearance + dt.x11 : dt.dockClearance,
                                  ),
                                  sliver: SliverList(
                                    delegate: SliverChildListDelegate([
                                      for (var i = 0; i < groups.length; i++) ...[
                                        if (isPhotosTab)
                                          TrashPhotoGridSection(
                                            group: groups[i],
                                            showSelectAction: i == 0,
                                            selectLabel: l10n.trashSelect,
                                            selectAllLabel: l10n.trashSelectAll,
                                            deselectAllLabel: l10n.trashDeselectAll,
                                            selectMode: ui.selectMode,
                                            allSelected: allSelected,
                                            selectedIds: ui.selectedIds,
                                            onSelectPressed: notifier.enterSelectMode,
                                            onSelectAllPressed: notifier.selectAllFiltered,
                                            onDeselectAllPressed: notifier.deselectAllFiltered,
                                            onToggleItem: notifier.toggleSelection,
                                          )
                                        else
                                          TrashContactListSection(
                                            group: groups[i],
                                            showSelectAction: i == 0,
                                            selectLabel: l10n.trashSelect,
                                            selectAllLabel: l10n.trashSelectAll,
                                            deselectAllLabel: l10n.trashDeselectAll,
                                            selectMode: ui.selectMode,
                                            allSelected: allSelected,
                                            selectedIds: ui.selectedIds,
                                            onSelectPressed: notifier.enterSelectMode,
                                            onSelectAllPressed: notifier.selectAllFiltered,
                                            onDeselectAllPressed: notifier.deselectAllFiltered,
                                            onToggleItem: notifier.toggleSelection,
                                          ),
                                        SizedBox(height: dt.x6 + dt.x1),
                                      ],
                                    ]),
                                  ),
                                ),
                              ],
                            ),
                            if (showBar)
                              Positioned(
                                left: 0,
                                right: 0,
                                bottom: dt.dockClearance - dt.x4,
                                child: TrashBottomBar(
                                  itemsLabel: l10n.trashItemsCount(filtered.length),
                                  sizeLabel: isPhotosTab ? notifier.tabReclaimableLabel(locale) : '',
                                  actionLabel: ui.selectMode && ui.selectedIds.isNotEmpty
                                      ? l10n.trashDeleteSelected
                                      : l10n.trashDeleteForever,
                                  cancelLabel: l10n.trashCancel,
                                  selectedLabel: l10n.trashSelectedCount(ui.selectedIds.length),
                                  selectMode: ui.selectMode,
                                  onDeleteForever: () async {
                                    final ok = await notifier.deleteForeverSelected();
                                    if (!ok && context.mounted) {
                                      ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(content: Text(l10n.errorGenericMessage)),
                                      );
                                    }
                                  },
                                  onCancelSelect: notifier.exitSelectMode,
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

void _navigateBack(BuildContext context) {
  try {
    AutoTabsRouter.of(context).setActiveIndex(0);
  } catch (_) {
    context.router.maybePop();
  }
}

class _BackButton extends StatelessWidget {
  const _BackButton({required this.onPressed});

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    final dt = context.decluttrTheme;

    return Material(
      color: dt.white,
      shape: const CircleBorder(),
      elevation: 0,
      shadowColor: dt.ink.withValues(alpha: 0.06),
      child: InkWell(
        onTap: onPressed,
        customBorder: const CircleBorder(),
        child: SizedBox(
          width: dt.x10,
          height: dt.x10,
          child: Icon(PhosphorIconsRegular.caretLeft, color: dt.ink, size: dt.x4),
        ),
      ),
    );
  }
}
