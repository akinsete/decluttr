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
  String homeStreakTitle(int days) {
    final intl.NumberFormat daysNumberFormat = intl.NumberFormat.decimalPattern(
      localeName,
    );
    final String daysString = daysNumberFormat.format(days);

    return 'Racha de $daysString días';
  }

  @override
  String get homeContactsTitle => 'Contactos';

  @override
  String get homePhotosTitle => 'Fotos y videos';

  @override
  String get homeTapToStart => 'Toca para empezar';

  @override
  String homeContactsWaiting(int count) {
    final intl.NumberFormat countNumberFormat =
        intl.NumberFormat.decimalPattern(localeName);
    final String countString = countNumberFormat.format(count);

    return '$countString esperando';
  }

  @override
  String homePhotosWaiting(int count) {
    final intl.NumberFormat countNumberFormat =
        intl.NumberFormat.decimalPattern(localeName);
    final String countString = countNumberFormat.format(count);

    return '$countString esperando';
  }

  @override
  String get homeProgressTitle => 'Tu progreso';

  @override
  String get homeProgressViewAll => 'Ver todas las stats ›';

  @override
  String get homeProgressItemsRemaining => 'elementos restantes';

  @override
  String get dockHome => 'Inicio';

  @override
  String get dockTrash => 'Papelera';

  @override
  String get dockSettings => 'Ajustes';

  @override
  String get batchPhotosTitle => 'Photos';

  @override
  String get batchPhotosSubtitle => 'Elige qué quieres limpiar.';

  @override
  String get batchChooseSection => 'Elige un lote';

  @override
  String batchPhotoCount(int count) {
    final intl.NumberFormat countNumberFormat =
        intl.NumberFormat.decimalPattern(localeName);
    final String countString = countNumberFormat.format(count);

    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$countString fotos',
      one: '1 foto',
    );
    return '$_temp0';
  }

  @override
  String get batchDuplicatesTitle => 'Duplicados';

  @override
  String batchDuplicatesPhotosHint(int count) {
    final intl.NumberFormat countNumberFormat =
        intl.NumberFormat.decimalPattern(localeName);
    final String countString = countNumberFormat.format(count);

    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$countString fotos parecidas',
      one: '1 foto parecida',
    );
    return '$_temp0';
  }

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
    final intl.NumberFormat currentNumberFormat =
        intl.NumberFormat.decimalPattern(localeName);
    final String currentString = currentNumberFormat.format(current);
    final intl.NumberFormat totalNumberFormat =
        intl.NumberFormat.decimalPattern(localeName);
    final String totalString = totalNumberFormat.format(total);

    return '$currentString/$totalString';
  }

  @override
  String get swipeTutorialTitle => 'Así funciona';

  @override
  String get swipeTutorial =>
      'Desliza a la izquierda para eliminar, a la derecha para conservar';

  @override
  String get swipeDismissTutorial => 'Entendido';

  @override
  String get swipeKeep => 'Conservar';

  @override
  String get swipeDelete => 'Eliminar';

  @override
  String get swipeUndo => 'Deshacer';

  @override
  String get swipePlayVideo => 'Reproducir vídeo';

  @override
  String get swipeVideoUnavailable => 'No se pudo reproducir este vídeo';

  @override
  String get sessionSummaryTitle => '¡Listo!';

  @override
  String get sessionSummarySubPhotos =>
      'Revisaste todas las fotos de este lote. Buena limpieza.';

  @override
  String get sessionSummarySubContacts =>
      'Revisaste todos los contactos de este lote. Buena limpieza.';

  @override
  String get sessionSummaryKeptLabel => 'Conservados';

  @override
  String get sessionSummaryDeletedLabel => 'Eliminados';

  @override
  String sessionSummaryDeletedSize(String size) {
    return '$size eliminados';
  }

  @override
  String sessionSummaryKept(int count) {
    final intl.NumberFormat countNumberFormat =
        intl.NumberFormat.decimalPattern(localeName);
    final String countString = countNumberFormat.format(count);

    return '$countString conservados';
  }

  @override
  String sessionSummaryDeleted(int count) {
    final intl.NumberFormat countNumberFormat =
        intl.NumberFormat.decimalPattern(localeName);
    final String countString = countNumberFormat.format(count);

    return '$countString eliminados';
  }

  @override
  String get sessionSummaryBack => 'Volver a lotes';

  @override
  String get duplicatesTitle => 'Contactos duplicados';

  @override
  String duplicatesProgress(int current, int total) {
    final intl.NumberFormat currentNumberFormat =
        intl.NumberFormat.decimalPattern(localeName);
    final String currentString = currentNumberFormat.format(current);
    final intl.NumberFormat totalNumberFormat =
        intl.NumberFormat.decimalPattern(localeName);
    final String totalString = totalNumberFormat.format(total);

    return '$currentString de $totalString';
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
  String get trashSubtitle => 'Revisa antes de eliminar para siempre.';

  @override
  String trashReclaimable(String size) {
    return '$size recuperables';
  }

  @override
  String get trashTabPhotos => 'Fotos';

  @override
  String get trashTabContacts => 'Contactos';

  @override
  String trashTabPhotosCount(int count) {
    final intl.NumberFormat countNumberFormat =
        intl.NumberFormat.decimalPattern(localeName);
    final String countString = countNumberFormat.format(count);

    return 'Fotos ($countString)';
  }

  @override
  String trashTabContactsCount(int count) {
    final intl.NumberFormat countNumberFormat =
        intl.NumberFormat.decimalPattern(localeName);
    final String countString = countNumberFormat.format(count);

    return 'Contactos ($countString)';
  }

  @override
  String get trashEmpty => 'La papelera está vacía';

  @override
  String get trashEmptyPhotosSub =>
      'Los elementos que deslices durante la limpieza aparecerán aquí hasta que los elimines para siempre.';

  @override
  String get trashEmptyContactsTitle => 'No hay contactos en la papelera';

  @override
  String get trashEmptyContactsSub =>
      'Los contactos que elimines durante la limpieza aparecerán aquí.';

  @override
  String get trashSelect => 'Seleccionar';

  @override
  String get trashSelectAll => 'Seleccionar todo';

  @override
  String get trashDeselectAll => 'Deseleccionar todo';

  @override
  String get trashCancel => 'Cancelar';

  @override
  String trashItemsCount(int count) {
    final intl.NumberFormat countNumberFormat =
        intl.NumberFormat.decimalPattern(localeName);
    final String countString = countNumberFormat.format(count);

    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$countString elementos',
      one: '1 elemento',
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
      other: '$countString seleccionados',
      one: '1 seleccionado',
    );
    return '$_temp0';
  }

  @override
  String get trashDeleteSelected => 'Eliminar seleccionados';

  @override
  String trashPurgesIn(int days) {
    final intl.NumberFormat daysNumberFormat = intl.NumberFormat.decimalPattern(
      localeName,
    );
    final String daysString = daysNumberFormat.format(days);

    return 'Se elimina en $daysString días';
  }

  @override
  String get trashRestore => 'Restaurar';

  @override
  String get trashDeleteForever => 'Eliminar para siempre';

  @override
  String trashDockBadgeA11y(int count) {
    final intl.NumberFormat countNumberFormat =
        intl.NumberFormat.decimalPattern(localeName);
    final String countString = countNumberFormat.format(count);

    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$countString elementos en la papelera',
      one: '1 elemento en la papelera',
      zero: 'Ningún elemento en la papelera',
    );
    return '$_temp0';
  }

  @override
  String get trashSelectMode => 'Seleccionar';

  @override
  String get insightsTitle => 'Estadísticas';

  @override
  String get insightsStorageFreed => 'Almacenamiento liberado';

  @override
  String get insightsThisWeek => 'Esta semana';

  @override
  String insightsWeekCleaned(int count) {
    final intl.NumberFormat countNumberFormat =
        intl.NumberFormat.decimalPattern(localeName);
    final String countString = countNumberFormat.format(count);

    return '+$countString limpiados';
  }

  @override
  String get insightsCleanedByType => 'Limpiado por tipo';

  @override
  String get insightsPhotosVideos => 'Fotos y videos';

  @override
  String get insightsContacts => 'Contactos';

  @override
  String insightsStreakSummary(int current, int longest) {
    final intl.NumberFormat currentNumberFormat =
        intl.NumberFormat.decimalPattern(localeName);
    final String currentString = currentNumberFormat.format(current);
    final intl.NumberFormat longestNumberFormat =
        intl.NumberFormat.decimalPattern(localeName);
    final String longestString = longestNumberFormat.format(longest);

    return 'Racha de $currentString días · mejor $longestString';
  }

  @override
  String get insightsStreakSubtitle => 'Ver tu historial de rachas';

  @override
  String get streakTitle => 'Tu racha';

  @override
  String streakCurrent(int days) {
    final intl.NumberFormat daysNumberFormat = intl.NumberFormat.decimalPattern(
      localeName,
    );
    final String daysString = daysNumberFormat.format(days);

    return 'Racha de $daysString días';
  }

  @override
  String get streakDayStreakLabel => 'Días de racha';

  @override
  String get streakKeepGoing => '¡Sigue así!';

  @override
  String get streakWeekdayMon => 'L';

  @override
  String get streakWeekdayTue => 'M';

  @override
  String get streakWeekdayWed => 'X';

  @override
  String get streakWeekdayThu => 'J';

  @override
  String get streakWeekdayFri => 'V';

  @override
  String get streakWeekdaySat => 'S';

  @override
  String get streakWeekdaySun => 'D';

  @override
  String get streakLastWeeks => 'Últimas 5 semanas';

  @override
  String get streakWeekRangeHint => 'Lun → Dom';

  @override
  String get streakLegendLess => 'Menos';

  @override
  String get streakLegendMore => 'Más';

  @override
  String get streakLongest => 'Racha más larga';

  @override
  String get streakItemsCleaned => 'Elementos limpiados';

  @override
  String get streakKeepCleaning => 'Seguir limpiando';

  @override
  String get settingsTitle => 'Ajustes';

  @override
  String get settingsPremiumTitle => 'Hazte Premium';

  @override
  String get settingsPremiumSub => 'Limpieza ilimitada y mucho más.';

  @override
  String get settingsSignInSub => 'Sincroniza tus limpiezas entre dispositivos';

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
  String get settingsPrivacyPermissions => 'Privacidad y permisos';

  @override
  String get settingsPhotosAccess => 'Acceso a fotos';

  @override
  String get settingsContactsAccess => 'Acceso a contactos';

  @override
  String get settingsAccessFull => 'Acceso total';

  @override
  String get settingsAccessDenied => 'No permitido';

  @override
  String get settingsMore => 'Más';

  @override
  String get settingsSignIn => 'Iniciar sesión';

  @override
  String get settingsRate => 'Calificar Decluttr';

  @override
  String get settingsShare => 'Compartir Decluttr';

  @override
  String get settingsShareMessage =>
      'Estoy ordenando con Decluttr: desliza para limpiar contactos y fotos.';

  @override
  String get settingsDeleteAccount => 'Eliminar datos de la cuenta';

  @override
  String get settingsDeleteAccountConfirmTitle => '¿Eliminar datos locales?';

  @override
  String get settingsDeleteAccountConfirmBody =>
      'Esto cierra la sesión y borra los datos de Decluttr en este dispositivo. Las fotos y contactos del teléfono no cambian.';

  @override
  String get settingsDeleteAccountConfirmAction => 'Eliminar';

  @override
  String get settingsCancel => 'Cancelar';

  @override
  String get settingsPremiumComingSoon => 'Premium llegará pronto.';

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
