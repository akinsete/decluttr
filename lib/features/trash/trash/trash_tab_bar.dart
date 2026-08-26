import 'package:flutter/material.dart';

import '../../../core/theme/theme.dart';
import 'trash_state.dart';

class TrashTabBar extends StatelessWidget {
  const TrashTabBar({
    super.key,
    required this.selected,
    required this.photoCount,
    required this.contactCount,
    required this.photoLabel,
    required this.contactLabel,
    required this.onChanged,
  });

  final TrashTab selected;
  final int photoCount;
  final int contactCount;
  final String Function(int count) photoLabel;
  final String Function(int count) contactLabel;
  final ValueChanged<TrashTab> onChanged;

  @override
  Widget build(BuildContext context) {
    final dt = context.decluttrTheme;
    final typography = context.decluttrTypography;

    return Row(
      children: [
        _TrashTabChip(
          label: photoLabel(photoCount),
          selected: selected == TrashTab.photos,
          onTap: () => onChanged(TrashTab.photos),
          selectedBackground: dt.deletedStatCircleFill,
          selectedColor: dt.pinkHot,
          labelStyle: typography.walkthroughDemoLabel,
          dt: dt,
        ),
        SizedBox(width: dt.x3 - dt.x1),
        _TrashTabChip(
          label: contactLabel(contactCount),
          selected: selected == TrashTab.contacts,
          onTap: () => onChanged(TrashTab.contacts),
          selectedBackground: dt.deletedStatCircleFill,
          selectedColor: dt.pinkHot,
          labelStyle: typography.walkthroughDemoLabel,
          dt: dt,
        ),
      ],
    );
  }
}

class _TrashTabChip extends StatelessWidget {
  const _TrashTabChip({
    required this.label,
    required this.selected,
    required this.onTap,
    required this.selectedBackground,
    required this.selectedColor,
    required this.labelStyle,
    required this.dt,
  });

  final String label;
  final bool selected;
  final VoidCallback onTap;
  final Color selectedBackground;
  final Color selectedColor;
  final TextStyle labelStyle;
  final DecluttrTheme dt;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(dt.radiusFull),
        child: Ink(
          padding: EdgeInsets.symmetric(
            horizontal: dt.x5,
            vertical: dt.x3 - dt.x1,
          ),
          decoration: BoxDecoration(
            color: selected ? selectedBackground : dt.surfaceCard,
            borderRadius: BorderRadius.circular(dt.radiusFull),
          ),
          child: Text(
            label,
            style: labelStyle.copyWith(
              color: selected ? selectedColor : dt.walkthroughMuted,
            ),
          ),
        ),
      ),
    );
  }
}
