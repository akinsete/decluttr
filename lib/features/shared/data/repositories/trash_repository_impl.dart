import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../../domain/entities/trash_item.dart';
import '../../domain/repositories/trash_repository.dart';

class TrashRepositoryImpl implements TrashRepository {
  TrashRepositoryImpl({required SharedPreferences prefs}) : _prefs = prefs {
    _loadFromPrefs();
  }

  static const _itemsKey = 'trash_items_v1';

  final SharedPreferences _prefs;
  final List<TrashItem> _items = [];

  void _loadFromPrefs() {
    final raw = _prefs.getString(_itemsKey);
    if (raw == null) return;
    final list = jsonDecode(raw) as List<dynamic>;
    _items
      ..clear()
      ..addAll(
        list.map(
          (e) => TrashItem(
            id: e['id'] as String,
            type: (e['type'] as String) == 'contact'
                ? TrashItemType.contact
                : TrashItemType.photo,
            title: e['title'] as String,
            subtitle: e['subtitle'] as String,
            deletedAt: DateTime.parse(e['deletedAt'] as String),
            monthKey: e['monthKey'] as String?,
            initial: e['initial'] as String?,
            isVideo: e['isVideo'] as bool? ?? false,
            durationLabel: e['durationLabel'] as String?,
            sizeBytes: e['sizeBytes'] as int? ?? 0,
            gradientIndex: e['gradientIndex'] as int? ?? 0,
          ),
        ),
      );
  }

  Future<void> _persist() async {
    final encoded = _items
        .map(
          (item) => {
            'id': item.id,
            'type': item.type == TrashItemType.contact ? 'contact' : 'photo',
            'title': item.title,
            'subtitle': item.subtitle,
            'deletedAt': item.deletedAt.toIso8601String(),
            'monthKey': item.monthKey,
            'initial': item.initial,
            'isVideo': item.isVideo,
            'durationLabel': item.durationLabel,
            'sizeBytes': item.sizeBytes,
            'gradientIndex': item.gradientIndex,
          },
        )
        .toList();
    await _prefs.setString(_itemsKey, jsonEncode(encoded));
  }

  @override
  Future<List<TrashItem>> fetchAll() async => List.unmodifiable(_items);

  @override
  Future<List<TrashItem>> fetchByType(TrashItemType type) async {
    return _items.where((item) => item.type == type).toList();
  }

  @override
  Future<void> add(TrashItem item) async {
    _items.removeWhere((existing) => existing.id == item.id);
    _items.insert(0, item);
    await _persist();
  }

  @override
  Future<void> remove(String id) async {
    _items.removeWhere((item) => item.id == id);
    await _persist();
  }

  @override
  Future<void> restore(List<String> ids) async {
    _items.removeWhere((item) => ids.contains(item.id));
    await _persist();
  }

  @override
  Future<void> deleteForever(List<String> ids) async {
    _items.removeWhere((item) => ids.contains(item.id));
    await _persist();
  }

  @override
  Future<int> reclaimableBytes({TrashItemType? type}) async {
    final filtered = type == null
        ? _items
        : _items.where((item) => item.type == type).toList();
    return filtered.fold<int>(0, (sum, item) => sum + item.sizeBytes);
  }
}
