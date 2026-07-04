// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Spanish Castilian (`es`).
class AppLocalizationsEs extends AppLocalizations {
  AppLocalizationsEs([String locale = 'es']) : super(locale);

  @override
  String get appTitle => 'Decluttr';

  @override
  String get splashTagline => 'Conserva lo importante.\nElimina el resto.';

  @override
  String get welcomeHeadlineSuffix => 'tu vida digital';

  @override
  String get welcomeSubtitle =>
      'Desliza para conservar lo bueno y eliminar lo que no necesitas.';

  @override
  String get welcomeGetStarted => 'Empezar';

  @override
  String get welcomeReplay => 'Repetir splash';

  @override
  String get welcomeDoItLater => 'Lo haré más tarde';

  @override
  String get walkthroughTitle => 'Cómo funciona';

  @override
  String get walkthroughSubtitle => 'Desliza para ordenar, toca para ver más.';

  @override
  String get walkthroughKeepHint => 'Desliza a la derecha para conservar';

  @override
  String get walkthroughDeleteHint => 'Desliza a la izquierda para eliminar';

  @override
  String get walkthroughTapHint => 'Toca para ver detalles';

  @override
  String get walkthroughContinue => 'Empezar';

  @override
  String get walkthroughSkip => 'Más tarde';

  @override
  String get permContactsTitle => 'Permitir acceso a Contactos';

  @override
  String get permContactsBullet1 => 'Encuentra duplicados y entradas antiguas';

  @override
  String get permContactsBullet2 => 'Combina contactos de forma segura';

  @override
  String get permContactsBullet3 => 'Nada se sube sin tu consentimiento';

  @override
  String get permPhotosTitle => 'Permitir acceso\na tus Fotos';

  @override
  String get permPhotosSubtitle =>
      'Necesitamos acceso para encontrar y mostrar tus fotos para limpiar.';

  @override
  String get permPhotosBullet1 => 'Tus fotos siguen siendo privadas';

  @override
  String get permPhotosBullet2 => 'Nunca subimos nada';

  @override
  String get permPhotosBullet3 => 'Tú tienes el control';

  @override
  String get permPhotosAllowCta => 'Permitir acceso a fotos';

  @override
  String get permAllowAccess => 'Permitir acceso';

  @override
  String get permNotNow => 'Ahora no';

  @override
  String get permMaybeLater => 'Quizá más tarde';

  @override
  String get homeGreetingFirst => 'Bienvenido 👋';

  @override
  String get homeGreetingReturn => 'Bienvenido de nuevo 👋';

  @override
  String get homeHeroLine1 => '¿Listo para una';

  @override
  String get homeHeroLine2Lead => 'limpieza ';

  @override
  String get homeHeroAccent => 'rápida?';

  @override
  String get homeHeroSub => 'Organiza fotos y contactos en minutos.';

  @override
  String get homeStreakSubtitle => '¡Mantén el impulso!';

  @override
  String get homeContactsTitle => 'Contactos';

  @override
  String get homePhotosTitle => 'Fotos y videos';

  @override
  String get homeTapToStart => 'Toca para empezar';

  @override
  String homeContactsWaiting(int count) {
    return '$count esperando';
  }

  @override
  String homePhotosWaiting(int count) {
    return '$count esperando';
  }

  @override
  String get homeProgressTitle => 'Tu progreso';

  @override
  String homeProgressStats(int kept, int deleted) {
    return '$kept conservados · $deleted eliminados';
  }

  @override
  String get dockHome => 'Inicio';

  @override
  String get dockTrash => 'Papelera';

  @override
  String get dockSettings => 'Ajustes';

  @override
  String get batchPhotosTitle => 'Fotos y videos';

  @override
  String get batchContactsTitle => 'Contactos';

  @override
  String get batchEmptyTitle => 'Todo al día ✓';

  @override
  String get batchEmptyPhotosSub => 'Has completado todos los lotes de fotos.';

  @override
  String get batchEmptyContactsSub =>
      'Has completado todos los grupos de contactos.';

  @override
  String swipeProgress(int current, int total) {
    return '$current / $total';
  }

  @override
  String get swipeTutorial =>
      'Desliza a la derecha para conservar, a la izquierda para eliminar';

  @override
  String get swipeDismissTutorial => 'Entendido';

  @override
  String get swipeKeep => 'Conservar';

  @override
  String get swipeDelete => 'Eliminar';

  @override
  String get swipeUndo => 'Deshacer';

  @override
  String get sessionSummaryTitle => '¡Buen trabajo!';

  @override
  String get sessionSummarySub => 'Revisaste todo en este lote.';

  @override
  String sessionSummaryKept(int count) {
    return '$count conservados';
  }

  @override
  String sessionSummaryDeleted(int count) {
    return '$count eliminados';
  }

  @override
  String get sessionSummaryBack => 'Volver a lotes';

  @override
  String get duplicatesTitle => 'Contactos duplicados';

  @override
  String duplicatesProgress(int current, int total) {
    return '$current de $total';
  }

  @override
  String get duplicatesAfterMerge => 'Después de combinar';

  @override
  String get duplicatesMerge => 'Combinar';

  @override
  String get duplicatesKeepBoth => 'Conservar ambos';

  @override
  String get duplicatesDeleteOne => 'Eliminar uno';

  @override
  String get duplicatesReasonSamePhone => 'Mismo teléfono';

  @override
  String get duplicatesReasonSameEmail => 'Mismo correo';

  @override
  String get duplicatesReasonSimilarName => 'Nombre similar';

  @override
  String get trashTitle => 'Papelera';

  @override
  String trashReclaimable(String size) {
    return '$size recuperables';
  }

  @override
  String get trashTabPhotos => 'Fotos';

  @override
  String get trashTabContacts => 'Contactos';

  @override
  String get trashEmpty => 'La papelera está vacía';

  @override
  String trashPurgesIn(int days) {
    return 'Se elimina en $days días';
  }

  @override
  String get trashRestore => 'Restaurar';

  @override
  String get trashDeleteForever => 'Eliminar para siempre';

  @override
  String get trashSelectMode => 'Seleccionar';

  @override
  String get streakTitle => 'Tu racha';

  @override
  String streakCurrent(int days) {
    return 'Racha de $days días';
  }

  @override
  String get streakLastWeeks => 'Últimas 5 semanas';

  @override
  String get streakLegendLess => 'Menos';

  @override
  String get streakLegendMore => 'Más';

  @override
  String get settingsTitle => 'Ajustes';

  @override
  String get settingsPremiumTitle => 'Hazte Premium';

  @override
  String get settingsPremiumSub => 'Lotes ilimitados y copia en la nube.';

  @override
  String get settingsPreferences => 'Preferencias';

  @override
  String get settingsAppearance => 'Apariencia';

  @override
  String get settingsAppearanceValue => 'Claro';

  @override
  String get settingsHaptic => 'Retroalimentación háptica';

  @override
  String get settingsNotifications => 'Notificaciones';

  @override
  String get settingsAccount => 'Cuenta';

  @override
  String get settingsSignIn => 'Iniciar sesión';

  @override
  String get settingsDeleteAccount => 'Eliminar cuenta';

  @override
  String get settingsRate => 'Calificar Decluttr';

  @override
  String get settingsShare => 'Compartir Decluttr';

  @override
  String get signInTitle => 'Iniciar sesión';

  @override
  String get signInEmail => 'Correo';

  @override
  String get signInPassword => 'Contraseña';

  @override
  String get signInButton => 'Iniciar sesión';

  @override
  String get errorPhotosTitle => 'No se pudieron cargar las fotos';

  @override
  String get errorPhotosMessage =>
      'No pudimos cargar tu biblioteca. Comprueba tu conexión.';

  @override
  String get errorContactsTitle => 'No se puede acceder a contactos';

  @override
  String get errorContactsMessage =>
      'Decluttr no tiene permiso para leer tus contactos. Actívalo en Ajustes.';

  @override
  String get errorGenericTitle => 'Algo salió mal';

  @override
  String get errorGenericMessage =>
      'Ocurrió un error inesperado. Inténtalo de nuevo.';

  @override
  String get errorPermissionTitle => 'Permiso cambiado';

  @override
  String get errorPermissionMessage =>
      'El acceso a fotos cambió en Ajustes. Reconecta para continuar.';

  @override
  String get errorTryAgain => 'Reintentar';

  @override
  String get errorGoHome => 'Ir al inicio';

  @override
  String get errorOpenSettings => 'Abrir Ajustes';

  @override
  String get errorNotNow => 'Ahora no';

  @override
  String get errorReconnect => 'Reconectar';

  @override
  String get commonBack => 'Atrás';
}
