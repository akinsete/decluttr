import '../../core/theme/theme.dart';
import 'package:flutter/material.dart';


class IconTile extends StatelessWidget {
  const IconTile({
    super.key,
    required this.icon,
    this.size = 44,
    this.gradient,
    this.backgroundColor,
  });

  final IconData icon;
  final double size;
  final Gradient? gradient;
  final Color? backgroundColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(context.decluttrTheme.radiusXs),
        gradient: gradient,
        color: gradient == null ? (backgroundColor ?? context.decluttrTheme.surfaceCard) : null,
      ),
      child: Icon(icon, color: context.decluttrTheme.ink, size: size * 0.45),
    );
  }
}
