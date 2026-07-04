import 'package:decluttr/core/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:phosphoricons_flutter/phosphoricons_flutter.dart';

import 'package:decluttr/gen/assets.gen.dart';

class StreakCard extends StatelessWidget {
  const StreakCard({
    super.key,
    required this.streakDays,
    required this.subtitle,
    this.onTap,
    this.keyId,
  });

  final int streakDays;
  final String subtitle;
  final VoidCallback? onTap;
  final Key? keyId;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Material(
      key: keyId,
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(context.decluttrTheme.radiusLg),
        child: Ink(
          padding: EdgeInsets.all(context.decluttrTheme.x5),
          decoration: BoxDecoration(
            color: context.decluttrTheme.streakFill,
            borderRadius: BorderRadius.circular(context.decluttrTheme.radiusLg),
            border: Border.all(color: context.decluttrTheme.streakBorder),
          ),
          child: Row(
            children: [
              Assets.handoff.streakFire.image(
                width: 36,
                height: 36,
                fit: BoxFit.contain,
              ),
              SizedBox(width: context.decluttrTheme.x4),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '$streakDays Day Streak',
                      style: theme.textTheme.titleLarge,
                    ),
                    Text(subtitle, style: theme.textTheme.bodyMedium),
                  ],
                ),
              ),
              Icon(
                PhosphorIconsRegular.caretRight,
                color: context.decluttrTheme.inkA(0.45),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
