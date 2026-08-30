import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../../domain/entities/trash_item.dart';
import '../../domain/repositories/kept_items_repository.dart';

class KeptItemsRepositoryImpl implements KeptItemsRepository {
  KeptItemsRepositoryImpl({required SharedPreferences prefs}) : _prefs = prefs {
    _loadFromPrefs();
  }

  static const _itemsKey = 'kept_items_v1';

  final SharedPreferences _prefs;
  final Set<String> _photoIds = {};
  final Set<String> _contactIds = {};

  void _loadFromPrefs() {
    final raw = _prefs.getString(_itemsKey);
    if (raw == null) return;
    final map = jsonDecode(raw) as Map<String, dynamic>;
    _photoIds
      ..clear()
      ..addAll(_stringIds(map['photo']));
    _contactIds
      ..clear()
      ..addAll(_stringIds(map['contact']));
  }

  static Iterable<String> _stringIds(Object? value) {
    if (value is! List<dynamic>) return const [];
    return value.map((e) => e as String);
  }

  Future<void> _persist() async {
    await _prefs.setString(
      _itemsKey,
      jsonEncode({
        'photo': _photoIds.toList(),
        'contact': _contactIds.toList(),
      }),
    );
  }

  Set<String> _setFor(TrashItemType type) =>
      type == TrashItemType.contact ? _contactIds : _photoIds;

  @override
  Future<Set<String>> fetchIds(TrashItemType type) async =>
      Set<String>.from(_setFor(type));

  @override
  Future<void> add(String id, TrashItemType type) async {
    _photoIds.remove(id);
    _contactIds.remove(id);
    _setFor(type).add(id);
    await _persist();
  }

  @override
  Future<void> remove(String id) async {
    final changed = _photoIds.remove(id) | _contactIds.remove(id);
    if (changed) await _persist();
  }
}
