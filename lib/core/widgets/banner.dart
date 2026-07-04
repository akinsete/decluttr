import '../../core/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:phosphoricons_flutter/phosphoricons_flutter.dart';


class Banner extends StatelessWidget {
  const Banner({
    super.key,
    required this.message,
    this.onDismiss,
    this.actionLabel,
    this.onAction,
  });

  final String message;
  final VoidCallback? onDismiss;
  final String? actionLabel;
  final VoidCallback? onAction;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Material(
      color: context.decluttrTheme.surfaceCard,
      borderRadius: BorderRadius.circular(context.decluttrTheme.radiusMd),
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: context.decluttrTheme.x4,
          vertical: context.decluttrTheme.x3,
        ),
        child: Row(
          children: [
            Expanded(
              child: Text(message, style: theme.textTheme.bodyLarge),
            ),
            if (actionLabel != null)
              TextButton(onPressed: onAction, child: Text(actionLabel!)),
            if (onDismiss != null)
              IconButton(
                onPressed: onDismiss,
                icon: Icon(PhosphorIconsRegular.x, size: 18),
              ),
          ],
        ),
      ),
    );
  }
}
