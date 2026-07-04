import '../../core/theme/theme.dart';
import 'package:flutter/material.dart';


class StatusPill extends StatelessWidget {
  const StatusPill({
    super.key,
    required this.label,
    this.backgroundColor,
    this.foregroundColor,
  });

  final String label;
  final Color? backgroundColor;
  final Color? foregroundColor;

  @override
  Widget build(BuildContext context) {
    final typography = context.decluttrTypography;
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: context.decluttrTheme.x3,
        vertical: context.decluttrTheme.x1,
      ),
      decoration: BoxDecoration(
        color: backgroundColor ?? context.decluttrTheme.white,
        borderRadius: BorderRadius.circular(context.decluttrTheme.radiusFull),
        border: Border.all(color: context.decluttrTheme.inkA(0.08)),
      ),
      child: Text(
        label,
        style: typography.statusPill.copyWith(
          color: foregroundColor ?? context.decluttrTheme.inkA(0.65),
        ),
      ),
    );
  }
}
