// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'Decluttr';

  @override
  String get splashTagline => 'Keep what matters.\nDelete the rest.';

  @override
  String get welcomeHeadlineSuffix => 'your digital life';

  @override
  String get welcomeSubtitle =>
      'Swipe to keep the good and get rid of what you don\'t need.';

  @override
  String get welcomeGetStarted => 'Get started';

  @override
  String get welcomeReplay => 'Replay splash';

  @override
  String get welcomeDoItLater => 'I\'ll do this later';

  @override
  String get walkthroughTitle => 'How it works';

  @override
  String get walkthroughSubtitle => 'Swipe to sort, tap for a closer look.';

  @override
  String get walkthroughKeepHint => 'Swipe right to keep';

  @override
  String get walkthroughDeleteHint => 'Swipe left to delete';

  @override
  String get walkthroughTapHint => 'Tap to view details';

  @override
  String get walkthroughContinue => 'Get started';

  @override
  String get walkthroughSkip => 'Do it later';

  @override
  String get permContactsTitle => 'Allow access to your Contacts';

  @override
  String get permContactsBullet1 => 'Find duplicates and outdated entries';

  @override
  String get permContactsBullet2 => 'Merge contacts safely on your device';

  @override
  String get permContactsBullet3 => 'Nothing is uploaded without your consent';

  @override
  String get permPhotosTitle => 'Allow access to\nyour Photos';

  @override
  String get permPhotosSubtitle =>
      'We need access to find and show your photos for cleanup.';

  @override
  String get permPhotosBullet1 => 'Your photos stay private';

  @override
  String get permPhotosBullet2 => 'We never upload anything';

  @override
  String get permPhotosBullet3 => 'You\'re in control';

  @override
  String get permPhotosAllowCta => 'Allow photos access';

  @override
  String get permAllowAccess => 'Allow access';

  @override
  String get permNotNow => 'Not now';

  @override
  String get permMaybeLater => 'Maybe later';

  @override
  String get homeGreetingFirst => 'Welcome 👋';

  @override
  String get homeGreetingReturn => 'Welcome back 👋';

  @override
  String get homeHeroLine1 => 'Ready for a';

  @override
  String get homeHeroLine2Lead => 'quick ';

  @override
  String get homeHeroAccent => 'cleanup?';

  @override
  String get homeHeroSub => 'Swipe through photos and contacts in minutes.';

  @override
  String get homeStreakSubtitle => 'Keep your momentum going!';

  @override
  String get homeContactsTitle => 'Contacts';

  @override
  String get homePhotosTitle => 'Photos & Videos';

  @override
  String get homeTapToStart => 'Tap to get started';

  @override
  String homeContactsWaiting(int count) {
    return '$count waiting for you';
  }

  @override
  String homePhotosWaiting(int count) {
    return '$count waiting for you';
  }

  @override
  String get homeProgressTitle => 'Your progress';

  @override
  String homeProgressStats(int kept, int deleted) {
    return '$kept kept · $deleted cleared';
  }

  @override
  String get dockHome => 'Home';

  @override
  String get dockTrash => 'Trash';

  @override
  String get dockSettings => 'Settings';

  @override
  String get batchPhotosTitle => 'Photos & Videos';

  @override
  String get batchContactsTitle => 'Contacts';

  @override
  String get batchEmptyTitle => 'All caught up ✓';

  @override
  String get batchEmptyPhotosSub =>
      'You have cleared every photo batch for now.';

  @override
  String get batchEmptyContactsSub =>
      'You have cleared every contact group for now.';

  @override
  String swipeProgress(int current, int total) {
    return '$current / $total';
  }

  @override
  String get swipeTutorial => 'Swipe right to keep, left to delete';

  @override
  String get swipeDismissTutorial => 'Got it';

  @override
  String get swipeKeep => 'Keep';

  @override
  String get swipeDelete => 'Delete';

  @override
  String get swipeUndo => 'Undo';

  @override
  String get sessionSummaryTitle => 'Nice work!';

  @override
  String get sessionSummarySub => 'You reviewed everything in this batch.';

  @override
  String sessionSummaryKept(int count) {
    return '$count kept';
  }

  @override
  String sessionSummaryDeleted(int count) {
    return '$count deleted';
  }

  @override
  String get sessionSummaryBack => 'Back to batches';

  @override
  String get duplicatesTitle => 'Duplicate contacts';

  @override
  String duplicatesProgress(int current, int total) {
    return '$current of $total';
  }

  @override
  String get duplicatesAfterMerge => 'After merge';

  @override
  String get duplicatesMerge => 'Merge';

  @override
  String get duplicatesKeepBoth => 'Keep both';

  @override
  String get duplicatesDeleteOne => 'Delete one';

  @override
  String get duplicatesReasonSamePhone => 'Same phone number';

  @override
  String get duplicatesReasonSameEmail => 'Same email address';

  @override
  String get duplicatesReasonSimilarName => 'Similar name';

  @override
  String get trashTitle => 'Trash';

  @override
  String trashReclaimable(String size) {
    return '$size reclaimable';
  }

  @override
  String get trashTabPhotos => 'Photos';

  @override
  String get trashTabContacts => 'Contacts';

  @override
  String get trashEmpty => 'Trash is empty';

  @override
  String trashPurgesIn(int days) {
    return 'Purges in $days days';
  }

  @override
  String get trashRestore => 'Restore';

  @override
  String get trashDeleteForever => 'Delete forever';

  @override
  String get trashSelectMode => 'Select items';

  @override
  String get streakTitle => 'Your streak';

  @override
  String streakCurrent(int days) {
    return '$days day streak';
  }

  @override
  String get streakLastWeeks => 'Last 5 weeks';

  @override
  String get streakLegendLess => 'Less';

  @override
  String get streakLegendMore => 'More';

  @override
  String get settingsTitle => 'Settings';

  @override
  String get settingsPremiumTitle => 'Go Premium';

  @override
  String get settingsPremiumSub => 'Unlock unlimited batches and cloud backup.';

  @override
  String get settingsPreferences => 'Preferences';

  @override
  String get settingsAppearance => 'Appearance';

  @override
  String get settingsAppearanceValue => 'Light';

  @override
  String get settingsHaptic => 'Haptic feedback';

  @override
  String get settingsNotifications => 'Notifications';

  @override
  String get settingsAccount => 'Account';

  @override
  String get settingsSignIn => 'Sign in';

  @override
  String get settingsDeleteAccount => 'Delete account';

  @override
  String get settingsRate => 'Rate Decluttr';

  @override
  String get settingsShare => 'Share Decluttr';

  @override
  String get signInTitle => 'Sign in';

  @override
  String get signInEmail => 'Email';

  @override
  String get signInPassword => 'Password';

  @override
  String get signInButton => 'Sign in';

  @override
  String get errorPhotosTitle => 'Unable to load photos';

  @override
  String get errorPhotosMessage =>
      'We couldn\'t load your photo library. Check your connection and try again.';

  @override
  String get errorContactsTitle => 'Unable to access contacts';

  @override
  String get errorContactsMessage =>
      'Decluttr doesn\'t have permission to read your contacts. Enable access in Settings to continue.';

  @override
  String get errorGenericTitle => 'Something went wrong';

  @override
  String get errorGenericMessage =>
      'An unexpected error occurred. Please try again in a moment.';

  @override
  String get errorPermissionTitle => 'Permission changed';

  @override
  String get errorPermissionMessage =>
      'Photo access was changed in Settings. Reconnect to keep decluttering.';

  @override
  String get errorTryAgain => 'Try again';

  @override
  String get errorGoHome => 'Go home';

  @override
  String get errorOpenSettings => 'Open Settings';

  @override
  String get errorNotNow => 'Not now';

  @override
  String get errorReconnect => 'Reconnect';

  @override
  String get commonBack => 'Back';
}
