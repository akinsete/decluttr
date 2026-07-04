import '../../core/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:phosphoricons_flutter/phosphoricons_flutter.dart';


class ModuleCard extends StatelessWidget {
  const ModuleCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.gradient,
    this.onTap,
    this.leading,
    this.subtitleColor,
    this.keyId,
  });

  final String title;
  final String subtitle;
  final Gradient gradient;
  final VoidCallback? onTap;
  final Widget? leading;
  final Color? subtitleColor;
  final Key? keyId;

  @override
  Widget build(BuildContext context) {
    final typography = context.decluttrTypography;
    return Material(
      key: keyId,
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(context.decluttrTheme.radiusXl),
        child: Ink(
          padding: EdgeInsets.symmetric(
            horizontal: context.decluttrTheme.x4,
            vertical: context.decluttrTheme.x5,
          ),
          decoration: BoxDecoration(
            gradient: gradient,
            borderRadius: BorderRadius.circular(context.decluttrTheme.radiusXl),
          ),
          child: Row(
            children: [
              if (leading != null) ...[
                leading!,
                SizedBox(width: context.decluttrTheme.x3),
              ],
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: typography.moduleCardTitle,
                    ),
                    SizedBox(height: context.decluttrTheme.x1),
                    Text(
                      subtitle,
                      style: typography.moduleCardSubtitle.copyWith(
                        color: subtitleColor ?? context.decluttrTheme.inkA(0.65),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                width: 32,
                height: 32,
                decoration: BoxDecoration(
                  color: context.decluttrTheme.white,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: context.decluttrTheme.inkA(0.08),
                      blurRadius: 12,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Icon(
                  PhosphorIconsRegular.caretRight,
                  color: subtitleColor ?? context.decluttrTheme.ink,
                  size: 16,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
