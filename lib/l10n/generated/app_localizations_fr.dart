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
  String get homeContactsTitle => 'Contacts';

  @override
  String get homePhotosTitle => 'Photos et vidéos';

  @override
  String get homeTapToStart => 'Appuyez pour commencer';

  @override
  String homeContactsWaiting(int count) {
    return '$count en attente';
  }

  @override
  String homePhotosWaiting(int count) {
    return '$count en attente';
  }

  @override
  String get homeProgressTitle => 'Votre progression';

  @override
  String homeProgressStats(int kept, int deleted) {
    return '$kept gardés · $deleted supprimés';
  }

  @override
  String get dockHome => 'Accueil';

  @override
  String get dockTrash => 'Corbeille';

  @override
  String get dockSettings => 'Réglages';

  @override
  String get batchPhotosTitle => 'Photos et vidéos';

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
    return '$current / $total';
  }

  @override
  String get swipeTutorial =>
      'Glissez à droite pour garder, à gauche pour supprimer';

  @override
  String get swipeDismissTutorial => 'Compris';

  @override
  String get swipeKeep => 'Garder';

  @override
  String get swipeDelete => 'Supprimer';

  @override
  String get swipeUndo => 'Annuler';

  @override
  String get sessionSummaryTitle => 'Beau travail !';

  @override
  String get sessionSummarySub => 'Vous avez tout passé en revue dans ce lot.';

  @override
  String sessionSummaryKept(int count) {
    return '$count gardés';
  }

  @override
  String sessionSummaryDeleted(int count) {
    return '$count supprimés';
  }

  @override
  String get sessionSummaryBack => 'Retour aux lots';

  @override
  String get duplicatesTitle => 'Contacts en double';

  @override
  String duplicatesProgress(int current, int total) {
    return '$current sur $total';
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
  String trashReclaimable(String size) {
    return '$size récupérables';
  }

  @override
  String get trashTabPhotos => 'Photos';

  @override
  String get trashTabContacts => 'Contacts';

  @override
  String get trashEmpty => 'La corbeille est vide';

  @override
  String trashPurgesIn(int days) {
    return 'Suppression dans $days jours';
  }

  @override
  String get trashRestore => 'Restaurer';

  @override
  String get trashDeleteForever => 'Supprimer définitivement';

  @override
  String get trashSelectMode => 'Sélectionner';

  @override
  String get streakTitle => 'Votre série';

  @override
  String streakCurrent(int days) {
    return 'Série de $days jours';
  }

  @override
  String get streakLastWeeks => '5 dernières semaines';

  @override
  String get streakLegendLess => 'Moins';

  @override
  String get streakLegendMore => 'Plus';

  @override
  String get settingsTitle => 'Réglages';

  @override
  String get settingsPremiumTitle => 'Passer Premium';

  @override
  String get settingsPremiumSub => 'Lots illimités et sauvegarde cloud.';

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
  String get settingsAccount => 'Compte';

  @override
  String get settingsSignIn => 'Se connecter';

  @override
  String get settingsDeleteAccount => 'Supprimer le compte';

  @override
  String get settingsRate => 'Noter Decluttr';

  @override
  String get settingsShare => 'Partager Decluttr';

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
