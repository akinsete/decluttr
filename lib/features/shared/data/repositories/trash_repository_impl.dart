import '../../domain/entities/trash_item.dart';
import '../../domain/repositories/trash_repository.dart';

class TrashRepositoryImpl implements TrashRepository {
  TrashRepositoryImpl();

  final List<TrashItem> _items = [
    TrashItem(
      id: 't1',
      type: TrashItemType.photo,
      title: 'IMG_0142',
      subtitle: 'May 2026',
      deletedAt: DateTime.now().subtract(const Duration(days: 3)),
      monthKey: '2026-05',
    ),
    TrashItem(
      id: 't2',
      type: TrashItemType.contact,
      title: 'Old Contact',
      subtitle: 'No phone',
      deletedAt: DateTime.now().subtract(const Duration(days: 10)),
      initial: 'O',
    ),
  ];

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
  }

  @override
  Future<void> restore(List<String> ids) async {
    _items.removeWhere((item) => ids.contains(item.id));
  }

  @override
  Future<void> deleteForever(List<String> ids) async {
    _items.removeWhere((item) => ids.contains(item.id));
  }

  @override
  Future<int> reclaimableBytes({TrashItemType? type}) async {
    final filtered = type == null
        ? _items
        : _items.where((item) => item.type == type).toList();
    const bytesPerPhoto = 2200000;
    return filtered.length * bytesPerPhoto;
  }
}
