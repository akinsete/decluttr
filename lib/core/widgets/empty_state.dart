import '../../core/theme/theme.dart';
import 'package:flutter/material.dart';

import '../testing/widget_keys.dart';
import 'primary_button.dart';

class EmptyState extends StatelessWidget {
  const EmptyState({
    super.key,
    required this.title,
    required this.subtitle,
    this.actionLabel,
    this.onAction,
    this.illustration,
  });

  final String title;
  final String subtitle;
  final String? actionLabel;
  final VoidCallback? onAction;
  final Widget? illustration;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final dt = context.decluttrTheme;

    final content = Padding(
      padding: EdgeInsets.all(dt.x8),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (illustration != null) ...[
            illustration!,
            SizedBox(height: dt.x6),
          ],
          Text(
            title,
            style: theme.textTheme.headlineSmall,
            textAlign: TextAlign.center,
          ),
          SizedBox(height: dt.x3),
          Text(
            subtitle,
            style: theme.textTheme.bodyMedium,
            textAlign: TextAlign.center,
          ),
          if (actionLabel != null && onAction != null) ...[
            SizedBox(height: dt.x6),
            PrimaryButton(label: actionLabel!, onPressed: onAction),
          ],
        ],
      ),
    );

    return SizedBox.expand(
      child: Center(
        key: WidgetKeys.emptyState,
        child: content,
      ),
    );
  }
}
