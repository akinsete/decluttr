import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_es.dart';
import 'app_localizations_fr.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'generated/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('es'),
    Locale('fr'),
  ];

  /// No description provided for @appTitle.
  ///
  /// In en, this message translates to:
  /// **'Decluttr'**
  String get appTitle;

  /// No description provided for @splashTagline.
  ///
  /// In en, this message translates to:
  /// **'Keep what matters.\nDelete the rest.'**
  String get splashTagline;

  /// No description provided for @welcomeHeadlineSuffix.
  ///
  /// In en, this message translates to:
  /// **'your digital life'**
  String get welcomeHeadlineSuffix;

  /// No description provided for @welcomeSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Swipe to keep the good and get rid of what you don\'t need.'**
  String get welcomeSubtitle;

  /// No description provided for @welcomeGetStarted.
  ///
  /// In en, this message translates to:
  /// **'Get started'**
  String get welcomeGetStarted;

  /// No description provided for @welcomeReplay.
  ///
  /// In en, this message translates to:
  /// **'Replay splash'**
  String get welcomeReplay;

  /// No description provided for @welcomeDoItLater.
  ///
  /// In en, this message translates to:
  /// **'I\'ll do this later'**
  String get welcomeDoItLater;

  /// No description provided for @walkthroughTitle.
  ///
  /// In en, this message translates to:
  /// **'How it works'**
  String get walkthroughTitle;

  /// No description provided for @walkthroughSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Swipe to sort, tap for a closer look.'**
  String get walkthroughSubtitle;

  /// No description provided for @walkthroughKeepHint.
  ///
  /// In en, this message translates to:
  /// **'Swipe right to keep'**
  String get walkthroughKeepHint;

  /// No description provided for @walkthroughDeleteHint.
  ///
  /// In en, this message translates to:
  /// **'Swipe left to delete'**
  String get walkthroughDeleteHint;

  /// No description provided for @walkthroughTapHint.
  ///
  /// In en, this message translates to:
  /// **'Tap to view details'**
  String get walkthroughTapHint;

  /// No description provided for @walkthroughContinue.
  ///
  /// In en, this message translates to:
  /// **'Get started'**
  String get walkthroughContinue;

  /// No description provided for @walkthroughSkip.
  ///
  /// In en, this message translates to:
  /// **'Do it later'**
  String get walkthroughSkip;

  /// No description provided for @permContactsTitle.
  ///
  /// In en, this message translates to:
  /// **'Allow access to your Contacts'**
  String get permContactsTitle;

  /// No description provided for @permContactsBullet1.
  ///
  /// In en, this message translates to:
  /// **'Find duplicates and outdated entries'**
  String get permContactsBullet1;

  /// No description provided for @permContactsBullet2.
  ///
  /// In en, this message translates to:
  /// **'Merge contacts safely on your device'**
  String get permContactsBullet2;

  /// No description provided for @permContactsBullet3.
  ///
  /// In en, this message translates to:
  /// **'Nothing is uploaded without your consent'**
  String get permContactsBullet3;

  /// No description provided for @permPhotosTitle.
  ///
  /// In en, this message translates to:
  /// **'Allow access to\nyour Photos'**
  String get permPhotosTitle;

  /// No description provided for @permPhotosSubtitle.
  ///
  /// In en, this message translates to:
  /// **'We need access to find and show your photos for cleanup.'**
  String get permPhotosSubtitle;

  /// No description provided for @permPhotosBullet1.
  ///
  /// In en, this message translates to:
  /// **'Your photos stay private'**
  String get permPhotosBullet1;

  /// No description provided for @permPhotosBullet2.
  ///
  /// In en, this message translates to:
  /// **'We never upload anything'**
  String get permPhotosBullet2;

  /// No description provided for @permPhotosBullet3.
  ///
  /// In en, this message translates to:
  /// **'You\'re in control'**
  String get permPhotosBullet3;

  /// No description provided for @permPhotosAllowCta.
  ///
  /// In en, this message translates to:
  /// **'Allow photos access'**
  String get permPhotosAllowCta;

  /// No description provided for @permAllowAccess.
  ///
  /// In en, this message translates to:
  /// **'Allow access'**
  String get permAllowAccess;

  /// No description provided for @permNotNow.
  ///
  /// In en, this message translates to:
  /// **'Not now'**
  String get permNotNow;

  /// No description provided for @permMaybeLater.
  ///
  /// In en, this message translates to:
  /// **'Maybe later'**
  String get permMaybeLater;

  /// No description provided for @homeGreetingFirst.
  ///
  /// In en, this message translates to:
  /// **'Welcome 👋'**
  String get homeGreetingFirst;

  /// No description provided for @homeGreetingReturn.
  ///
  /// In en, this message translates to:
  /// **'Welcome back 👋'**
  String get homeGreetingReturn;

  /// No description provided for @homeHeroLine1.
  ///
  /// In en, this message translates to:
  /// **'Ready for a'**
  String get homeHeroLine1;

  /// No description provided for @homeHeroLine2Lead.
  ///
  /// In en, this message translates to:
  /// **'quick '**
  String get homeHeroLine2Lead;

  /// No description provided for @homeHeroAccent.
  ///
  /// In en, this message translates to:
  /// **'cleanup?'**
  String get homeHeroAccent;

  /// No description provided for @homeHeroSub.
  ///
  /// In en, this message translates to:
  /// **'Swipe through photos and contacts in minutes.'**
  String get homeHeroSub;

  /// No description provided for @homeStreakSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Keep your momentum going!'**
  String get homeStreakSubtitle;

  /// No description provided for @homeStreakTitle.
  ///
  /// In en, this message translates to:
  /// **'{days} Day Streak'**
  String homeStreakTitle(int days);

  /// No description provided for @homeContactsTitle.
  ///
  /// In en, this message translates to:
  /// **'Contacts'**
  String get homeContactsTitle;

  /// No description provided for @homePhotosTitle.
  ///
  /// In en, this message translates to:
  /// **'Photos & Videos'**
  String get homePhotosTitle;

  /// No description provided for @homeTapToStart.
  ///
  /// In en, this message translates to:
  /// **'Tap to get started'**
  String get homeTapToStart;

  /// No description provided for @homeContactsWaiting.
  ///
  /// In en, this message translates to:
  /// **'{count} waiting for you'**
  String homeContactsWaiting(int count);

  /// No description provided for @homePhotosWaiting.
  ///
  /// In en, this message translates to:
  /// **'{count} waiting for you'**
  String homePhotosWaiting(int count);

  /// No description provided for @homeProgressTitle.
  ///
  /// In en, this message translates to:
  /// **'Your progress'**
  String get homeProgressTitle;

  /// No description provided for @homeProgressViewAll.
  ///
  /// In en, this message translates to:
  /// **'View all stats ›'**
  String get homeProgressViewAll;

  /// No description provided for @homeProgressItemsRemaining.
  ///
  /// In en, this message translates to:
  /// **'items remaining'**
  String get homeProgressItemsRemaining;

  /// No description provided for @dockHome.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get dockHome;

  /// No description provided for @dockTrash.
  ///
  /// In en, this message translates to:
  /// **'Trash'**
  String get dockTrash;

  /// No description provided for @dockSettings.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get dockSettings;

  /// No description provided for @batchPhotosTitle.
  ///
  /// In en, this message translates to:
  /// **'Photos'**
  String get batchPhotosTitle;

  /// No description provided for @batchPhotosSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Select what you want to clean.'**
  String get batchPhotosSubtitle;

  /// No description provided for @batchChooseSection.
  ///
  /// In en, this message translates to:
  /// **'Choose a batch'**
  String get batchChooseSection;

  /// No description provided for @batchPhotoCount.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =1{1 photo} other{{count} photos}}'**
  String batchPhotoCount(int count);

  /// No description provided for @batchDuplicatesTitle.
  ///
  /// In en, this message translates to:
  /// **'Duplicates'**
  String get batchDuplicatesTitle;

  /// No description provided for @batchDuplicatesPhotosHint.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =1{1 photo looks similar} other{{count} photos look similar}}'**
  String batchDuplicatesPhotosHint(int count);

  /// No description provided for @batchContactsTitle.
  ///
  /// In en, this message translates to:
  /// **'Contacts'**
  String get batchContactsTitle;

  /// No description provided for @batchEmptyTitle.
  ///
  /// In en, this message translates to:
  /// **'All caught up ✓'**
  String get batchEmptyTitle;

  /// No description provided for @batchEmptyPhotosSub.
  ///
  /// In en, this message translates to:
  /// **'You have cleared every photo batch for now.'**
  String get batchEmptyPhotosSub;

  /// No description provided for @batchEmptyContactsSub.
  ///
  /// In en, this message translates to:
  /// **'You have cleared every contact group for now.'**
  String get batchEmptyContactsSub;

  /// No description provided for @swipeProgress.
  ///
  /// In en, this message translates to:
  /// **'{current}/{total}'**
  String swipeProgress(int current, int total);

  /// No description provided for @swipeTutorialTitle.
  ///
  /// In en, this message translates to:
  /// **'Here\'s how it works'**
  String get swipeTutorialTitle;

  /// No description provided for @swipeTutorial.
  ///
  /// In en, this message translates to:
  /// **'Swipe left to delete, right to keep'**
  String get swipeTutorial;

  /// No description provided for @swipeDismissTutorial.
  ///
  /// In en, this message translates to:
  /// **'Got it'**
  String get swipeDismissTutorial;

  /// No description provided for @swipeKeep.
  ///
  /// In en, this message translates to:
  /// **'Keep'**
  String get swipeKeep;

  /// No description provided for @swipeDelete.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get swipeDelete;

  /// No description provided for @swipeUndo.
  ///
  /// In en, this message translates to:
  /// **'Undo'**
  String get swipeUndo;

  /// No description provided for @swipePlayVideo.
  ///
  /// In en, this message translates to:
  /// **'Play video'**
  String get swipePlayVideo;

  /// No description provided for @swipeVideoUnavailable.
  ///
  /// In en, this message translates to:
  /// **'Couldn\'t play this video'**
  String get swipeVideoUnavailable;

  /// No description provided for @sessionSummaryTitle.
  ///
  /// In en, this message translates to:
  /// **'All done!'**
  String get sessionSummaryTitle;

  /// No description provided for @sessionSummarySubPhotos.
  ///
  /// In en, this message translates to:
  /// **'You reviewed every photo in this batch. Nice cleanup.'**
  String get sessionSummarySubPhotos;

  /// No description provided for @sessionSummarySubContacts.
  ///
  /// In en, this message translates to:
  /// **'You reviewed every contact in this batch. Nice cleanup.'**
  String get sessionSummarySubContacts;

  /// No description provided for @sessionSummaryKeptLabel.
  ///
  /// In en, this message translates to:
  /// **'Kept'**
  String get sessionSummaryKeptLabel;

  /// No description provided for @sessionSummaryDeletedLabel.
  ///
  /// In en, this message translates to:
  /// **'Deleted'**
  String get sessionSummaryDeletedLabel;

  /// No description provided for @sessionSummaryDeletedSize.
  ///
  /// In en, this message translates to:
  /// **'{size} deleted'**
  String sessionSummaryDeletedSize(String size);

  /// No description provided for @sessionSummaryKept.
  ///
  /// In en, this message translates to:
  /// **'{count} kept'**
  String sessionSummaryKept(int count);

  /// No description provided for @sessionSummaryDeleted.
  ///
  /// In en, this message translates to:
  /// **'{count} deleted'**
  String sessionSummaryDeleted(int count);

  /// No description provided for @sessionSummaryBack.
  ///
  /// In en, this message translates to:
  /// **'Back to batches'**
  String get sessionSummaryBack;

  /// No description provided for @duplicatesTitle.
  ///
  /// In en, this message translates to:
  /// **'Duplicate contacts'**
  String get duplicatesTitle;

  /// No description provided for @duplicatesProgress.
  ///
  /// In en, this message translates to:
  /// **'{current} of {total}'**
  String duplicatesProgress(int current, int total);

  /// No description provided for @duplicatesAfterMerge.
  ///
  /// In en, this message translates to:
  /// **'After merge'**
  String get duplicatesAfterMerge;

  /// No description provided for @duplicatesMerge.
  ///
  /// In en, this message translates to:
  /// **'Merge'**
  String get duplicatesMerge;

  /// No description provided for @duplicatesKeepBoth.
  ///
  /// In en, this message translates to:
  /// **'Keep both'**
  String get duplicatesKeepBoth;

  /// No description provided for @duplicatesDeleteOne.
  ///
  /// In en, this message translates to:
  /// **'Delete one'**
  String get duplicatesDeleteOne;

  /// No description provided for @duplicatesReasonSamePhone.
  ///
  /// In en, this message translates to:
  /// **'Same phone number'**
  String get duplicatesReasonSamePhone;

  /// No description provided for @duplicatesReasonSameEmail.
  ///
  /// In en, this message translates to:
  /// **'Same email address'**
  String get duplicatesReasonSameEmail;

  /// No description provided for @duplicatesReasonSimilarName.
  ///
  /// In en, this message translates to:
  /// **'Similar name'**
  String get duplicatesReasonSimilarName;

  /// No description provided for @trashTitle.
  ///
  /// In en, this message translates to:
  /// **'Trash'**
  String get trashTitle;

  /// No description provided for @trashSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Review before deleting forever.'**
  String get trashSubtitle;

  /// No description provided for @trashReclaimable.
  ///
  /// In en, this message translates to:
  /// **'{size} reclaimable'**
  String trashReclaimable(String size);

  /// No description provided for @trashTabPhotos.
  ///
  /// In en, this message translates to:
  /// **'Photos'**
  String get trashTabPhotos;

  /// No description provided for @trashTabContacts.
  ///
  /// In en, this message translates to:
  /// **'Contacts'**
  String get trashTabContacts;

  /// No description provided for @trashTabPhotosCount.
  ///
  /// In en, this message translates to:
  /// **'Photos ({count})'**
  String trashTabPhotosCount(int count);

  /// No description provided for @trashTabContactsCount.
  ///
  /// In en, this message translates to:
  /// **'Contacts ({count})'**
  String trashTabContactsCount(int count);

  /// No description provided for @trashEmpty.
  ///
  /// In en, this message translates to:
  /// **'Trash is empty'**
  String get trashEmpty;

  /// No description provided for @trashEmptyPhotosSub.
  ///
  /// In en, this message translates to:
  /// **'Items you swipe away during cleanup land here until you delete them forever.'**
  String get trashEmptyPhotosSub;

  /// No description provided for @trashEmptyContactsTitle.
  ///
  /// In en, this message translates to:
  /// **'No contacts in trash'**
  String get trashEmptyContactsTitle;

  /// No description provided for @trashEmptyContactsSub.
  ///
  /// In en, this message translates to:
  /// **'Contacts you remove during cleanup will appear here.'**
  String get trashEmptyContactsSub;

  /// No description provided for @trashSelect.
  ///
  /// In en, this message translates to:
  /// **'Select'**
  String get trashSelect;

  /// No description provided for @trashSelectAll.
  ///
  /// In en, this message translates to:
  /// **'Select all'**
  String get trashSelectAll;

  /// No description provided for @trashDeselectAll.
  ///
  /// In en, this message translates to:
  /// **'Deselect all'**
  String get trashDeselectAll;

  /// No description provided for @trashCancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get trashCancel;

  /// No description provided for @trashItemsCount.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =1{1 item} other{{count} items}}'**
  String trashItemsCount(int count);

  /// No description provided for @trashSelectedCount.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =1{1 selected} other{{count} selected}}'**
  String trashSelectedCount(int count);

  /// No description provided for @trashDeleteSelected.
  ///
  /// In en, this message translates to:
  /// **'Delete selected'**
  String get trashDeleteSelected;

  /// No description provided for @trashPurgesIn.
  ///
  /// In en, this message translates to:
  /// **'Purges in {days} days'**
  String trashPurgesIn(int days);

  /// No description provided for @trashRestore.
  ///
  /// In en, this message translates to:
  /// **'Restore'**
  String get trashRestore;

  /// No description provided for @trashDeleteForever.
  ///
  /// In en, this message translates to:
  /// **'Delete forever'**
  String get trashDeleteForever;

  /// No description provided for @trashDockBadgeA11y.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =0{No items in trash} =1{1 item in trash} other{{count} items in trash}}'**
  String trashDockBadgeA11y(int count);

  /// No description provided for @trashSelectMode.
  ///
  /// In en, this message translates to:
  /// **'Select items'**
  String get trashSelectMode;

  /// No description provided for @insightsTitle.
  ///
  /// In en, this message translates to:
  /// **'Insights'**
  String get insightsTitle;

  /// No description provided for @insightsStorageFreed.
  ///
  /// In en, this message translates to:
  /// **'Storage freed'**
  String get insightsStorageFreed;

  /// No description provided for @insightsThisWeek.
  ///
  /// In en, this message translates to:
  /// **'This week'**
  String get insightsThisWeek;

  /// No description provided for @insightsWeekCleaned.
  ///
  /// In en, this message translates to:
  /// **'+{count} cleaned'**
  String insightsWeekCleaned(int count);

  /// No description provided for @insightsCleanedByType.
  ///
  /// In en, this message translates to:
  /// **'Cleaned by type'**
  String get insightsCleanedByType;

  /// No description provided for @insightsPhotosVideos.
  ///
  /// In en, this message translates to:
  /// **'Photos & videos'**
  String get insightsPhotosVideos;

  /// No description provided for @insightsContacts.
  ///
  /// In en, this message translates to:
  /// **'Contacts'**
  String get insightsContacts;

  /// No description provided for @insightsStreakSummary.
  ///
  /// In en, this message translates to:
  /// **'{current} day streak · {longest} best'**
  String insightsStreakSummary(int current, int longest);

  /// No description provided for @insightsStreakSubtitle.
  ///
  /// In en, this message translates to:
  /// **'See your full streak history'**
  String get insightsStreakSubtitle;

  /// No description provided for @streakTitle.
  ///
  /// In en, this message translates to:
  /// **'Your streak'**
  String get streakTitle;

  /// No description provided for @streakCurrent.
  ///
  /// In en, this message translates to:
  /// **'{days} day streak'**
  String streakCurrent(int days);

  /// No description provided for @streakDayStreakLabel.
  ///
  /// In en, this message translates to:
  /// **'Day Streak'**
  String get streakDayStreakLabel;

  /// No description provided for @streakKeepGoing.
  ///
  /// In en, this message translates to:
  /// **'Keep it going!'**
  String get streakKeepGoing;

  /// No description provided for @streakWeekdayMon.
  ///
  /// In en, this message translates to:
  /// **'M'**
  String get streakWeekdayMon;

  /// No description provided for @streakWeekdayTue.
  ///
  /// In en, this message translates to:
  /// **'T'**
  String get streakWeekdayTue;

  /// No description provided for @streakWeekdayWed.
  ///
  /// In en, this message translates to:
  /// **'W'**
  String get streakWeekdayWed;

  /// No description provided for @streakWeekdayThu.
  ///
  /// In en, this message translates to:
  /// **'T'**
  String get streakWeekdayThu;

  /// No description provided for @streakWeekdayFri.
  ///
  /// In en, this message translates to:
  /// **'F'**
  String get streakWeekdayFri;

  /// No description provided for @streakWeekdaySat.
  ///
  /// In en, this message translates to:
  /// **'S'**
  String get streakWeekdaySat;

  /// No description provided for @streakWeekdaySun.
  ///
  /// In en, this message translates to:
  /// **'S'**
  String get streakWeekdaySun;

  /// No description provided for @streakLastWeeks.
  ///
  /// In en, this message translates to:
  /// **'Last 5 weeks'**
  String get streakLastWeeks;

  /// No description provided for @streakWeekRangeHint.
  ///
  /// In en, this message translates to:
  /// **'Mon → Sun'**
  String get streakWeekRangeHint;

  /// No description provided for @streakLegendLess.
  ///
  /// In en, this message translates to:
  /// **'Less'**
  String get streakLegendLess;

  /// No description provided for @streakLegendMore.
  ///
  /// In en, this message translates to:
  /// **'More'**
  String get streakLegendMore;

  /// No description provided for @streakLongest.
  ///
  /// In en, this message translates to:
  /// **'Longest streak'**
  String get streakLongest;

  /// No description provided for @streakItemsCleaned.
  ///
  /// In en, this message translates to:
  /// **'Items cleaned'**
  String get streakItemsCleaned;

  /// No description provided for @streakKeepCleaning.
  ///
  /// In en, this message translates to:
  /// **'Keep cleaning'**
  String get streakKeepCleaning;

  /// No description provided for @settingsTitle.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settingsTitle;

  /// No description provided for @settingsPremiumTitle.
  ///
  /// In en, this message translates to:
  /// **'Go premium'**
  String get settingsPremiumTitle;

  /// No description provided for @settingsPremiumSub.
  ///
  /// In en, this message translates to:
  /// **'Unlock unlimited cleaning and more.'**
  String get settingsPremiumSub;

  /// No description provided for @settingsSignInSub.
  ///
  /// In en, this message translates to:
  /// **'Sync your cleanups across devices'**
  String get settingsSignInSub;

  /// No description provided for @settingsPreferences.
  ///
  /// In en, this message translates to:
  /// **'Preferences'**
  String get settingsPreferences;

  /// No description provided for @settingsAppearance.
  ///
  /// In en, this message translates to:
  /// **'Appearance'**
  String get settingsAppearance;

  /// No description provided for @settingsAppearanceValue.
  ///
  /// In en, this message translates to:
  /// **'Light'**
  String get settingsAppearanceValue;

  /// No description provided for @settingsHaptic.
  ///
  /// In en, this message translates to:
  /// **'Haptic Feedback'**
  String get settingsHaptic;

  /// No description provided for @settingsNotifications.
  ///
  /// In en, this message translates to:
  /// **'Notifications'**
  String get settingsNotifications;

  /// No description provided for @settingsPrivacyPermissions.
  ///
  /// In en, this message translates to:
  /// **'Privacy & Permissions'**
  String get settingsPrivacyPermissions;

  /// No description provided for @settingsPhotosAccess.
  ///
  /// In en, this message translates to:
  /// **'Photos Access'**
  String get settingsPhotosAccess;

  /// No description provided for @settingsContactsAccess.
  ///
  /// In en, this message translates to:
  /// **'Contacts Access'**
  String get settingsContactsAccess;

  /// No description provided for @settingsAccessFull.
  ///
  /// In en, this message translates to:
  /// **'Full Access'**
  String get settingsAccessFull;

  /// No description provided for @settingsAccessDenied.
  ///
  /// In en, this message translates to:
  /// **'Not allowed'**
  String get settingsAccessDenied;

  /// No description provided for @settingsMore.
  ///
  /// In en, this message translates to:
  /// **'More'**
  String get settingsMore;

  /// No description provided for @settingsSignIn.
  ///
  /// In en, this message translates to:
  /// **'Sign in'**
  String get settingsSignIn;

  /// No description provided for @settingsRate.
  ///
  /// In en, this message translates to:
  /// **'Rate Decluttr'**
  String get settingsRate;

  /// No description provided for @settingsShare.
  ///
  /// In en, this message translates to:
  /// **'Share Decluttr'**
  String get settingsShare;

  /// No description provided for @signInTitle.
  ///
  /// In en, this message translates to:
  /// **'Sign in'**
  String get signInTitle;

  /// No description provided for @signInEmail.
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get signInEmail;

  /// No description provided for @signInPassword.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get signInPassword;

  /// No description provided for @signInButton.
  ///
  /// In en, this message translates to:
  /// **'Sign in'**
  String get signInButton;

  /// No description provided for @errorPhotosTitle.
  ///
  /// In en, this message translates to:
  /// **'Unable to load photos'**
  String get errorPhotosTitle;

  /// No description provided for @errorPhotosMessage.
  ///
  /// In en, this message translates to:
  /// **'We couldn\'t load your photo library. Check your connection and try again.'**
  String get errorPhotosMessage;

  /// No description provided for @errorContactsTitle.
  ///
  /// In en, this message translates to:
  /// **'Unable to access contacts'**
  String get errorContactsTitle;

  /// No description provided for @errorContactsMessage.
  ///
  /// In en, this message translates to:
  /// **'Decluttr doesn\'t have permission to read your contacts. Enable access in Settings to continue.'**
  String get errorContactsMessage;

  /// No description provided for @errorGenericTitle.
  ///
  /// In en, this message translates to:
  /// **'Something went wrong'**
  String get errorGenericTitle;

  /// No description provided for @errorGenericMessage.
  ///
  /// In en, this message translates to:
  /// **'An unexpected error occurred. Please try again in a moment.'**
  String get errorGenericMessage;

  /// No description provided for @errorPermissionTitle.
  ///
  /// In en, this message translates to:
  /// **'Permission changed'**
  String get errorPermissionTitle;

  /// No description provided for @errorPermissionMessage.
  ///
  /// In en, this message translates to:
  /// **'Photo access was changed in Settings. Reconnect to keep decluttering.'**
  String get errorPermissionMessage;

  /// No description provided for @errorTryAgain.
  ///
  /// In en, this message translates to:
  /// **'Try again'**
  String get errorTryAgain;

  /// No description provided for @errorGoHome.
  ///
  /// In en, this message translates to:
  /// **'Go home'**
  String get errorGoHome;

  /// No description provided for @errorOpenSettings.
  ///
  /// In en, this message translates to:
  /// **'Open Settings'**
  String get errorOpenSettings;

  /// No description provided for @errorNotNow.
  ///
  /// In en, this message translates to:
  /// **'Not now'**
  String get errorNotNow;

  /// No description provided for @errorReconnect.
  ///
  /// In en, this message translates to:
  /// **'Reconnect'**
  String get errorReconnect;

  /// No description provided for @commonBack.
  ///
  /// In en, this message translates to:
  /// **'Back'**
  String get commonBack;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'es', 'fr'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'es':
      return AppLocalizationsEs();
    case 'fr':
      return AppLocalizationsFr();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
