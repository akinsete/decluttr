import 'package:flutter/material.dart';

/// Widget keys for integration and widget tests.
abstract final class WidgetKeys {
  static const splashPage = Key('splash_page');
  static const splashProgress = Key('splash_progress');
  static const welcomePage = Key('welcome_page');
  static const welcomeGetStarted = Key('welcome_get_started');
  static const welcomeDoItLater = Key('welcome_do_it_later');
  static const walkthroughPage = Key('walkthrough_page');
  static const walkthroughContinue = Key('walkthrough_continue');
  static const contactsPermissionPage = Key('contacts_permission_page');
  static const photosPermissionPage = Key('photos_permission_page');
  static const homePage = Key('home_page');
  static const homeContactsCard = Key('home_contacts_card');
  static const homePhotosCard = Key('home_photos_card');
  static const homeStreakCard = Key('home_streak_card');
  static const mainShell = Key('main_shell');
  static const appDock = Key('app_dock');
  static const batchPhotosPage = Key('batch_photos_page');
  static const batchContactsPage = Key('batch_contacts_page');
  static const swipeSessionPage = Key('swipe_session_page');
  static const swipeKeepButton = Key('swipe_keep_button');
  static const swipeDeleteButton = Key('swipe_delete_button');
  static const sessionSummaryPage = Key('session_summary_page');
  static const duplicateContactsPage = Key('duplicate_contacts_page');
  static const trashPage = Key('trash_page');
  static const streakPage = Key('streak_page');
  static const settingsPage = Key('settings_page');
  static const signInPage = Key('sign_in_page');
  static const errorPage = Key('error_page');
  static const primaryButton = Key('primary_button');
  static const secondaryButton = Key('secondary_button');
  static const emptyState = Key('empty_state');
}
