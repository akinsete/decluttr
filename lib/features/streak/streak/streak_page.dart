import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/testing/widget_keys.dart';
import '../../../../core/theme/theme.dart';
import '../../../../l10n/l10n.dart';
import 'streak_vm_notifier.dart';

@RoutePage()
class StreakPage extends ConsumerWidget {
  const StreakPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    final vmAsync = ref.watch(streakVmProvider);

    return Scaffold(
      key: WidgetKeys.streakPage,
      backgroundColor: context.decluttrTheme.canvas,
      appBar: AppBar(title: Text(l10n.streakTitle)),
      body: vmAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (_, __) => Center(child: Text(l10n.errorGenericMessage)),
        data: (vm) {
          return SingleChildScrollView(
            padding: EdgeInsets.all(context.decluttrTheme.x7),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  l10n.streakCurrent(vm.currentStreak),
                  style: Theme.of(context).textTheme.headlineMedium,
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: context.decluttrTheme.x6),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: List.generate(vm.weekActivity.length, (i) {
                    final active = vm.weekActivity[i];
                    return Container(
                      width: 36,
                      height: 36,
                      decoration: BoxDecoration(
                        color: active ? context.decluttrTheme.pinkHot : context.decluttrTheme.surfaceCard,
                        shape: BoxShape.circle,
                        border: i == DateTime.now().weekday - 1
                            ? Border.all(color: context.decluttrTheme.ink, width: 2)
                            : null,
                      ),
                    );
                  }),
                ),
                SizedBox(height: context.decluttrTheme.x8),
                Text(l10n.streakLastWeeks,
                    style: Theme.of(context).textTheme.titleLarge),
                SizedBox(height: context.decluttrTheme.x4),
                Wrap(
                  spacing: context.decluttrTheme.x1,
                  runSpacing: context.decluttrTheme.x1,
                  children: vm.heatmap.map((level) {
                    final color = Color.lerp(
                      context.decluttrTheme.surfaceCard,
                      context.decluttrTheme.pinkHot,
                      level / 5,
                    );
                    return Container(
                      width: 16,
                      height: 16,
                      decoration: BoxDecoration(
                        color: color,
                        borderRadius: BorderRadius.circular(4),
                      ),
                    );
                  }).toList(),
                ),
                SizedBox(height: context.decluttrTheme.x3),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(l10n.streakLegendLess,
                        style: Theme.of(context).textTheme.bodySmall),
                    Text(l10n.streakLegendMore,
                        style: Theme.of(context).textTheme.bodySmall),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
