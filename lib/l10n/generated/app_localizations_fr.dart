// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for French (`fr`).
class AppLocalizationsFr extends AppLocalizations {
  AppLocalizationsFr([String locale = 'fr']) : super(locale);

  @override
  String get appTitle => 'Decluttr';

  @override
  String get splashTagline => 'Gardez l\'essentiel.\nSupprimez le reste.';

  @override
  String get welcomeHeadlineSuffix => 'votre vie numérique';

  @override
  String get welcomeSubtitle =>
      'Glissez pour garder l\'essentiel et supprimer le superflu.';

  @override
  String get welcomeGetStarted => 'Commencer';

  @override
  String get welcomeReplay => 'Revoir le splash';

  @override
  String get welcomeDoItLater => 'Plus tard';

  @override
  String get walkthroughTitle => 'Comment ça marche';

  @override
  String get walkthroughSubtitle =>
      'Glissez pour trier, touchez pour voir en détail.';

  @override
  String get walkthroughKeepHint => 'Glissez à droite pour garder';

  @override
  String get walkthroughDeleteHint => 'Glissez à gauche pour supprimer';

  @override
  String get walkthroughTapHint => 'Touchez pour voir les détails';

  @override
  String get walkthroughContinue => 'Commencer';

  @override
  String get walkthroughSkip => 'Plus tard';

  @override
  String get permContactsTitle => 'Autoriser l\'accès aux Contacts';

  @override
  String get permContactsBullet1 => 'Trouvez les doublons et entrées obsolètes';

  @override
  String get permContactsBullet2 => 'Fusionnez les contacts en toute sécurité';

  @override
  String get permContactsBullet3 =>
      'Rien n\'est téléversé sans votre consentement';

  @override
  String get permPhotosTitle => 'Autoriser l\'accès\nà vos Photos';

  @override
  String get permPhotosSubtitle =>
      'Nous avons besoin d\'un accès pour trouver et afficher vos photos à nettoyer.';

  @override
  String get permPhotosBullet1 => 'Vos photos restent privées';

  @override
  String get permPhotosBullet2 => 'Nous ne téléversons rien';

  @override
  String get permPhotosBullet3 => 'Vous gardez le contrôle';

  @override
  String get permPhotosAllowCta => 'Autoriser l\'accès aux photos';

  @override
  String get permAllowAccess => 'Autoriser l\'accès';

  @override
  String get permNotNow => 'Pas maintenant';

  @override
  String get permMaybeLater => 'Peut-être plus tard';

  @override
  String get homeGreetingFirst => 'Bienvenue 👋';

  @override
  String get homeGreetingReturn => 'Bon retour 👋';

  @override
  String get homeHeroLine1 => 'Prêt pour un';

  @override
  String get homeHeroLine2Lead => 'petit ';

  @override
  String get homeHeroAccent => 'nettoyage ?';

  @override
  String get homeHeroSub => 'Triez photos et contacts en quelques minutes.';

  @override
  String get homeStreakSubtitle => 'Gardez votre élan !';

  @override
  String homeStreakTitle(int days) {
    final intl.NumberFormat daysNumberFormat = intl.NumberFormat.decimalPattern(
      localeName,
    );
    final String daysString = daysNumberFormat.format(days);

    return 'Série de $daysString jours';
  }

  @override
  String get homeContactsTitle => 'Contacts';

  @override
  String get homePhotosTitle => 'Photos et vidéos';

  @override
  String get homeTapToStart => 'Appuyez pour commencer';

  @override
  String homeContactsWaiting(int count) {
    final intl.NumberFormat countNumberFormat =
        intl.NumberFormat.decimalPattern(localeName);
    final String countString = countNumberFormat.format(count);

    return '$countString en attente';
  }

  @override
  String homePhotosWaiting(int count) {
    final intl.NumberFormat countNumberFormat =
        intl.NumberFormat.decimalPattern(localeName);
    final String countString = countNumberFormat.format(count);

    return '$countString en attente';
  }

  @override
  String get homeProgressTitle => 'Votre progression';

  @override
  String get homeProgressViewAll => 'Voir toutes les stats ›';

  @override
  String get homeProgressItemsRemaining => 'éléments restants';

  @override
  String get dockHome => 'Accueil';

  @override
  String get dockTrash => 'Corbeille';

  @override
  String get dockSettings => 'Réglages';

  @override
  String get batchPhotosTitle => 'Photos';

  @override
  String get batchPhotosSubtitle => 'Choisissez ce que vous voulez nettoyer.';

  @override
  String get batchChooseSection => 'Choisir un lot';

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
  String get batchDuplicatesTitle => 'Doublons';

  @override
  String batchDuplicatesPhotosHint(int count) {
    final intl.NumberFormat countNumberFormat =
        intl.NumberFormat.decimalPattern(localeName);
    final String countString = countNumberFormat.format(count);

    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$countString photos similaires',
      one: '1 photo similaire',
    );
    return '$_temp0';
  }

  @override
  String get batchContactsTitle => 'Contacts';

  @override
  String get batchEmptyTitle => 'Tout est à jour ✓';

  @override
  String get batchEmptyPhotosSub =>
      'Vous avez terminé tous les lots de photos.';

  @override
  String get batchEmptyContactsSub =>
      'Vous avez terminé tous les groupes de contacts.';

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
  String get swipeTutorialTitle => 'Voici comment ça marche';

  @override
  String get swipeTutorial =>
      'Glissez à gauche pour supprimer, à droite pour garder';

  @override
  String get swipeDismissTutorial => 'Compris';

  @override
  String get swipeKeep => 'Garder';

  @override
  String get swipeDelete => 'Supprimer';

  @override
  String get swipeUndo => 'Annuler';

  @override
  String get swipePlayVideo => 'Lire la vidéo';

  @override
  String get swipeVideoUnavailable => 'Impossible de lire cette vidéo';

  @override
  String get sessionSummaryTitle => 'Terminé !';

  @override
  String get sessionSummarySubPhotos =>
      'Vous avez passé en revue toutes les photos de ce lot. Beau nettoyage.';

  @override
  String get sessionSummarySubContacts =>
      'Vous avez passé en revue tous les contacts de ce lot. Beau nettoyage.';

  @override
  String get sessionSummaryKeptLabel => 'Gardés';

  @override
  String get sessionSummaryDeletedLabel => 'Supprimés';

  @override
  String sessionSummaryDeletedSize(String size) {
    return '$size supprimés';
  }

  @override
  String sessionSummaryKept(int count) {
    final intl.NumberFormat countNumberFormat =
        intl.NumberFormat.decimalPattern(localeName);
    final String countString = countNumberFormat.format(count);

    return '$countString gardés';
  }

  @override
  String sessionSummaryDeleted(int count) {
    final intl.NumberFormat countNumberFormat =
        intl.NumberFormat.decimalPattern(localeName);
    final String countString = countNumberFormat.format(count);

    return '$countString supprimés';
  }

  @override
  String get sessionSummaryBack => 'Retour aux lots';

  @override
  String get duplicatesTitle => 'Contacts en double';

  @override
  String duplicatesProgress(int current, int total) {
    final intl.NumberFormat currentNumberFormat =
        intl.NumberFormat.decimalPattern(localeName);
    final String currentString = currentNumberFormat.format(current);
    final intl.NumberFormat totalNumberFormat =
        intl.NumberFormat.decimalPattern(localeName);
    final String totalString = totalNumberFormat.format(total);

    return '$currentString sur $totalString';
  }

  @override
  String get duplicatesAfterMerge => 'Après fusion';

  @override
  String get duplicatesMerge => 'Fusionner';

  @override
  String get duplicatesKeepBoth => 'Garder les deux';

  @override
  String get duplicatesDeleteOne => 'Supprimer un';

  @override
  String get duplicatesReasonSamePhone => 'Même numéro';

  @override
  String get duplicatesReasonSameEmail => 'Même e-mail';

  @override
  String get duplicatesReasonSimilarName => 'Nom similaire';

  @override
  String get trashTitle => 'Corbeille';

  @override
  String get trashSubtitle => 'Vérifiez avant de supprimer définitivement.';

  @override
  String trashReclaimable(String size) {
    return '$size récupérables';
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
  String get trashEmpty => 'La corbeille est vide';

  @override
  String get trashEmptyPhotosSub =>
      'Les éléments balayés pendant le nettoyage arrivent ici jusqu\'à suppression définitive.';

  @override
  String get trashEmptyContactsTitle => 'Aucun contact dans la corbeille';

  @override
  String get trashEmptyContactsSub =>
      'Les contacts supprimés pendant le nettoyage apparaîtront ici.';

  @override
  String get trashSelect => 'Sélectionner';

  @override
  String get trashSelectAll => 'Tout sélectionner';

  @override
  String get trashDeselectAll => 'Tout désélectionner';

  @override
  String get trashCancel => 'Annuler';

  @override
  String trashItemsCount(int count) {
    final intl.NumberFormat countNumberFormat =
        intl.NumberFormat.decimalPattern(localeName);
    final String countString = countNumberFormat.format(count);

    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$countString éléments',
      one: '1 élément',
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
      other: '$countString sélectionnés',
      one: '1 sélectionné',
    );
    return '$_temp0';
  }

  @override
  String get trashDeleteSelected => 'Supprimer la sélection';

  @override
  String trashPurgesIn(int days) {
    final intl.NumberFormat daysNumberFormat = intl.NumberFormat.decimalPattern(
      localeName,
    );
    final String daysString = daysNumberFormat.format(days);

    return 'Suppression dans $daysString jours';
  }

  @override
  String get trashRestore => 'Restaurer';

  @override
  String get trashDeleteForever => 'Supprimer définitivement';

  @override
  String trashDockBadgeA11y(int count) {
    final intl.NumberFormat countNumberFormat =
        intl.NumberFormat.decimalPattern(localeName);
    final String countString = countNumberFormat.format(count);

    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$countString éléments dans la corbeille',
      one: '1 élément dans la corbeille',
      zero: 'Aucun élément dans la corbeille',
    );
    return '$_temp0';
  }

  @override
  String get trashSelectMode => 'Sélectionner';

  @override
  String get insightsTitle => 'Statistiques';

  @override
  String get insightsStorageFreed => 'Espace libéré';

  @override
  String get insightsThisWeek => 'Cette semaine';

  @override
  String insightsWeekCleaned(int count) {
    final intl.NumberFormat countNumberFormat =
        intl.NumberFormat.decimalPattern(localeName);
    final String countString = countNumberFormat.format(count);

    return '+$countString nettoyés';
  }

  @override
  String get insightsCleanedByType => 'Nettoyé par type';

  @override
  String get insightsPhotosVideos => 'Photos et vidéos';

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

    return 'Série de $currentString jours · meilleur $longestString';
  }

  @override
  String get insightsStreakSubtitle => 'Voir l\'historique de vos séries';

  @override
  String get streakTitle => 'Votre série';

  @override
  String streakCurrent(int days) {
    final intl.NumberFormat daysNumberFormat = intl.NumberFormat.decimalPattern(
      localeName,
    );
    final String daysString = daysNumberFormat.format(days);

    return 'Série de $daysString jours';
  }

  @override
  String get streakDayStreakLabel => 'Jours de série';

  @override
  String get streakKeepGoing => 'Continuez !';

  @override
  String get streakWeekdayMon => 'L';

  @override
  String get streakWeekdayTue => 'M';

  @override
  String get streakWeekdayWed => 'M';

  @override
  String get streakWeekdayThu => 'J';

  @override
  String get streakWeekdayFri => 'V';

  @override
  String get streakWeekdaySat => 'S';

  @override
  String get streakWeekdaySun => 'D';

  @override
  String get streakLastWeeks => '5 dernières semaines';

  @override
  String get streakWeekRangeHint => 'Lun → Dim';

  @override
  String get streakLegendLess => 'Moins';

  @override
  String get streakLegendMore => 'Plus';

  @override
  String get streakLongest => 'Plus longue série';

  @override
  String get streakItemsCleaned => 'Éléments nettoyés';

  @override
  String get streakKeepCleaning => 'Continuer à nettoyer';

  @override
  String get settingsTitle => 'Réglages';

  @override
  String get settingsPremiumTitle => 'Passer Premium';

  @override
  String get settingsPremiumSub => 'Nettoyage illimité et bien plus.';

  @override
  String get settingsSignInSub =>
      'Synchronisez vos nettoyages sur vos appareils';

  @override
  String get settingsPreferences => 'Préférences';

  @override
  String get settingsAppearance => 'Apparence';

  @override
  String get settingsAppearanceValue => 'Clair';

  @override
  String get settingsHaptic => 'Retour haptique';

  @override
  String get settingsNotifications => 'Notifications';

  @override
  String get settingsPrivacyPermissions => 'Confidentialité et autorisations';

  @override
  String get settingsPhotosAccess => 'Accès Photos';

  @override
  String get settingsContactsAccess => 'Accès Contacts';

  @override
  String get settingsAccessFull => 'Accès complet';

  @override
  String get settingsAccessDenied => 'Non autorisé';

  @override
  String get settingsMore => 'Plus';

  @override
  String get settingsSignIn => 'Se connecter';

  @override
  String get settingsRate => 'Noter Decluttr';

  @override
  String get settingsShare => 'Partager Decluttr';

  @override
  String get settingsShareMessage =>
      'Je range avec Decluttr — glissez pour nettoyer contacts et photos.';

  @override
  String get settingsDeleteAccount => 'Supprimer les données du compte';

  @override
  String get settingsDeleteAccountConfirmTitle =>
      'Supprimer les données locales ?';

  @override
  String get settingsDeleteAccountConfirmBody =>
      'Cela vous déconnecte et efface les données Decluttr sur cet appareil. Les photos et contacts du téléphone ne sont pas modifiés.';

  @override
  String get settingsDeleteAccountConfirmAction => 'Supprimer';

  @override
  String get settingsCancel => 'Annuler';

  @override
  String get settingsPremiumComingSoon => 'Premium arrive bientôt.';

  @override
  String get signInTitle => 'Se connecter';

  @override
  String get signInEmail => 'E-mail';

  @override
  String get signInPassword => 'Mot de passe';

  @override
  String get signInButton => 'Se connecter';

  @override
  String get errorPhotosTitle => 'Impossible de charger les photos';

  @override
  String get errorPhotosMessage =>
      'Nous n\'avons pas pu charger votre photothèque. Vérifiez votre connexion.';

  @override
  String get errorContactsTitle => 'Impossible d\'accéder aux contacts';

  @override
  String get errorContactsMessage =>
      'Decluttr n\'a pas la permission de lire vos contacts. Activez l\'accès dans Réglages.';

  @override
  String get errorGenericTitle => 'Une erreur s\'est produite';

  @override
  String get errorGenericMessage =>
      'Une erreur inattendue s\'est produite. Réessayez dans un instant.';

  @override
  String get errorPermissionTitle => 'Permission modifiée';

  @override
  String get errorPermissionMessage =>
      'L\'accès aux photos a changé dans Réglages. Reconnectez pour continuer.';

  @override
  String get errorTryAgain => 'Réessayer';

  @override
  String get errorGoHome => 'Accueil';

  @override
  String get errorOpenSettings => 'Ouvrir Réglages';

  @override
  String get errorNotNow => 'Pas maintenant';

  @override
  String get errorReconnect => 'Reconnecter';

  @override
  String get commonBack => 'Retour';
}
