import 'package:flutter/material.dart';

import '../../../core/testing/widget_keys.dart';
import '../../../core/theme/theme.dart';
import '../../../core/widgets/primary_button.dart';

class TrashBottomBar extends StatelessWidget {
  const TrashBottomBar({
    super.key,
    required this.itemsLabel,
    required this.sizeLabel,
    required this.actionLabel,
    required this.cancelLabel,
    required this.selectedLabel,
    required this.selectMode,
    required this.onDeleteForever,
    required this.onCancelSelect,
  });

  final String itemsLabel;
  final String sizeLabel;
  final String actionLabel;
  final String cancelLabel;
  final String selectedLabel;
  final bool selectMode;
  final VoidCallback onDeleteForever;
  final VoidCallback onCancelSelect;

  @override
  Widget build(BuildContext context) {
    final dt = context.decluttrTheme;
    final typography = context.decluttrTypography;

    return Container(
      key: WidgetKeys.trashBottomBar,
      margin: EdgeInsets.fromLTRB(dt.x4, 0, dt.x4, dt.x6),
      padding: EdgeInsets.symmetric(
        horizontal: dt.x4,
        vertical: dt.x3 + dt.x1,
      ),
      decoration: BoxDecoration(
        color: dt.trashBarFill,
        borderRadius: BorderRadius.circular(dt.radiusCard),
        boxShadow: dt.shadowMd,
      ),
      child: Row(
        children: [
          Expanded(
            child: selectMode
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        selectedLabel,
                        style: typography.primaryButton.copyWith(color: dt.ink),
                      ),
                      TextButton(
                        onPressed: onCancelSelect,
                        style: TextButton.styleFrom(
                          padding: EdgeInsets.zero,
                          minimumSize: Size.zero,
                          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          foregroundColor: dt.trashBarSizeText,
                        ),
                        child: Text(
                          cancelLabel,
                          style: typography.moduleCardSubtitle.copyWith(
                            color: dt.trashBarSizeText,
                          ),
                        ),
                      ),
                    ],
                  )
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        itemsLabel,
                        style: typography.primaryButton.copyWith(color: dt.ink),
                      ),
                      Text(
                        sizeLabel,
                        style: typography.moduleCardSubtitle.copyWith(
                          color: dt.trashBarSizeText,
                        ),
                      ),
                    ],
                  ),
          ),
          PrimaryButton(
            keyId: WidgetKeys.trashDeleteForeverButton,
            label: actionLabel,
            expanded: false,
            gradient: selectMode ? null : dt.primaryCtaGradient,
            backgroundColor: selectMode ? dt.white : null,
            foregroundColor: selectMode ? dt.walkthroughDelete : null,
            onPressed: onDeleteForever,
          ),
        ],
      ),
    );
  }
}
