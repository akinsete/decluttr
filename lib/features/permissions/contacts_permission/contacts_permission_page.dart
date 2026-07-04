import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:decluttr/gen/assets.gen.dart';
import '../../../../core/di/providers.dart';
import '../../../../core/testing/widget_keys.dart';
import '../../../../core/theme/theme.dart';
import '../../../../core/widgets/widgets.dart';
import '../../../../l10n/l10n.dart';
import '../../../app/router/app_router.dart';

@RoutePage()
class ContactsPermissionPage extends ConsumerWidget {
  const ContactsPermissionPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    final typography = context.decluttrTypography;

    return Scaffold(
      key: WidgetKeys.contactsPermissionPage,
      backgroundColor: context.decluttrTheme.canvas,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.fromLTRB(
            context.decluttrTheme.screenHLoose,
            context.decluttrTheme.x11,
            context.decluttrTheme.screenHLoose,
            context.decluttrTheme.x9,
          ),
          child: Column(
            children: [
              Text(
                l10n.permContactsTitle,
                style: typography.permissionTitle,
                textAlign: TextAlign.center,
              ),
              SizedBox(height: context.decluttrTheme.x8),
              HandoffFloat(
                child: Assets.handoff.permContacts.image(
                  width: 280,
                  fit: BoxFit.contain,
                ),
              ),
              SizedBox(height: context.decluttrTheme.x8),
              _Bullet(text: l10n.permContactsBullet1),
              _Bullet(text: l10n.permContactsBullet2),
              _Bullet(text: l10n.permContactsBullet3),
              const Spacer(),
              PrimaryButton(
                label: l10n.permAllowAccess,
                onPressed: () async {
                  final granted =
                      await ref.read(permissionsProvider.notifier).requestContacts();
                  if (!context.mounted) return;
                  if (granted) {
                    context.router.replace(const BatchContactsRoute());
                  } else {
                    context.router.replace(
                      ErrorRoute(variant: ErrorVariant.contacts),
                    );
                  }
                },
              ),
              SizedBox(height: context.decluttrTheme.x3),
              SecondaryButton(
                label: l10n.permNotNow,
                onPressed: () =>
                    context.router.replaceAll([const MainShellRoute()]),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _Bullet extends StatelessWidget {
  const _Bullet({required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: context.decluttrTheme.x2),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 5,
            height: 5,
            margin: EdgeInsets.only(top: 8),
            decoration: BoxDecoration(
              color: context.decluttrTheme.ink,
              shape: BoxShape.circle,
            ),
          ),
          SizedBox(width: context.decluttrTheme.x3),
          Expanded(child: Text(text, style: context.decluttrTypography.permissionBullet)),
        ],
      ),
    );
  }
}
