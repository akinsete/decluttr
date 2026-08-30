import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../error/result.dart';

import '../../features/shared/data/repositories/auth_repository_impl.dart';
import '../../features/shared/data/repositories/contacts_repository_impl.dart';
import '../../features/shared/data/repositories/kept_items_repository_impl.dart';
import '../../features/shared/data/repositories/photos_repository_impl.dart';
import '../../features/shared/data/repositories/streak_repository_impl.dart';
import '../../features/shared/data/repositories/swipe_stats_repository_impl.dart';
import '../../features/shared/data/repositories/trash_repository_impl.dart';
import '../../features/shared/domain/committed_photo_bytes.dart';
import '../../features/shared/domain/entities/trash_item.dart';
import '../../features/shared/domain/repositories/app_preferences_repository.dart';
import '../../features/shared/domain/repositories/auth_repository.dart';
import '../../features/shared/domain/repositories/contacts_repository.dart';
import '../../features/shared/domain/repositories/kept_items_repository.dart';
import '../../features/shared/domain/repositories/photos_repository.dart';
import '../../features/shared/domain/repositories/streak_repository.dart';
import '../../features/shared/domain/repositories/swipe_stats_repository.dart';
import '../../features/shared/domain/repositories/trash_repository.dart';
import 'app_state.dart';
import 'permissions_state.dart';

export 'app_state.dart';
export 'permissions_state.dart';

final sharedPreferencesProvider = Provider<SharedPreferences>((ref) {
  throw UnimplementedError('Override sharedPreferencesProvider in main.dart');
});

final appPreferencesRepositoryProvider = Provider<AppPreferencesRepository>(
  (ref) => AppPreferencesRepositoryImpl(ref.watch(sharedPreferencesProvider)),
);

final contactsRepositoryProvider = Provider<ContactsRepository>(
  (ref) => ContactsRepositoryImpl(
    prefs: ref.watch(appPreferencesRepositoryProvider),
  ),
);

final photosRepositoryProvider = Provider<PhotosRepository>(
  (ref) => PhotosRepositoryImpl(
    prefs: ref.watch(appPreferencesRepositoryProvider),
  ),
);

final trashRepositoryProvider = Provider<TrashRepository>(
  (ref) => TrashRepositoryImpl(prefs: ref.watch(sharedPreferencesProvider)),
);

final keptItemsRepositoryProvider = Provider<KeptItemsRepository>(
  (ref) => KeptItemsRepositoryImpl(prefs: ref.watch(sharedPreferencesProvider)),
);

final authRepositoryProvider = Provider<AuthRepository>(
  (ref) => AuthRepositoryImpl(),
);

final swipeStatsRepositoryProvider = Provider<SwipeStatsRepository>(
  (ref) => SwipeStatsRepositoryImpl(
    prefs: ref.watch(sharedPreferencesProvider),
    authRepository: ref.watch(authRepositoryProvider),
  ),
);

final streakRepositoryProvider = Provider<StreakRepository>(
  (ref) => StreakRepositoryImpl(ref.watch(sharedPreferencesProvider)),
);

/// Global app state snapshot for onboarding, permissions, preferences.
class AppStateNotifier extends Notifier<AppState> {
  @override
  AppState build() {
    Future.microtask(_load);
    return const AppState();
  }

  AppPreferencesRepository get _prefs =>
      ref.read(appPreferencesRepositoryProvider);

  Future<void> _load() async {
    await ref.read(authRepositoryProvider).ensureAnonymousUser();
    unawaited(ref.read(swipeStatsRepositoryProvider).syncPendingSessions());
    unawaited(_purgeExpiredTrash());

    state = state.copyWith(
      onboardingComplete: await _prefs.onboardingComplete(),
      tutorialSeen: await _prefs.tutorialSeen(),
      hasActivity: await _prefs.hasActivity(),
      contactsGranted: await _prefs.contactsGranted(),
      photosGranted: await _prefs.photosGranted(),
      hapticOn: await _prefs.hapticOn(),
      notifOn: await _prefs.notifOn(),
      signedIn: await _prefs.signedIn(),
      isLoading: false,
    );
  }

  Future<void> _purgeExpiredTrash() async {
    try {
      final trash = ref.read(trashRepositoryProvider);
      final expired = await trash.fetchExpired();
      if (expired.isEmpty) return;

      final photoIds = expired
          .where((i) => i.type == TrashItemType.photo)
          .map((i) => i.id)
          .toList();
      if (photoIds.isNotEmpty) {
        final photos = ref.read(photosRepositoryProvider);
        final photoItems =
            expired.where((i) => i.type == TrashItemType.photo).toList();
        final bytes = await sumCommittedPhotoBytes(
          photos: photos,
          photoItems: photoItems,
        );
        await photos.deletePhotos(photoIds);
        await ref.read(swipeStatsRepositoryProvider).recordCommittedDeletedBytes(bytes);
      }
      for (final contact in expired.where((i) => i.type == TrashItemType.contact)) {
        await ref.read(contactsRepositoryProvider).deleteContact(contact.id);
      }
      await trash.deleteForever(expired.map((i) => i.id).toList());
    } catch (e, st) {
      debugPrint('AppStateNotifier._purgeExpiredTrash: $e\n$st');
    }
  }

  Future<void> completeOnboarding() async {
    await _prefs.setOnboardingComplete(true);
    state = state.copyWith(onboardingComplete: true);
  }

  Future<void> setTutorialSeen(bool value) async {
    await _prefs.setTutorialSeen(value);
    state = state.copyWith(tutorialSeen: value);
  }

  Future<void> setContactsGranted(bool value) async {
    await _prefs.setContactsGranted(value);
    state = state.copyWith(contactsGranted: value);
  }

  Future<void> setPhotosGranted(bool value) async {
    await _prefs.setPhotosGranted(value);
    state = state.copyWith(photosGranted: value);
  }

  Future<void> setHapticOn(bool value) async {
    await _prefs.setHapticOn(value);
    state = state.copyWith(hapticOn: value);
  }

  Future<void> setNotifOn(bool value) async {
    await _prefs.setNotifOn(value);
    state = state.copyWith(notifOn: value);
  }

  Future<void> setSignedIn(bool value) async {
    await _prefs.setSignedIn(value);
    state = state.copyWith(signedIn: value);
  }

  Future<void> recordActivity() async {
    await _prefs.setHasActivity(true);
    await ref.read(streakRepositoryProvider).recordActivity();
    state = state.copyWith(hasActivity: true);
  }

  Future<void> clearLocalAccountFlags() async {
    await _prefs.setSignedIn(false);
    await _prefs.setHasActivity(false);
    await _prefs.setTutorialSeen(false);
    state = state.copyWith(
      signedIn: false,
      hasActivity: false,
      tutorialSeen: false,
    );
  }
}

final appStateProvider = NotifierProvider<AppStateNotifier, AppState>(
  AppStateNotifier.new,
);

class PermissionsNotifier extends Notifier<PermissionsState> {
  @override
  PermissionsState build() => const PermissionsState(isChecking: false);

  Future<void> refresh() async {
    final contacts = ref.read(contactsRepositoryProvider);
    final photos = ref.read(photosRepositoryProvider);

    final contactsResult = await contacts.hasPermission();
    final photosResult = await photos.hasPermission();

    state = PermissionsState(
      contactsGranted:
          contactsResult is Success<bool> ? contactsResult.value : false,
      photosGranted: photosResult is Success<bool> ? photosResult.value : false,
      isChecking: false,
    );
  }

  Future<bool> requestContacts() async {
    final result =
        await ref.read(contactsRepositoryProvider).requestPermission();
    if (result is Success<bool>) {
      state = state.copyWith(contactsGranted: result.value);
      await ref.read(appStateProvider.notifier).setContactsGranted(result.value);
      return result.value;
    }
    return false;
  }

  Future<bool> requestPhotos() async {
    final result = await ref.read(photosRepositoryProvider).requestPermission();
    if (result is Success<bool>) {
      state = state.copyWith(photosGranted: result.value);
      await ref.read(appStateProvider.notifier).setPhotosGranted(result.value);
      return result.value;
    }
    return false;
  }
}

final permissionsProvider =
    NotifierProvider<PermissionsNotifier, PermissionsState>(
  PermissionsNotifier.new,
);
