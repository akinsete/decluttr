import '../../core/theme/theme.dart';
import 'package:flutter/material.dart';


class SecondaryButton extends StatelessWidget {
  const SecondaryButton({
    super.key,
    required this.label,
    this.onPressed,
    this.expanded = true,
    this.keyId,
  });

  final String label;
  final VoidCallback? onPressed;
  final bool expanded;
  final Key? keyId;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final button = OutlinedButton(
      key: keyId,
      onPressed: onPressed,
      style: OutlinedButton.styleFrom(
        foregroundColor: context.decluttrTheme.ink,
        side: BorderSide(color: context.decluttrTheme.inkA(0.12)),
        minimumSize: Size(expanded ? double.infinity : 0, 52),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(context.decluttrTheme.radiusPill),
        ),
        padding: EdgeInsets.symmetric(
          horizontal: context.decluttrTheme.x6,
          vertical: context.decluttrTheme.x4,
        ),
      ),
      child: Text(label, style: theme.textTheme.titleMedium),
    );
    return expanded ? button : IntrinsicWidth(child: button);
  }
}
