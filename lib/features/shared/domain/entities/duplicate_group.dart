import 'contact_record.dart';

enum DuplicateReason {
  samePhone,
  sameEmail,
  similarName,
}

class DuplicateGroup {
  const DuplicateGroup({
    required this.id,
    required this.displayName,
    required this.reason,
    required this.contacts,
  });

  final String id;
  final String displayName;
  final DuplicateReason reason;
  final List<ContactRecord> contacts;

  ContactRecord? get mergedPreview {
    if (contacts.isEmpty) return null;
    final first = contacts.first;
    final phone = contacts
        .map((c) => c.phone)
        .firstWhere((p) => p != null && p.isNotEmpty, orElse: () => null);
    final emails = contacts
        .map((c) => c.email)
        .where((e) => e != null && e.isNotEmpty)
        .map((e) => e!)
        .toSet()
        .toList();
    return ContactRecord(
      id: 'merged-${first.id}',
      displayName: displayName,
      phone: phone,
      email: emails.isNotEmpty ? emails.first : null,
      initial: first.avatarInitial,
    );
  }
}
