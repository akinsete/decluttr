import '../entities/contact_record.dart';
import '../entities/duplicate_group.dart';

/// Pure helpers for detecting and merging duplicate contacts (no Flutter plugins).
abstract final class ContactDuplicateLogic {
  /// Digits-only phone for equality (last 10 digits when longer).
  static String? normalizePhone(String? phone) {
    if (phone == null) return null;
    final digits = phone.replaceAll(RegExp(r'\D'), '');
    if (digits.isEmpty) return null;
    if (digits.length > 10) return digits.substring(digits.length - 10);
    return digits;
  }

  static bool phonesMatch(String? a, String? b) {
    final na = normalizePhone(a);
    final nb = normalizePhone(b);
    if (na == null || nb == null) return false;
    if (na == nb) return true;
    // Allow country-code / formatting length differences (e.g. 15550100 vs 5550100).
    if (na.length >= 7 && nb.length >= 7) {
      return na.endsWith(nb) || nb.endsWith(na);
    }
    return false;
  }

  static String? normalizeEmail(String? email) {
    if (email == null) return null;
    final trimmed = email.trim().toLowerCase();
    return trimmed.isEmpty ? null : trimmed;
  }

  static String normalizeName(String name) {
    return name
        .toLowerCase()
        .replaceAll(RegExp(r'[^a-z0-9\s]'), '')
        .replaceAll(RegExp(r'\s+'), ' ')
        .trim();
  }

  /// Pairs contacts that share phone, email, or a highly similar display name.
  /// Each contact appears in at most one group (first match wins).
  static List<DuplicateGroup> detectGroups(List<ContactRecord> contacts) {
    final used = <String>{};
    final groups = <DuplicateGroup>[];

    for (var i = 0; i < contacts.length; i++) {
      final a = contacts[i];
      if (used.contains(a.id) || a.id.isEmpty) continue;

      for (var j = i + 1; j < contacts.length; j++) {
        final b = contacts[j];
        if (used.contains(b.id) || b.id.isEmpty) continue;

        final reason = _matchReason(a, b);
        if (reason == null) continue;

        used
          ..add(a.id)
          ..add(b.id);
        groups.add(
          DuplicateGroup(
            id: groupIdFor(a.id, b.id),
            displayName: a.displayName.trim().isNotEmpty
                ? a.displayName
                : b.displayName,
            reason: reason,
            contacts: [a, b],
          ),
        );
        break;
      }
    }

    return groups;
  }

  static DuplicateReason? _matchReason(ContactRecord a, ContactRecord b) {
    if (phonesMatch(a.phone, b.phone)) {
      return DuplicateReason.samePhone;
    }

    final emailA = normalizeEmail(a.email);
    final emailB = normalizeEmail(b.email);
    if (emailA != null && emailA == emailB) {
      return DuplicateReason.sameEmail;
    }

    final nameA = normalizeName(a.displayName);
    final nameB = normalizeName(b.displayName);
    if (nameA.isEmpty || nameB.isEmpty) return null;
    if (nameA == nameB) return DuplicateReason.similarName;
    if (nameA.length >= 4 && nameB.length >= 4) {
      if (nameA.contains(nameB) || nameB.contains(nameA)) {
        return DuplicateReason.similarName;
      }
    }
    return null;
  }

  /// Field-union preview used for write-back onto the primary contact.
  static ({String displayName, List<String> phones, List<String> emails})
      fieldUnion(List<ContactRecord> contacts) {
    final displayName = contacts
        .map((c) => c.displayName.trim())
        .firstWhere((n) => n.isNotEmpty, orElse: () => 'Unknown');

    final phones = <String>[];
    final seenPhones = <String>{};
    for (final c in contacts) {
      final raw = c.phone?.trim();
      if (raw == null || raw.isEmpty) continue;
      final key = normalizePhone(raw) ?? raw;
      if (seenPhones.add(key)) phones.add(raw);
    }

    final emails = <String>[];
    final seenEmails = <String>{};
    for (final c in contacts) {
      final raw = c.email?.trim();
      if (raw == null || raw.isEmpty) continue;
      final key = normalizeEmail(raw) ?? raw;
      if (seenEmails.add(key)) emails.add(raw);
    }

    return (displayName: displayName, phones: phones, emails: emails);
  }

  /// Stable group id that survives opaque contact ids (UUIDs with hyphens).
  static String groupIdFor(String idA, String idB) => 'dup::$idA::$idB';

  /// Parses [groupIdFor] back into the two source contact ids.
  static (String, String)? parseGroupContactIds(String groupId) {
    if (!groupId.startsWith('dup::')) return null;
    final rest = groupId.substring(5);
    final sep = rest.indexOf('::');
    if (sep <= 0 || sep >= rest.length - 2) return null;
    final a = rest.substring(0, sep);
    final b = rest.substring(sep + 2);
    if (a.isEmpty || b.isEmpty) return null;
    return (a, b);
  }
}
