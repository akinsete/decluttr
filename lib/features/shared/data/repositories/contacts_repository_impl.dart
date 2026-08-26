import 'package:flutter/foundation.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/error/app_failure.dart';
import '../../../../core/error/result.dart';
import '../../domain/entities/batch_item.dart';
import '../../domain/entities/contact_duplicate_logic.dart';
import '../../domain/entities/contact_record.dart';
import '../../domain/entities/duplicate_group.dart';
import '../../domain/repositories/app_preferences_repository.dart';
import '../../domain/repositories/contacts_repository.dart';

class AppPreferencesRepositoryImpl implements AppPreferencesRepository {
  AppPreferencesRepositoryImpl(this._prefs);

  final SharedPreferences _prefs;

  static const _haptic = 'haptic_on';
  static const _notif = 'notif_on';
  static const _tutorial = 'tutorial_seen';
  static const _onboarding = 'onboarding_complete';
  static const _activity = 'has_activity';
  static const _signedIn = 'signed_in';
  static const _contactsGranted = 'contacts_granted';
  static const _photosGranted = 'photos_granted';

  @override
  Future<bool> hapticOn() async => _prefs.getBool(_haptic) ?? true;

  @override
  Future<bool> notifOn() async => _prefs.getBool(_notif) ?? true;

  @override
  Future<bool> tutorialSeen() async => _prefs.getBool(_tutorial) ?? false;

  @override
  Future<bool> onboardingComplete() async =>
      _prefs.getBool(_onboarding) ?? false;

  @override
  Future<bool> hasActivity() async => _prefs.getBool(_activity) ?? false;

  @override
  Future<bool> signedIn() async => _prefs.getBool(_signedIn) ?? false;

  @override
  Future<bool> contactsGranted() async =>
      _prefs.getBool(_contactsGranted) ?? false;

  @override
  Future<bool> photosGranted() async => _prefs.getBool(_photosGranted) ?? false;

  @override
  Future<void> setHapticOn(bool value) async => _prefs.setBool(_haptic, value);

  @override
  Future<void> setNotifOn(bool value) async => _prefs.setBool(_notif, value);

  @override
  Future<void> setTutorialSeen(bool value) async =>
      _prefs.setBool(_tutorial, value);

  @override
  Future<void> setOnboardingComplete(bool value) async =>
      _prefs.setBool(_onboarding, value);

  @override
  Future<void> setHasActivity(bool value) async =>
      _prefs.setBool(_activity, value);

  @override
  Future<void> setSignedIn(bool value) async => _prefs.setBool(_signedIn, value);

  @override
  Future<void> setContactsGranted(bool value) async =>
      _prefs.setBool(_contactsGranted, value);

  @override
  Future<void> setPhotosGranted(bool value) async =>
      _prefs.setBool(_photosGranted, value);
}

class ContactsRepositoryImpl implements ContactsRepository {
  ContactsRepositoryImpl({
    required AppPreferencesRepository prefs,
  }) : _prefs = prefs;

  final AppPreferencesRepository _prefs;

  static const _contactProperties = {
    ContactProperty.phone,
    ContactProperty.email,
    ContactProperty.name,
  };

  /// Last fetched duplicate groups (for write-back by id).
  List<DuplicateGroup> _cachedDuplicateGroups = const [];

  static const _sampleBatches = [
    BatchItem(
      id: 'recent',
      kind: BatchKind.contacts,
      title: 'Recently Added',
      subtitle: '18 contacts',
      count: 18,
      gradientIndex: 0,
    ),
    BatchItem(
      id: 'no_phone',
      kind: BatchKind.contacts,
      title: 'No Phone Number',
      subtitle: '12 contacts',
      count: 12,
      gradientIndex: 1,
    ),
    BatchItem(
      id: 'no_email',
      kind: BatchKind.contacts,
      title: 'No Email',
      subtitle: '9 contacts',
      count: 9,
      gradientIndex: 2,
    ),
    BatchItem(
      id: 'duplicates',
      kind: BatchKind.contacts,
      title: 'Duplicates',
      subtitle: '7 groups',
      count: 7,
      isDuplicates: true,
      gradientIndex: 3,
    ),
    BatchItem(
      id: 'old',
      kind: BatchKind.contacts,
      title: 'Old Contacts',
      subtitle: '24 contacts',
      count: 24,
      gradientIndex: 4,
    ),
  ];

  @override
  Future<Result<bool>> hasPermission() async {
    try {
      final granted = await _prefs.contactsGranted();
      if (granted) return const Success(true);
      final status = await Permission.contacts.status;
      return Success(status.isGranted);
    } catch (e) {
      return FailureResult(ContactsLoadFailure(message: '$e'));
    }
  }

  @override
  Future<Result<bool>> requestPermission() async {
    try {
      final status = await Permission.contacts.request();
      final granted = status.isGranted;
      await _prefs.setContactsGranted(granted);
      return Success(granted);
    } catch (e) {
      return FailureResult(PermissionDeniedFailure(message: '$e'));
    }
  }

  @override
  Future<Result<List<BatchItem>>> fetchBatches() async {
    final permission = await hasPermission();
    if (permission is FailureResult<bool>) {
      return FailureResult(permission.failure);
    }
    if (permission.valueOrNull == false) {
      return const Success(_sampleBatches);
    }

    try {
      final contacts = await FlutterContacts.getAll(
        properties: _contactProperties,
      );
      if (contacts.isEmpty) {
        return const Success([]);
      }

      final records = contacts.map(_mapContact).toList();
      final noPhone = records.where((c) => (c.phone ?? '').isEmpty).length;
      final noEmail = records.where((c) => (c.email ?? '').isEmpty).length;
      final dupGroups = ContactDuplicateLogic.detectGroups(records);
      _cachedDuplicateGroups = dupGroups;

      final batches = <BatchItem>[
        BatchItem(
          id: 'all',
          kind: BatchKind.contacts,
          title: 'All Contacts',
          subtitle: '${contacts.length} contacts',
          count: contacts.length,
          gradientIndex: 0,
        ),
      ];
      if (noPhone > 0) {
        batches.add(
          BatchItem(
            id: 'no_phone',
            kind: BatchKind.contacts,
            title: 'No Phone Number',
            subtitle: '$noPhone contacts',
            count: noPhone,
            gradientIndex: 1,
          ),
        );
      }
      if (noEmail > 0) {
        batches.add(
          BatchItem(
            id: 'no_email',
            kind: BatchKind.contacts,
            title: 'No Email',
            subtitle: '$noEmail contacts',
            count: noEmail,
            gradientIndex: 2,
          ),
        );
      }
      if (dupGroups.isNotEmpty) {
        batches.add(
          BatchItem(
            id: 'duplicates',
            kind: BatchKind.contacts,
            title: 'Duplicates',
            subtitle: '${dupGroups.length} groups',
            count: dupGroups.length,
            isDuplicates: true,
            gradientIndex: 3,
          ),
        );
      }
      return Success(batches);
    } catch (e, st) {
      debugPrint('ContactsRepositoryImpl.fetchBatches: $e\n$st');
      return FailureResult(ContactsLoadFailure(message: '$e'));
    }
  }

  @override
  Future<Result<List<ContactRecord>>> fetchContactsForBatch(
    String batchId,
  ) async {
    final permission = await hasPermission();
    if (permission.valueOrNull == false) {
      return Success(_sampleContacts(batchId));
    }

    try {
      final contacts = await FlutterContacts.getAll(
        properties: _contactProperties,
      );
      if (contacts.isEmpty) {
        return const Success([]);
      }
      final records = contacts.map(_mapContact).toList();
      return Success(_filterBatch(records, batchId));
    } catch (e) {
      return FailureResult(ContactsLoadFailure(message: '$e'));
    }
  }

  List<ContactRecord> _filterBatch(List<ContactRecord> records, String batchId) {
    switch (batchId) {
      case 'no_phone':
        return records.where((c) => (c.phone ?? '').isEmpty).toList();
      case 'no_email':
        return records.where((c) => (c.email ?? '').isEmpty).toList();
      case 'all':
      default:
        return records;
    }
  }

  @override
  Future<Result<List<DuplicateGroup>>> fetchDuplicateGroups() async {
    final permission = await hasPermission();
    if (permission.valueOrNull == false) {
      final samples = _sampleDuplicateGroups();
      _cachedDuplicateGroups = samples;
      return Success(samples);
    }

    try {
      final contacts = await FlutterContacts.getAll(
        properties: _contactProperties,
      );
      final records = contacts.map(_mapContact).toList();
      final groups = ContactDuplicateLogic.detectGroups(records);
      _cachedDuplicateGroups = groups;
      return Success(groups);
    } catch (e, st) {
      debugPrint('ContactsRepositoryImpl.fetchDuplicateGroups: $e\n$st');
      return FailureResult(ContactsLoadFailure(message: '$e'));
    }
  }

  DuplicateGroup? _groupById(String groupId) {
    for (final g in _cachedDuplicateGroups) {
      if (g.id == groupId) return g;
    }
    return null;
  }

  @override
  Future<Result<void>> mergeDuplicateGroup(String groupId) async {
    final group = _groupById(groupId);
    if (group == null || group.contacts.length < 2) {
      return const FailureResult(
        ContactsLoadFailure(message: 'Duplicate group not found'),
      );
    }

    final primaryId = group.contacts.first.id;
    final secondaryId = group.contacts[1].id;

    try {
      final primary = await FlutterContacts.get(
        primaryId,
        properties: _contactProperties,
      );
      if (primary == null) {
        return const FailureResult(
          ContactsLoadFailure(message: 'Primary contact missing'),
        );
      }

      final union = ContactDuplicateLogic.fieldUnion(group.contacts);
      final updated = primary.copyWith(
        name: Name(first: union.displayName),
        phones: union.phones.map((n) => Phone(number: n)).toList(),
        emails: union.emails.map((e) => Email(address: e)).toList(),
      );

      await FlutterContacts.update(updated);
      await FlutterContacts.delete(secondaryId);
      _cachedDuplicateGroups =
          _cachedDuplicateGroups.where((g) => g.id != groupId).toList();
      return const Success(null);
    } catch (e, st) {
      debugPrint('ContactsRepositoryImpl.mergeDuplicateGroup: $e\n$st');
      return FailureResult(ContactsLoadFailure(message: '$e'));
    }
  }

  @override
  Future<Result<void>> keepBothDuplicateGroup(String groupId) async {
    // No device write — user keeps both records as-is.
    _cachedDuplicateGroups =
        _cachedDuplicateGroups.where((g) => g.id != groupId).toList();
    return const Success(null);
  }

  @override
  Future<Result<void>> deleteOneFromDuplicateGroup(String groupId) async {
    final group = _groupById(groupId);
    if (group == null || group.contacts.length < 2) {
      return const FailureResult(
        ContactsLoadFailure(message: 'Duplicate group not found'),
      );
    }

    final toDelete = group.contacts[1].id;
    try {
      await FlutterContacts.delete(toDelete);
      _cachedDuplicateGroups =
          _cachedDuplicateGroups.where((g) => g.id != groupId).toList();
      return const Success(null);
    } catch (e, st) {
      debugPrint('ContactsRepositoryImpl.deleteOneFromDuplicateGroup: $e\n$st');
      return FailureResult(ContactsLoadFailure(message: '$e'));
    }
  }

  @override
  Future<Result<void>> deleteContact(String contactId) async {
    try {
      await FlutterContacts.delete(contactId);
      return const Success(null);
    } catch (e, st) {
      debugPrint('ContactsRepositoryImpl.deleteContact: $e\n$st');
      return FailureResult(ContactsLoadFailure(message: '$e'));
    }
  }

  ContactRecord _mapContact(Contact contact) {
    final phone = contact.phones.isNotEmpty ? contact.phones.first.number : null;
    final email = contact.emails.isNotEmpty ? contact.emails.first.address : null;
    return ContactRecord(
      id: contact.id ?? '',
      displayName: contact.displayName ?? 'Unknown',
      phone: phone,
      email: email,
      source: ContactSource.local,
    );
  }

  List<ContactRecord> _sampleContacts(String batchId) {
    return List.generate(
      8,
      (i) => ContactRecord(
        id: '$batchId-$i',
        displayName: 'Contact ${i + 1}',
        phone: '+1 555 010${i.toString().padLeft(2, '0')}',
        email: 'contact$i@example.com',
        source: ContactSource.iPhone,
      ),
    );
  }

  List<DuplicateGroup> _sampleDuplicateGroups() {
    return [
      DuplicateGroup(
        id: ContactDuplicateLogic.groupIdFor('e1', 'e2'),
        displayName: 'Emily Carter',
        reason: DuplicateReason.samePhone,
        contacts: const [
          ContactRecord(
            id: 'e1',
            displayName: 'Emily Carter',
            phone: '+1 555 0142',
            email: 'emily@icloud.com',
            source: ContactSource.iPhone,
          ),
          ContactRecord(
            id: 'e2',
            displayName: 'Emily C.',
            phone: '+1 555 0142',
            email: 'emily.c@gmail.com',
            source: ContactSource.google,
          ),
        ],
      ),
      DuplicateGroup(
        id: ContactDuplicateLogic.groupIdFor('m1', 'm2'),
        displayName: 'Marcus Bell',
        reason: DuplicateReason.sameEmail,
        contacts: const [
          ContactRecord(
            id: 'm1',
            displayName: 'Marcus Bell',
            phone: '+1 555 0199',
            email: 'marcus@work.com',
            source: ContactSource.work,
          ),
          ContactRecord(
            id: 'm2',
            displayName: 'Marcus Bell',
            phone: '+1 555 0100',
            email: 'marcus@work.com',
            source: ContactSource.iCloud,
          ),
        ],
      ),
    ];
  }
}
