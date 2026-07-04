import '../../core/theme/theme.dart';
import 'package:flutter/material.dart';


class PrimaryButton extends StatelessWidget {
  const PrimaryButton({
    super.key,
    required this.label,
    this.onPressed,
    this.isLoading = false,
    this.expanded = true,
    this.backgroundColor,
    this.foregroundColor,
    this.gradient,
    this.height = 52,
    this.keyId,
  });

  final String label;
  final VoidCallback? onPressed;
  final bool isLoading;
  final bool expanded;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final LinearGradient? gradient;
  final double height;
  final Key? keyId;

  @override
  Widget build(BuildContext context) {
    final typography = context.decluttrTypography;
    final labelColor = foregroundColor ?? context.decluttrTheme.white;
    final child = isLoading
        ? SizedBox(
            height: context.decluttrTheme.x6,
            width: context.decluttrTheme.x6,
            child: CircularProgressIndicator(
              strokeWidth: 2,
              color: labelColor,
            ),
          )
        : Text(
            label,
            style: (gradient != null ? typography.primaryCta : typography.primaryButton)
                .copyWith(color: labelColor),
          );

    final minSize = Size(expanded ? double.infinity : 0, height);
    final borderRadius = BorderRadius.circular(context.decluttrTheme.radiusPill);
    final shape = RoundedRectangleBorder(borderRadius: borderRadius);
    final padding = EdgeInsets.symmetric(
      horizontal: context.decluttrTheme.x6,
      vertical: context.decluttrTheme.x4,
    );

    final Widget button;
    if (gradient != null) {
      button = Material(
        key: keyId,
        color: Colors.transparent,
        child: InkWell(
          onTap: isLoading ? null : onPressed,
          borderRadius: borderRadius,
          child: Ink(
            decoration: BoxDecoration(
              gradient: gradient,
              borderRadius: borderRadius,
            ),
            child: Container(
              constraints: BoxConstraints(
                minWidth: minSize.width,
                minHeight: minSize.height,
              ),
              padding: padding,
              alignment: Alignment.center,
              child: child,
            ),
          ),
        ),
      );
    } else {
      button = FilledButton(
        key: keyId,
        onPressed: isLoading ? null : onPressed,
        style: FilledButton.styleFrom(
          backgroundColor: backgroundColor ?? context.decluttrTheme.ink,
          foregroundColor: labelColor,
          minimumSize: minSize,
          shape: shape,
          padding: padding,
        ),
        child: child,
      );
    }

    return expanded ? button : IntrinsicWidth(child: button);
  }
}
