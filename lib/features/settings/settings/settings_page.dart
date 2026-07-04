import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:phosphoricons_flutter/phosphoricons_flutter.dart';

import '../../../../core/testing/widget_keys.dart';
import '../../../../core/theme/theme.dart';
import '../../../../core/widgets/widgets.dart';
import '../../../../l10n/l10n.dart';
import '../../../app/router/app_router.dart';
import 'settings_notifier.dart';

@RoutePage()
class SettingsPage extends ConsumerWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    final ui = ref.watch(settingsUiProvider);
    final notifier = ref.read(settingsUiProvider.notifier);

    return Scaffold(
      key: WidgetKeys.settingsPage,
      backgroundColor: context.decluttrTheme.canvas,
      appBar: AppBar(title: Text(l10n.settingsTitle)),
      body: ListView(
        padding: EdgeInsets.fromLTRB(
          context.decluttrTheme.screenH,
          context.decluttrTheme.x4,
          context.decluttrTheme.screenH,
          context.decluttrTheme.dockClearance,
        ),
        children: [
          Container(
            padding: EdgeInsets.all(context.decluttrTheme.x5),
            decoration: BoxDecoration(
              gradient: context.decluttrTheme.premiumGradient,
              borderRadius: BorderRadius.circular(context.decluttrTheme.radiusXl),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(l10n.settingsPremiumTitle,
                    style: Theme.of(context).textTheme.titleLarge),
                SizedBox(height: context.decluttrTheme.x2),
                Text(l10n.settingsPremiumSub,
                    style: Theme.of(context).textTheme.bodyMedium),
              ],
            ),
          ),
          SizedBox(height: context.decluttrTheme.x6),
          Text(l10n.settingsPreferences,
              style: Theme.of(context).textTheme.bodySmall),
          _SettingsRow(
            label: l10n.settingsAppearance,
            trailing: l10n.settingsAppearanceValue,
          ),
          _ToggleRow(
            label: l10n.settingsHaptic,
            value: ui.hapticOn,
            onChanged: notifier.setHaptic,
          ),
          _ToggleRow(
            label: l10n.settingsNotifications,
            value: ui.notifOn,
            onChanged: notifier.setNotif,
          ),
          SizedBox(height: context.decluttrTheme.x6),
          Text(l10n.settingsAccount,
              style: Theme.of(context).textTheme.bodySmall),
          ListTile(
            title: Text(l10n.settingsSignIn),
            trailing: Icon(PhosphorIconsRegular.caretRight),
            onTap: () => context.router.push(const SignInRoute()),
          ),
          ListTile(
            title: Text(
              l10n.settingsDeleteAccount,
              style: TextStyle(color: context.decluttrTheme.destructiveStrong),
            ),
          ),
          ListTile(
            title: Text(l10n.settingsRate),
            trailing: Icon(PhosphorIconsRegular.caretRight),
          ),
          ListTile(
            title: Text(l10n.settingsShare),
            trailing: Icon(PhosphorIconsRegular.caretRight),
          ),
        ],
      ),
    );
  }
}

class _SettingsRow extends StatelessWidget {
  const _SettingsRow({required this.label, required this.trailing});

  final String label;
  final String trailing;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(label),
      trailing: Text(trailing, style: Theme.of(context).textTheme.bodyMedium),
    );
  }
}

class _ToggleRow extends StatelessWidget {
  const _ToggleRow({
    required this.label,
    required this.value,
    required this.onChanged,
  });

  final String label;
  final bool value;
  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(label),
      trailing: AppToggle(value: value, onChanged: onChanged),
    );
  }
}
