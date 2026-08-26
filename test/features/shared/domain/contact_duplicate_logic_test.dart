import 'package:decluttr/features/shared/domain/entities/contact_duplicate_logic.dart';
import 'package:decluttr/features/shared/domain/entities/contact_record.dart';
import 'package:decluttr/features/shared/domain/entities/duplicate_group.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('ContactDuplicateLogic', () {
    test('normalizePhone keeps last 10 digits', () {
      expect(
        ContactDuplicateLogic.normalizePhone('+1 (555) 014-2211'),
        '5550142211',
      );
    });

    test('detects same phone', () {
      final groups = ContactDuplicateLogic.detectGroups(const [
        ContactRecord(id: 'a', displayName: 'Ann', phone: '+1 555 0100'),
        ContactRecord(id: 'b', displayName: 'Anne', phone: '555-0100'),
        ContactRecord(id: 'c', displayName: 'Bob', phone: '555-9999'),
      ]);
      expect(groups, hasLength(1));
      expect(groups.single.reason, DuplicateReason.samePhone);
      expect(groups.single.contacts.map((c) => c.id).toList(), ['a', 'b']);
    });

    test('detects same email', () {
      final groups = ContactDuplicateLogic.detectGroups(const [
        ContactRecord(
          id: 'a',
          displayName: 'Sam One',
          email: 'Sam@Work.com',
        ),
        ContactRecord(
          id: 'b',
          displayName: 'Sam Two',
          email: 'sam@work.com',
        ),
      ]);
      expect(groups, hasLength(1));
      expect(groups.single.reason, DuplicateReason.sameEmail);
    });

    test('detects similar name', () {
      final groups = ContactDuplicateLogic.detectGroups(const [
        ContactRecord(id: 'a', displayName: 'Emily Carter'),
        ContactRecord(id: 'b', displayName: 'Emily'),
      ]);
      expect(groups, hasLength(1));
      expect(groups.single.reason, DuplicateReason.similarName);
    });

    test('fieldUnion unions phones and emails', () {
      final union = ContactDuplicateLogic.fieldUnion(const [
        ContactRecord(
          id: 'a',
          displayName: 'Emily Carter',
          phone: '+1 555 0142',
          email: 'emily@icloud.com',
        ),
        ContactRecord(
          id: 'b',
          displayName: 'Emily C.',
          phone: '+1 555 0142',
          email: 'emily.c@gmail.com',
        ),
      ]);
      expect(union.displayName, 'Emily Carter');
      expect(union.phones, hasLength(1));
      expect(union.emails, hasLength(2));
    });

    test('groupId round-trips with UUID-like ids', () {
      const a = 'E9D545FA-B592-4577-9F42-1C4D5E465608';
      const b = 'A11EC60A-CF32-4399-B60C-11DA6218E73A';
      final id = ContactDuplicateLogic.groupIdFor(a, b);
      expect(ContactDuplicateLogic.parseGroupContactIds(id), (a, b));
    });
  });
}
