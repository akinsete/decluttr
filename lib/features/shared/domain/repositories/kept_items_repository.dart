import '../entities/trash_item.dart';

/// Persists asset/contact IDs the user has kept (swipe-right) so they stay
/// excluded from future swipe decks — mirrors trash ID exclusion, without
/// full trash rows.
abstract class KeptItemsRepository {
  Future<Set<String>> fetchIds(TrashItemType type);
  Future<void> add(String id, TrashItemType type);
  Future<void> remove(String id);
}
