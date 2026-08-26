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
  String homeStreakTitle(int days) {
    final intl.NumberFormat daysNumberFormat = intl.NumberFormat.decimalPattern(
      localeName,
    );
    final String daysString = daysNumberFormat.format(days);

    return '$daysString Day Streak';
  }

  @override
  String get homeContactsTitle => 'Contacts';

  @override
  String get homePhotosTitle => 'Photos & Videos';

  @override
  String get homeTapToStart => 'Tap to get started';

  @override
  String homeContactsWaiting(int count) {
    final intl.NumberFormat countNumberFormat =
        intl.NumberFormat.decimalPattern(localeName);
    final String countString = countNumberFormat.format(count);

    return '$countString waiting for you';
  }

  @override
  String homePhotosWaiting(int count) {
    final intl.NumberFormat countNumberFormat =
        intl.NumberFormat.decimalPattern(localeName);
    final String countString = countNumberFormat.format(count);

    return '$countString waiting for you';
  }

  @override
  String get homeProgressTitle => 'Your progress';

  @override
  String get homeProgressViewAll => 'View all stats ›';

  @override
  String get homeProgressItemsRemaining => 'items remaining';

  @override
  String get dockHome => 'Home';

  @override
  String get dockTrash => 'Trash';

  @override
  String get dockSettings => 'Settings';

  @override
  String get batchPhotosTitle => 'Photos';

  @override
  String get batchPhotosSubtitle => 'Select what you want to clean.';

  @override
  String get batchChooseSection => 'Choose a batch';

  @override
  String batchPhotoCount(int count) {
    final intl.NumberFormat countNumberFormat =
        intl.NumberFormat.decimalPattern(localeName);
    final String countString = countNumberFormat.format(count);

    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$countString photos',
      one: '1 photo',
    );
    return '$_temp0';
  }

  @override
  String get batchDuplicatesTitle => 'Duplicates';

  @override
  String batchDuplicatesPhotosHint(int count) {
    final intl.NumberFormat countNumberFormat =
        intl.NumberFormat.decimalPattern(localeName);
    final String countString = countNumberFormat.format(count);

    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$countString photos look similar',
      one: '1 photo looks similar',
    );
    return '$_temp0';
  }

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
    final intl.NumberFormat currentNumberFormat =
        intl.NumberFormat.decimalPattern(localeName);
    final String currentString = currentNumberFormat.format(current);
    final intl.NumberFormat totalNumberFormat =
        intl.NumberFormat.decimalPattern(localeName);
    final String totalString = totalNumberFormat.format(total);

    return '$currentString/$totalString';
  }

  @override
  String get swipeTutorialTitle => 'Here\'s how it works';

  @override
  String get swipeTutorial => 'Swipe left to delete, right to keep';

  @override
  String get swipeDismissTutorial => 'Got it';

  @override
  String get swipeKeep => 'Keep';

  @override
  String get swipeDelete => 'Delete';

  @override
  String get swipeUndo => 'Undo';

  @override
  String get swipePlayVideo => 'Play video';

  @override
  String get swipeVideoUnavailable => 'Couldn\'t play this video';

  @override
  String get sessionSummaryTitle => 'All done!';

  @override
  String get sessionSummarySubPhotos =>
      'You reviewed every photo in this batch. Nice cleanup.';

  @override
  String get sessionSummarySubContacts =>
      'You reviewed every contact in this batch. Nice cleanup.';

  @override
  String get sessionSummaryKeptLabel => 'Kept';

  @override
  String get sessionSummaryDeletedLabel => 'Deleted';

  @override
  String sessionSummaryDeletedSize(String size) {
    return '$size deleted';
  }

  @override
  String sessionSummaryKept(int count) {
    final intl.NumberFormat countNumberFormat =
        intl.NumberFormat.decimalPattern(localeName);
    final String countString = countNumberFormat.format(count);

    return '$countString kept';
  }

  @override
  String sessionSummaryDeleted(int count) {
    final intl.NumberFormat countNumberFormat =
        intl.NumberFormat.decimalPattern(localeName);
    final String countString = countNumberFormat.format(count);

    return '$countString deleted';
  }

  @override
  String get sessionSummaryBack => 'Back to batches';

  @override
  String get duplicatesTitle => 'Duplicate contacts';

  @override
  String duplicatesProgress(int current, int total) {
    final intl.NumberFormat currentNumberFormat =
        intl.NumberFormat.decimalPattern(localeName);
    final String currentString = currentNumberFormat.format(current);
    final intl.NumberFormat totalNumberFormat =
        intl.NumberFormat.decimalPattern(localeName);
    final String totalString = totalNumberFormat.format(total);

    return '$currentString of $totalString';
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
  String get trashSubtitle => 'Review before deleting forever.';

  @override
  String trashReclaimable(String size) {
    return '$size reclaimable';
  }

  @override
  String get trashTabPhotos => 'Photos';

  @override
  String get trashTabContacts => 'Contacts';

  @override
  String trashTabPhotosCount(int count) {
    final intl.NumberFormat countNumberFormat =
        intl.NumberFormat.decimalPattern(localeName);
    final String countString = countNumberFormat.format(count);

    return 'Photos ($countString)';
  }

  @override
  String trashTabContactsCount(int count) {
    final intl.NumberFormat countNumberFormat =
        intl.NumberFormat.decimalPattern(localeName);
    final String countString = countNumberFormat.format(count);

    return 'Contacts ($countString)';
  }

  @override
  String get trashEmpty => 'Trash is empty';

  @override
  String get trashEmptyPhotosSub =>
      'Items you swipe away during cleanup land here until you delete them forever.';

  @override
  String get trashEmptyContactsTitle => 'No contacts in trash';

  @override
  String get trashEmptyContactsSub =>
      'Contacts you remove during cleanup will appear here.';

  @override
  String get trashSelect => 'Select';

  @override
  String get trashSelectAll => 'Select all';

  @override
  String get trashDeselectAll => 'Deselect all';

  @override
  String get trashCancel => 'Cancel';

  @override
  String trashItemsCount(int count) {
    final intl.NumberFormat countNumberFormat =
        intl.NumberFormat.decimalPattern(localeName);
    final String countString = countNumberFormat.format(count);

    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$countString items',
      one: '1 item',
    );
    return '$_temp0';
  }

  @override
  String trashSelectedCount(int count) {
    final intl.NumberFormat countNumberFormat =
        intl.NumberFormat.decimalPattern(localeName);
    final String countString = countNumberFormat.format(count);

    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$countString selected',
      one: '1 selected',
    );
    return '$_temp0';
  }

  @override
  String get trashDeleteSelected => 'Delete selected';

  @override
  String trashPurgesIn(int days) {
    final intl.NumberFormat daysNumberFormat = intl.NumberFormat.decimalPattern(
      localeName,
    );
    final String daysString = daysNumberFormat.format(days);

    return 'Purges in $daysString days';
  }

  @override
  String get trashRestore => 'Restore';

  @override
  String get trashDeleteForever => 'Delete forever';

  @override
  String trashDockBadgeA11y(int count) {
    final intl.NumberFormat countNumberFormat =
        intl.NumberFormat.decimalPattern(localeName);
    final String countString = countNumberFormat.format(count);

    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$countString items in trash',
      one: '1 item in trash',
      zero: 'No items in trash',
    );
    return '$_temp0';
  }

  @override
  String get trashSelectMode => 'Select items';

  @override
  String get insightsTitle => 'Insights';

  @override
  String get insightsStorageFreed => 'Storage freed';

  @override
  String get insightsThisWeek => 'This week';

  @override
  String insightsWeekCleaned(int count) {
    final intl.NumberFormat countNumberFormat =
        intl.NumberFormat.decimalPattern(localeName);
    final String countString = countNumberFormat.format(count);

    return '+$countString cleaned';
  }

  @override
  String get insightsCleanedByType => 'Cleaned by type';

  @override
  String get insightsPhotosVideos => 'Photos & videos';

  @override
  String get insightsContacts => 'Contacts';

  @override
  String insightsStreakSummary(int current, int longest) {
    final intl.NumberFormat currentNumberFormat =
        intl.NumberFormat.decimalPattern(localeName);
    final String currentString = currentNumberFormat.format(current);
    final intl.NumberFormat longestNumberFormat =
        intl.NumberFormat.decimalPattern(localeName);
    final String longestString = longestNumberFormat.format(longest);

    return '$currentString day streak · $longestString best';
  }

  @override
  String get insightsStreakSubtitle => 'See your full streak history';

  @override
  String get streakTitle => 'Your streak';

  @override
  String streakCurrent(int days) {
    final intl.NumberFormat daysNumberFormat = intl.NumberFormat.decimalPattern(
      localeName,
    );
    final String daysString = daysNumberFormat.format(days);

    return '$daysString day streak';
  }

  @override
  String get streakDayStreakLabel => 'Day Streak';

  @override
  String get streakKeepGoing => 'Keep it going!';

  @override
  String get streakWeekdayMon => 'M';

  @override
  String get streakWeekdayTue => 'T';

  @override
  String get streakWeekdayWed => 'W';

  @override
  String get streakWeekdayThu => 'T';

  @override
  String get streakWeekdayFri => 'F';

  @override
  String get streakWeekdaySat => 'S';

  @override
  String get streakWeekdaySun => 'S';

  @override
  String get streakLastWeeks => 'Last 5 weeks';

  @override
  String get streakWeekRangeHint => 'Mon → Sun';

  @override
  String get streakLegendLess => 'Less';

  @override
  String get streakLegendMore => 'More';

  @override
  String get streakLongest => 'Longest streak';

  @override
  String get streakItemsCleaned => 'Items cleaned';

  @override
  String get streakKeepCleaning => 'Keep cleaning';

  @override
  String get settingsTitle => 'Settings';

  @override
  String get settingsPremiumTitle => 'Go premium';

  @override
  String get settingsPremiumSub => 'Unlock unlimited cleaning and more.';

  @override
  String get settingsSignInSub => 'Sync your cleanups across devices';

  @override
  String get settingsPreferences => 'Preferences';

  @override
  String get settingsAppearance => 'Appearance';

  @override
  String get settingsAppearanceValue => 'Light';

  @override
  String get settingsHaptic => 'Haptic Feedback';

  @override
  String get settingsNotifications => 'Notifications';

  @override
  String get settingsPrivacyPermissions => 'Privacy & Permissions';

  @override
  String get settingsPhotosAccess => 'Photos Access';

  @override
  String get settingsContactsAccess => 'Contacts Access';

  @override
  String get settingsAccessFull => 'Full Access';

  @override
  String get settingsAccessDenied => 'Not allowed';

  @override
  String get settingsMore => 'More';

  @override
  String get settingsSignIn => 'Sign in';

  @override
  String get settingsRate => 'Rate Decluttr';

  @override
  String get settingsShare => 'Share Decluttr';

  @override
  String get settingsShareMessage =>
      'I\'m decluttering with Decluttr — swipe to clean contacts and photos.';

  @override
  String get settingsDeleteAccount => 'Delete account data';

  @override
  String get settingsDeleteAccountConfirmTitle => 'Delete local account data?';

  @override
  String get settingsDeleteAccountConfirmBody =>
      'This signs you out and clears Decluttr data on this device. Photos and contacts on your phone are not changed.';

  @override
  String get settingsDeleteAccountConfirmAction => 'Delete';

  @override
  String get settingsCancel => 'Cancel';

  @override
  String get settingsPremiumComingSoon => 'Premium is coming soon.';

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
