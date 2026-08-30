import '../../../core/error/result.dart';
import 'entities/trash_item.dart';
import 'repositories/photos_repository.dart';

/// Sums photo sizes for Insights Storage freed.
/// Re-resolves when [TrashItem.sizeBytes] is missing — call **before** device delete.
Future<int> sumCommittedPhotoBytes({
  required PhotosRepository photos,
  required List<TrashItem> photoItems,
}) async {
  var total = 0;
  for (final item in photoItems) {
    var bytes = item.sizeBytes;
    if (bytes <= 0) {
      final sized = await photos.resolvePhotoSizeBytes(item.id);
      bytes = sized.valueOrNull ?? 0;
    }
    total += bytes;
  }
  return total;
}
