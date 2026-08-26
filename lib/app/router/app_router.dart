import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../../features/batch/batch_contacts/batch_contacts_page.dart';
import '../../features/batch/batch_photos/batch_photos_page.dart';
import '../../features/duplicates/duplicate_contacts/duplicate_contacts_page.dart';
import '../../features/errors/error/error_page.dart';
import '../../features/errors/error/error_variant.dart';
import '../../features/home/home/home_page.dart';
import '../../features/insights/insights/insights_page.dart';
import '../../features/onboarding/splash/splash_page.dart';
import '../../features/onboarding/walkthrough/walkthrough_page.dart';
import '../../features/onboarding/welcome/welcome_page.dart';
import '../../features/permissions/contacts_permission/contacts_permission_page.dart';
import '../../features/permissions/photos_permission/photos_permission_page.dart';
import '../../features/settings/settings/settings_page.dart';
import '../../features/settings/sign_in/sign_in_page.dart';
import '../../features/shell/main_shell/main_shell_page.dart';
import '../../features/streak/streak/streak_page.dart';
import '../../features/swipe/session_summary/session_summary_page.dart';
import '../../features/swipe/swipe_session/swipe_session_page.dart';
import '../../features/trash/trash/trash_page.dart';

export '../../features/errors/error/error_variant.dart';

part 'app_router.gr.dart';

@AutoRouterConfig(replaceInRouteName: 'Page,Route')
class AppRouter extends RootStackRouter {
  AppRouter({super.navigatorKey});

  @override
  List<AutoRoute> get routes => [
        AutoRoute(page: SplashRoute.page, initial: true),
        AutoRoute(page: WelcomeRoute.page),
        AutoRoute(page: WalkthroughRoute.page),
        AutoRoute(page: ContactsPermissionRoute.page),
        AutoRoute(page: PhotosPermissionRoute.page),
        AutoRoute(
          page: MainShellRoute.page,
          children: [
            AutoRoute(page: HomeRoute.page, initial: true),
            AutoRoute(page: TrashRoute.page),
            AutoRoute(page: SettingsRoute.page),
          ],
        ),
        AutoRoute(page: BatchPhotosRoute.page),
        AutoRoute(page: BatchContactsRoute.page),
        AutoRoute(page: SwipeSessionRoute.page),
        AutoRoute(page: SessionSummaryRoute.page),
        AutoRoute(page: DuplicateContactsRoute.page),
        AutoRoute(page: InsightsRoute.page),
        AutoRoute(page: StreakRoute.page),
        AutoRoute(page: SignInRoute.page),
        AutoRoute(page: ErrorRoute.page),
      ];

}
