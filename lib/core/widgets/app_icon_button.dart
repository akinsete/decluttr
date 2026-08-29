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
    final dt = context.decluttrTheme;
    // DecoratedBox carries the circular shadow; Ink alone inside Material can
    // produce a flat hit target that misses taps on some devices.
    return Semantics(
      button: true,
      child: Material(
        key: keyId,
        color: Colors.transparent,
        child: InkWell(
          onTap: onPressed,
          customBorder: const CircleBorder(),
          child: Ink(
            width: size,
            height: size,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: dt.white,
              boxShadow: dt.shadowXs,
            ),
            child: Icon(icon, color: dt.ink, size: dt.x6),
          ),
        ),
      ),
    );
  }
}

IconData backIcon() => PhosphorIconsRegular.arrowLeft;

