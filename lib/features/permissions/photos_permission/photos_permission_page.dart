import 'package:auto_route/auto_route.dart';
import 'package:decluttr/gen/assets.gen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/di/providers.dart';
import '../../../../core/testing/widget_keys.dart';
import '../../../../core/theme/theme.dart';
import '../../../../core/widgets/widgets.dart';
import '../../../../l10n/l10n.dart';
import '../../../app/router/app_router.dart';

/// Privacy bullet dot — handoff `#BDB4A9`.
const _permBulletDot = Color(0xFFBDB4A9);

@RoutePage()
class PhotosPermissionPage extends ConsumerWidget {
  const PhotosPermissionPage({super.key});

  static const _topPadding = 92.0;
  static const _horizontalPadding = 30.0;
  static const _bottomPadding = 40.0;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    final typography = context.decluttrTypography;
    final dt = context.decluttrTheme;
    final topInset = MediaQuery.paddingOf(context).top;

    return Scaffold(
      key: WidgetKeys.photosPermissionPage,
      backgroundColor: dt.canvas,
      body: SafeArea(
        top: true,
        child: Padding(
          padding: EdgeInsets.fromLTRB(
            _horizontalPadding,
            (_topPadding - topInset).clamp(dt.x4, _topPadding),
            _horizontalPadding,
            _bottomPadding,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                l10n.permPhotosTitle,
                style: typography.permissionTitle,
                textAlign: TextAlign.center,
              ),
              SizedBox(height: dt.x3),
              Text(
                l10n.permPhotosSubtitle,
                style: typography.permissionSubtitle,
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 10),
              Column(
                children: [
                  HandoffFloat(child: Assets.handoff.permPhotos.image(width: 280, fit: BoxFit.contain)),
                  Transform.translate(
                    offset: const Offset(0, -28),
                    child: Column(
                      children: [
                        _Bullet(text: l10n.permPhotosBullet1),
                        SizedBox(height: 13),
                        _Bullet(text: l10n.permPhotosBullet2),
                        SizedBox(height: 13),
                        _Bullet(text: l10n.permPhotosBullet3),
                      ],
                    ),
                  ),
                ],
              ),
              const Spacer(),
              PrimaryButton(
                label: l10n.permPhotosAllowCta,
                height: 56,
                gradient: dt.primaryCtaGradient,
                onPressed: () async {
                  final granted = await ref.read(permissionsProvider.notifier).requestPhotos();
                  if (!context.mounted) return;
                  if (granted) {
                    context.router.replace(const BatchPhotosRoute());
                  } else {
                    context.router.replace(ErrorRoute(variant: ErrorVariant.permission));
                  }
                },
              ),
              TextButton(
                onPressed: () => context.router.replaceAll([const MainShellRoute()]),
                style: TextButton.styleFrom(
                  foregroundColor: dt.textSecondary,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  textStyle: typography.permissionDismiss,
                ),
                child: Text(l10n.permNotNow),
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
    final typography = context.decluttrTypography;

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 5,
          height: 5,
          decoration: const BoxDecoration(color: _permBulletDot, shape: BoxShape.circle),
        ),
        SizedBox(width: 11),
        Text(
          text,
          style: typography.permissionBullet,
        ),
      ],
    );
  }
}
