import 'package:flutter/material.dart';
import 'package:phosphoricons_flutter/phosphoricons_flutter.dart';
import '../../../core/theme/theme.dart';
import '../../shared/domain/entities/trash_item.dart';
import 'trash_month_grouper.dart';
import 'trash_section_select_actions.dart';

class TrashContactListSection extends StatelessWidget {
  const TrashContactListSection({
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
  Widget build(BuildContext context) {
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
        Column(
          children: [
            for (final item in group.items) ...[
              _TrashContactRow(
                item: item,
                selected: selectedIds.contains(item.id),
                selectMode: selectMode,
                onTap: () => onToggleItem(item.id),
              ),
              SizedBox(height: dt.x2),
            ],
          ],
        ),
      ],
    );
  }
}

class _TrashContactRow extends StatelessWidget {
  const _TrashContactRow({
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
  Widget build(BuildContext context) {
    final dt = context.decluttrTheme;
    final typography = context.decluttrTypography;
    final gradient = dt.batchPickerGradientAt(item.gradientIndex);

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: selectMode ? onTap : null,
        borderRadius: BorderRadius.circular(dt.radiusMd),
        child: Ink(
          padding: EdgeInsets.symmetric(
            horizontal: dt.x3 + dt.x1,
            vertical: dt.x3,
          ),
          decoration: BoxDecoration(
            color: dt.white,
            borderRadius: BorderRadius.circular(dt.radiusMd),
            border: selected ? Border.all(color: dt.pinkHot) : null,
            boxShadow: dt.shadowSm,
          ),
          child: Row(
            children: [
              Container(
                width: dt.x9 + dt.x1,
                height: dt.x9 + dt.x1,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: gradient,
                ),
                alignment: Alignment.center,
                child: Text(
                  item.initial ?? '?',
                  style: typography.walkthroughDemoLabel.copyWith(color: dt.white),
                ),
              ),
              SizedBox(width: dt.x3),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(item.title, style: typography.walkthroughDemoLabel),
                    if (item.subtitle.isNotEmpty) ...[
                      SizedBox(height: dt.x1 - 1),
                      Text(
                        item.subtitle,
                        style: typography.moduleCardSubtitle.copyWith(
                          color: dt.walkthroughMuted,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
              if (selectMode) _SelectionBadge(selected: selected),
            ],
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
        color: selected ? dt.pinkHot : dt.white,
        shape: BoxShape.circle,
        border: Border.all(color: selected ? dt.pinkHot : dt.divider),
      ),
      child: selected
          ? Icon(PhosphorIconsRegular.check, color: dt.white, size: dt.x3)
          : null,
    );
  }
}
