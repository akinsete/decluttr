import '../entities/trash_item.dart';

abstract class TrashRepository {
  Future<List<TrashItem>> fetchAll();
  Future<List<TrashItem>> fetchByType(TrashItemType type);
  Future<void> add(TrashItem item);
  Future<void> remove(String id);
  Future<void> restore(List<String> ids);
  Future<void> deleteForever(List<String> ids);
  Future<int> reclaimableBytes({TrashItemType? type});
}
