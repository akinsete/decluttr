class ContactRecord {
  const ContactRecord({
    required this.id,
    required this.displayName,
    this.phone,
    this.email,
    this.source = ContactSource.local,
    this.initial,
  });

  final String id;
  final String displayName;
  final String? phone;
  final String? email;
  final ContactSource source;
  final String? initial;

  String get avatarInitial {
    if (initial != null && initial!.isNotEmpty) {
      return initial!.substring(0, 1).toUpperCase();
    }
    final trimmed = displayName.trim();
    if (trimmed.isEmpty) return '?';
    return trimmed.substring(0, 1).toUpperCase();
  }
}

enum ContactSource {
  local,
  iPhone,
  iCloud,
  google,
  work,
}
