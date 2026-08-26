import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:phosphoricons_flutter/phosphoricons_flutter.dart';

import '../../../core/theme/theme.dart';
import '../../../core/widgets/photo_asset_thumbnail.dart';
import '../../shared/domain/entities/trash_item.dart';
import 'trash_month_grouper.dart';
import 'trash_section_select_actions.dart';

class TrashPhotoGridSection extends ConsumerWidget {
  const TrashPhotoGridSection({
    super.key,
    required this.group,
    required this.showSelectAction,
    required this.selectLabel,
    required this.selectAllLabel,
    required this.deselectAllLabel,
    required this.selectMode,
    required this.allSelected,
    required this.selectedIds,
    required this.onSelectPressed,
    required this.onSelectAllPressed,
    required this.onDeselectAllPressed,
    required this.onToggleItem,
  });

  final TrashMonthGroup group;
  final bool showSelectAction;
  final String selectLabel;
  final String selectAllLabel;
  final String deselectAllLabel;
  final bool selectMode;
  final bool allSelected;
  final Set<String> selectedIds;
  final VoidCallback onSelectPressed;
  final VoidCallback onSelectAllPressed;
  final VoidCallback onDeselectAllPressed;
  final ValueChanged<String> onToggleItem;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final dt = context.decluttrTheme;
    final typography = context.decluttrTypography;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          children: [
            Expanded(
              child: Text(
                group.monthLabel,
                style: typography.walkthroughHint,
              ),
            ),
            if (showSelectAction)
              TrashSectionSelectActions(
                selectMode: selectMode,
                allSelected: allSelected,
                selectLabel: selectLabel,
                selectAllLabel: selectAllLabel,
                deselectAllLabel: deselectAllLabel,
                onSelectPressed: onSelectPressed,
                onSelectAllPressed: onSelectAllPressed,
                onDeselectAllPressed: onDeselectAllPressed,
              ),
          ],
        ),
        SizedBox(height: dt.x3),
        LayoutBuilder(
          builder: (context, constraints) {
            const crossAxisCount = 3;
            final spacing = dt.x2;
            final cellSize =
                (constraints.maxWidth - spacing * (crossAxisCount - 1)) /
                crossAxisCount;

            return Wrap(
              spacing: spacing,
              runSpacing: spacing,
              children: [
                for (final item in group.items)
                  SizedBox(
                    width: cellSize,
                    height: cellSize,
                    child: _TrashPhotoTile(
                      item: item,
                      selected: selectedIds.contains(item.id),
                      selectMode: selectMode,
                      onTap: () => onToggleItem(item.id),
                    ),
                  ),
              ],
            );
          },
        ),
      ],
    );
  }
}

class _TrashPhotoTile extends ConsumerWidget {
  const _TrashPhotoTile({
    required this.item,
    required this.selected,
    required this.selectMode,
    required this.onTap,
  });

  final TrashItem item;
  final bool selected;
  final bool selectMode;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final dt = context.decluttrTheme;
    final gradient = dt.batchPickerGradientAt(item.gradientIndex);

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: selectMode ? onTap : null,
        borderRadius: BorderRadius.circular(dt.radiusSm + dt.x1),
        child: Ink(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(dt.radiusSm + dt.x1),
            border: selected ? Border.all(color: dt.pinkHot) : null,
            boxShadow: selected ? dt.shadowSm : null,
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(dt.radiusSm + dt.x1),
            child: Stack(
              fit: StackFit.expand,
              children: [
                  PhotoAssetThumbnail(
                    assetId: item.id,
                    fallbackGradient: gradient,
                    thumbnailSize: 240,
                  ),
                  if (item.isVideo && item.durationLabel != null)
                    Positioned(
                      left: dt.x2 - dt.x1,
                      bottom: dt.x2 - dt.x1,
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                          color: dt.ink.withValues(alpha: 0.34),
                          borderRadius: BorderRadius.circular(dt.radiusFull),
                        ),
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: dt.x2 - dt.x1,
                            vertical: dt.x1 - 1,
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                PhosphorIconsRegular.play,
                                color: dt.white,
                                size: dt.x2 + dt.x1,
                              ),
                              SizedBox(width: dt.x1),
                              Text(
                                item.durationLabel!,
                                style: context.decluttrTypography.moduleCardSubtitle
                                    .copyWith(color: dt.white),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  if (selectMode)
                    Positioned(
                      top: dt.x2 - dt.x1,
                      right: dt.x2 - dt.x1,
                      child: _SelectionBadge(selected: selected),
                    ),
                ],
              ),
            ),
          ),
        ),
    );
  }
}

class _SelectionBadge extends StatelessWidget {
  const _SelectionBadge({required this.selected});

  final bool selected;

  @override
  Widget build(BuildContext context) {
    final dt = context.decluttrTheme;

    return Container(
      width: dt.x6,
      height: dt.x6,
      decoration: BoxDecoration(
        color: selected ? dt.pinkHot : dt.white.withValues(alpha: 0.92),
        shape: BoxShape.circle,
        border: Border.all(
          color: selected ? dt.pinkHot : dt.white,
          width: dt.x1 - 1,
        ),
        boxShadow: dt.shadowSm,
      ),
      child: selected
          ? Icon(PhosphorIconsRegular.check, color: dt.white, size: dt.x3)
          : null,
    );
  }
}
