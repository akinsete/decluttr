abstract class AuthRepository {
  /// Ensures a Firebase user exists (anonymous if none).
  Future<String?> ensureAnonymousUser();

  /// Current Firebase uid, or null when auth is unavailable.
  String? get currentUserId;

  /// Whether the current user is anonymous (upgradeable later).
  bool get isAnonymous;

  /// Links email/password to the current anonymous account.
  Future<void> linkWithEmail({required String email, required String password});
}
