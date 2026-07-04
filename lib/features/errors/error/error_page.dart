import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:phosphoricons_flutter/phosphoricons_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../core/testing/widget_keys.dart';
import '../../../../core/theme/theme.dart';
import '../../../../core/widgets/widgets.dart';
import '../../../../l10n/l10n.dart';
import '../../../app/router/app_router.dart';
import 'error_variant.dart';

@RoutePage()
class ErrorPage extends ConsumerWidget {
  const ErrorPage({
    super.key,
    this.variant = ErrorVariant.generic,
  });

  final ErrorVariant variant;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    final copy = _copyForVariant(l10n, variant);

    return Scaffold(
      key: WidgetKeys.errorPage,
      backgroundColor: context.decluttrTheme.canvas,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(context.decluttrTheme.x7),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  color: context.decluttrTheme.errorCircle,
                  shape: BoxShape.circle,
                ),
                child: Icon(copy.icon, color: context.decluttrTheme.errorIcon, size: 44),
              ),
              SizedBox(height: context.decluttrTheme.x6),
              Text(
                copy.title,
                style: Theme.of(context).textTheme.headlineMedium,
                textAlign: TextAlign.center,
              ),
              SizedBox(height: context.decluttrTheme.x3),
              Text(
                copy.message,
                style: Theme.of(context).textTheme.bodyMedium,
                textAlign: TextAlign.center,
              ),
              SizedBox(height: context.decluttrTheme.x8),
              PrimaryButton(
                label: copy.primaryLabel,
                onPressed: () => _onPrimary(context, variant),
              ),
              SizedBox(height: context.decluttrTheme.x3),
              SecondaryButton(
                label: copy.secondaryLabel,
                onPressed: () => _onSecondary(context, variant),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _onPrimary(BuildContext context, ErrorVariant variant) {
    switch (variant) {
      case ErrorVariant.contacts:
        launchUrl(Uri.parse('app-settings:'));
      case ErrorVariant.permission:
        context.router.replace(const PhotosPermissionRoute());
      case ErrorVariant.photos:
      case ErrorVariant.generic:
        context.router.replaceAll([const MainShellRoute()]);
    }
  }

  void _onSecondary(BuildContext context, ErrorVariant variant) {
    switch (variant) {
      case ErrorVariant.contacts:
        context.router.replaceAll([const MainShellRoute()]);
      default:
        context.router.replaceAll([const MainShellRoute()]);
    }
  }

  _ErrorCopy _copyForVariant(dynamic l10n, ErrorVariant variant) {
    return switch (variant) {
      ErrorVariant.photos => _ErrorCopy(
          icon: PhosphorIconsRegular.imageBroken,
          title: l10n.errorPhotosTitle,
          message: l10n.errorPhotosMessage,
          primaryLabel: l10n.errorTryAgain,
          secondaryLabel: l10n.errorGoHome,
        ),
      ErrorVariant.contacts => _ErrorCopy(
          icon: PhosphorIconsRegular.addressBook,
          title: l10n.errorContactsTitle,
          message: l10n.errorContactsMessage,
          primaryLabel: l10n.errorOpenSettings,
          secondaryLabel: l10n.errorNotNow,
        ),
      ErrorVariant.permission => _ErrorCopy(
          icon: PhosphorIconsRegular.shieldWarning,
          title: l10n.errorPermissionTitle,
          message: l10n.errorPermissionMessage,
          primaryLabel: l10n.errorReconnect,
          secondaryLabel: l10n.errorGoHome,
        ),
      ErrorVariant.generic => _ErrorCopy(
          icon: PhosphorIconsRegular.warning,
          title: l10n.errorGenericTitle,
          message: l10n.errorGenericMessage,
          primaryLabel: l10n.errorTryAgain,
          secondaryLabel: l10n.errorGoHome,
        ),
    };
  }
}

class _ErrorCopy {
  const _ErrorCopy({
    required this.icon,
    required this.title,
    required this.message,
    required this.primaryLabel,
    required this.secondaryLabel,
  });

  final IconData icon;
  final String title;
  final String message;
  final String primaryLabel;
  final String secondaryLabel;
}
