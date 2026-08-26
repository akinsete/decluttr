import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:phosphoricons_flutter/phosphoricons_flutter.dart';

import '../../../../core/di/providers.dart';
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
    final appState = ref.watch(appStateProvider);
    final notifier = ref.read(settingsUiProvider.notifier);

    return Scaffold(
      key: WidgetKeys.settingsPage,
      backgroundColor: context.decluttrTheme.canvas,
      body: ListView(
        padding: EdgeInsets.fromLTRB(
          context.decluttrTheme.screenH,
          context.decluttrTheme.x10 + MediaQuery.paddingOf(context).top,
          context.decluttrTheme.screenH,
          context.decluttrTheme.dockClearance,
        ),
        children: [
          Text(
            l10n.settingsTitle,
            style: context.decluttrTypography.walkthroughTitle,
          ),
          SizedBox(height: context.decluttrTheme.x5 + context.decluttrTheme.x1),
          _PremiumCard(onTap: () {}),
          SizedBox(height: context.decluttrTheme.x5 + context.decluttrTheme.x1),
          _SignInCard(
            signedIn: ui.signedIn,
            onTap: () => context.router.push(const SignInRoute()),
          ),
          SizedBox(height: context.decluttrTheme.x5 + context.decluttrTheme.x1),
          _SettingsSection(
            title: l10n.settingsPreferences,
            child: _SettingsCard(
              children: [
                _SettingsNavRow(
                  icon: PhosphorIconsRegular.sun,
                  iconColor: context.decluttrTheme.textSecondary,
                  label: l10n.settingsAppearance,
                  value: l10n.settingsAppearanceValue,
                  onTap: () {},
                ),
                _SettingsDivider(),
                _SettingsToggleRow(
                  icon: PhosphorIconsRegular.deviceMobile,
                  iconColor: context.decluttrTheme.success,
                  label: l10n.settingsHaptic,
                  value: ui.hapticOn,
                  onChanged: notifier.setHaptic,
                ),
                _SettingsDivider(),
                _SettingsToggleRow(
                  icon: PhosphorIconsRegular.bell,
                  iconColor: context.decluttrTheme.pinkHot,
                  label: l10n.settingsNotifications,
                  value: ui.notifOn,
                  onChanged: notifier.setNotif,
                ),
              ],
            ),
          ),
          SizedBox(height: context.decluttrTheme.x5 + context.decluttrTheme.x1),
          _SettingsSection(
            title: l10n.settingsPrivacyPermissions,
            child: _SettingsCard(
              children: [
                _SettingsNavRow(
                  icon: PhosphorIconsRegular.image,
                  iconColor: context.decluttrTheme.blue,
                  label: l10n.settingsPhotosAccess,
                  value: appState.photosGranted
                      ? l10n.settingsAccessFull
                      : l10n.settingsAccessDenied,
                  onTap: () {},
                ),
                _SettingsDivider(),
                _SettingsNavRow(
                  icon: PhosphorIconsRegular.user,
                  iconColor: context.decluttrTheme.blue,
                  label: l10n.settingsContactsAccess,
                  value: appState.contactsGranted
                      ? l10n.settingsAccessFull
                      : l10n.settingsAccessDenied,
                  onTap: () {},
                ),
              ],
            ),
          ),
          SizedBox(height: context.decluttrTheme.x5 + context.decluttrTheme.x1),
          _SettingsSection(
            title: l10n.settingsMore,
            child: _SettingsCard(
              children: [
                _SettingsNavRow(
                  icon: PhosphorIconsRegular.star,
                  iconColor: context.decluttrTheme.settingsRateStar,
                  label: l10n.settingsRate,
                  onTap: () {},
                ),
                _SettingsDivider(),
                _SettingsNavRow(
                  icon: PhosphorIconsRegular.shareFat,
                  iconColor: context.decluttrTheme.blue,
                  label: l10n.settingsShare,
                  onTap: () {},
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _PremiumCard extends StatelessWidget {
  const _PremiumCard({required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final dt = context.decluttrTheme;

    return Material(
      key: WidgetKeys.settingsPremiumCard,
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(dt.radiusLg + dt.x1),
        child: Ink(
          padding: EdgeInsets.symmetric(
            horizontal: dt.x4,
            vertical: dt.x3 + dt.x1,
          ),
          decoration: BoxDecoration(
            gradient: dt.settingsPremiumGradient,
            borderRadius: BorderRadius.circular(dt.radiusLg + dt.x1),
          ),
          child: Row(
            children: [
              Container(
                width: dt.x11,
                height: dt.x11,
                decoration: BoxDecoration(
                  color: dt.white,
                  borderRadius: BorderRadius.circular(dt.radiusSm),
                ),
                alignment: Alignment.center,
                child: Icon(
                  PhosphorIconsFill.crown,
                  color: dt.settingsPremiumCrown,
                  size: dt.x5 + dt.x1,
                ),
              ),
              SizedBox(width: dt.x3 + dt.x1),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      l10n.settingsPremiumTitle,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.w800,
                          ),
                    ),
                    SizedBox(height: dt.x1),
                    Text(
                      l10n.settingsPremiumSub,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: dt.settingsPremiumSubtitle,
                            fontWeight: FontWeight.w600,
                          ),
                    ),
                  ],
                ),
              ),
              Icon(
                PhosphorIconsRegular.caretRight,
                color: dt.settingsPremiumChevron,
                size: dt.x4,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _SignInCard extends StatelessWidget {
  const _SignInCard({
    required this.signedIn,
    required this.onTap,
  });

  final bool signedIn;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final dt = context.decluttrTheme;

    return Material(
      key: WidgetKeys.settingsSignInCard,
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(dt.radiusLg),
        child: Ink(
          padding: EdgeInsets.symmetric(
            horizontal: dt.x4,
            vertical: dt.x3 + dt.x1,
          ),
          decoration: BoxDecoration(
            color: dt.white,
            borderRadius: BorderRadius.circular(dt.radiusLg),
            boxShadow: dt.settingsCardShadow,
          ),
          child: Row(
            children: [
              Container(
                width: dt.x11,
                height: dt.x11,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: signedIn ? null : dt.settingsSignInAvatarBg,
                  gradient: signedIn ? dt.primaryCtaGradient : null,
                ),
                alignment: Alignment.center,
                child: signedIn
                    ? Text(
                        'A',
                        style: Theme.of(context).textTheme.titleMedium?.copyWith(
                              color: dt.white,
                              fontWeight: FontWeight.w800,
                            ),
                      )
                    : Icon(
                        PhosphorIconsRegular.user,
                        color: dt.textSecondary,
                        size: dt.x5 + dt.x1,
                      ),
              ),
              SizedBox(width: dt.x3 + dt.x1),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      l10n.settingsSignIn,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.w800,
                          ),
                    ),
                    SizedBox(height: dt.x1),
                    Text(
                      l10n.settingsSignInSub,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: dt.textSecondary,
                            fontWeight: FontWeight.w600,
                          ),
                    ),
                  ],
                ),
              ),
              Icon(
                PhosphorIconsRegular.caretRight,
                color: dt.settingsChevronMuted,
                size: dt.x4,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _SettingsSection extends StatelessWidget {
  const _SettingsSection({
    required this.title,
    required this.child,
  });

  final String title;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final dt = context.decluttrTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(left: dt.x1, bottom: dt.x2 + dt.x1),
          child: Text(
            title,
            style: Theme.of(context).textTheme.labelLarge?.copyWith(
                  color: dt.textSecondary,
                  fontWeight: FontWeight.w800,
                ),
          ),
        ),
        child,
      ],
    );
  }
}

class _SettingsCard extends StatelessWidget {
  const _SettingsCard({required this.children});

  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    final dt = context.decluttrTheme;

    return DecoratedBox(
      decoration: BoxDecoration(
        color: dt.white,
        borderRadius: BorderRadius.circular(dt.radiusLg),
        boxShadow: dt.settingsCardShadow,
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(dt.radiusLg),
        child: Column(mainAxisSize: MainAxisSize.min, children: children),
      ),
    );
  }
}

class _SettingsDivider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final dt = context.decluttrTheme;

    return Divider(
      height: 1,
      thickness: 1,
      color: dt.settingsRowDivider,
      indent: dt.x10 + dt.x1,
    );
  }
}

class _SettingsNavRow extends StatelessWidget {
  const _SettingsNavRow({
    required this.icon,
    required this.iconColor,
    required this.label,
    required this.onTap,
    this.value,
  });

  final IconData icon;
  final Color iconColor;
  final String label;
  final String? value;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final dt = context.decluttrTheme;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: dt.x4,
            vertical: dt.x3 + dt.x1,
          ),
          child: Row(
            children: [
              Icon(icon, color: iconColor, size: dt.x5 + dt.x1),
              SizedBox(width: dt.x3 + dt.x1),
              Expanded(
                child: Text(
                  label,
                  style: Theme.of(context).textTheme.labelLarge?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                ),
              ),
              if (value != null) ...[
                Text(
                  value!,
                  style: Theme.of(context).textTheme.labelLarge?.copyWith(
                        color: dt.settingsValueMuted,
                        fontWeight: FontWeight.w600,
                      ),
                ),
                SizedBox(width: dt.x2),
              ],
              Icon(
                PhosphorIconsRegular.caretRight,
                color: dt.settingsChevronMuted,
                size: dt.x3 + dt.x1,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _SettingsToggleRow extends StatelessWidget {
  const _SettingsToggleRow({
    required this.icon,
    required this.iconColor,
    required this.label,
    required this.value,
    required this.onChanged,
  });

  final IconData icon;
  final Color iconColor;
  final String label;
  final bool value;
  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) {
    final dt = context.decluttrTheme;

    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: dt.x4,
        vertical: dt.x3 + dt.x1,
      ),
      child: Row(
        children: [
          Icon(icon, color: iconColor, size: dt.x5 + dt.x1),
          SizedBox(width: dt.x3 + dt.x1),
          Expanded(
            child: Text(
              label,
              style: Theme.of(context).textTheme.labelLarge?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
            ),
          ),
          AppToggle(value: value, onChanged: onChanged),
        ],
      ),
    );
  }
}
