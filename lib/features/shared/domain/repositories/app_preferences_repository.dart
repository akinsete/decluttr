abstract class AppPreferencesRepository {
  Future<bool> hapticOn();
  Future<bool> notifOn();
  Future<bool> tutorialSeen();
  Future<bool> onboardingComplete();
  Future<bool> hasActivity();
  Future<bool> signedIn();
  Future<bool> contactsGranted();
  Future<bool> photosGranted();

  Future<void> setHapticOn(bool value);
  Future<void> setNotifOn(bool value);
  Future<void> setTutorialSeen(bool value);
  Future<void> setOnboardingComplete(bool value);
  Future<void> setHasActivity(bool value);
  Future<void> setSignedIn(bool value);
  Future<void> setContactsGranted(bool value);
  Future<void> setPhotosGranted(bool value);
}
