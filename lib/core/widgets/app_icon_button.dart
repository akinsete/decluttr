import '../../core/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:phosphoricons_flutter/phosphoricons_flutter.dart';


class AppIconButton extends StatelessWidget {
  const AppIconButton({
    super.key,
    required this.icon,
    this.onPressed,
    this.size = 44,
    this.keyId,
  });

  final IconData icon;
  final VoidCallback? onPressed;
  final double size;
  final Key? keyId;

  @override
  Widget build(BuildContext context) {
    return Material(
      key: keyId,
      color: context.decluttrTheme.white,
      elevation: 0,
      shadowColor: Colors.transparent,
      shape: const CircleBorder(),
      child: InkWell(
        onTap: onPressed,
        customBorder: const CircleBorder(),
        child: Ink(
          width: size,
          height: size,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: context.decluttrTheme.white,
            boxShadow: context.decluttrTheme.shadowXs,
          ),
          child: Icon(icon, color: context.decluttrTheme.ink, size: context.decluttrTheme.x6),
        ),
      ),
    );
  }
}

IconData backIcon() => PhosphorIconsRegular.arrowLeft;

