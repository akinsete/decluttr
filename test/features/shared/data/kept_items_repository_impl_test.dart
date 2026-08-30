import 'package:decluttr/features/shared/data/repositories/kept_items_repository_impl.dart';
import 'package:decluttr/features/shared/domain/entities/trash_item.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  group('KeptItemsRepositoryImpl', () {
    late SharedPreferences prefs;
    late KeptItemsRepositoryImpl repo;

    setUp(() async {
      SharedPreferences.setMockInitialValues({});
      prefs = await SharedPreferences.getInstance();
      repo = KeptItemsRepositoryImpl(prefs: prefs);
    });

    test('add and fetchIds round-trip by type', () async {
      await repo.add('p1', TrashItemType.photo);
      await repo.add('c1', TrashItemType.contact);
      await repo.add('p2', TrashItemType.photo);

      expect(await repo.fetchIds(TrashItemType.photo), {'p1', 'p2'});
      expect(await repo.fetchIds(TrashItemType.contact), {'c1'});
    });

    test('remove drops id from either type set', () async {
      await repo.add('p1', TrashItemType.photo);
      await repo.add('c1', TrashItemType.contact);

      await repo.remove('p1');

      expect(await repo.fetchIds(TrashItemType.photo), isEmpty);
      expect(await repo.fetchIds(TrashItemType.contact), {'c1'});
    });

    test('persists across new repository instances', () async {
      await repo.add('sticky', TrashItemType.photo);

      final reloaded = KeptItemsRepositoryImpl(prefs: prefs);
      expect(await reloaded.fetchIds(TrashItemType.photo), {'sticky'});
    });

    test('add moves id to the new type', () async {
      await repo.add('x', TrashItemType.photo);
      await repo.add('x', TrashItemType.contact);

      expect(await repo.fetchIds(TrashItemType.photo), isEmpty);
      expect(await repo.fetchIds(TrashItemType.contact), {'x'});
    });
  });
}
