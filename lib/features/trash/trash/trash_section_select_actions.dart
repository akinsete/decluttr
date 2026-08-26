import 'package:flutter/material.dart';

import '../../../core/testing/widget_keys.dart';
import '../../../core/theme/theme.dart';

class TrashSectionSelectActions extends StatelessWidget {
  const TrashSectionSelectActions({
    super.key,
    required this.selectMode,
    required this.allSelected,
    required this.selectLabel,
    required this.selectAllLabel,
    required this.deselectAllLabel,
    required this.onSelectPressed,
    required this.onSelectAllPressed,
    required this.onDeselectAllPressed,
  });

  final bool selectMode;
  final bool allSelected;
  final String selectLabel;
  final String selectAllLabel;
  final String deselectAllLabel;
  final VoidCallback onSelectPressed;
  final VoidCallback onSelectAllPressed;
  final VoidCallback onDeselectAllPressed;

  @override
  Widget build(BuildContext context) {
    final dt = context.decluttrTheme;
    final typography = context.decluttrTypography;
    final labelStyle = typography.walkthroughDemoLabel.copyWith(color: dt.pinkHot);
    final buttonStyle = TextButton.styleFrom(
      padding: EdgeInsets.zero,
      minimumSize: Size.zero,
      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
      foregroundColor: dt.pinkHot,
    );

    if (selectMode) {
      return TextButton(
        key: WidgetKeys.trashSelectAllButton,
        onPressed: allSelected ? onDeselectAllPressed : onSelectAllPressed,
        style: buttonStyle,
        child: Text(allSelected ? deselectAllLabel : selectAllLabel, style: labelStyle),
      );
    }

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        TextButton(
          key: WidgetKeys.trashSelectButton,
          onPressed: onSelectPressed,
          style: buttonStyle,
          child: Text(selectLabel, style: labelStyle),
        ),
        SizedBox(width: dt.x3),
        TextButton(
          key: WidgetKeys.trashSelectAllButton,
          onPressed: onSelectAllPressed,
          style: buttonStyle,
          child: Text(selectAllLabel, style: labelStyle),
        ),
      ],
    );
  }
}
