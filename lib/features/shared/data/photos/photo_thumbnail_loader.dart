import 'dart:typed_data';

import 'package:photo_manager/photo_manager.dart';

import 'photo_load_log.dart';

/// Loads device photo thumbnails by [AssetEntity.id].
class PhotoThumbnailLoader {
  const PhotoThumbnailLoader();

  Future<Uint8List?> load(String assetId, {int size = 320}) async {
    final sw = Stopwatch()..start();
    try {
      final entity = await AssetEntity.fromId(assetId);
      if (entity == null) {
        photoLoadLog('thumbnail id=$assetId entity=null (${sw.elapsedMilliseconds}ms)');
        return null;
      }
      final bytes = await entity.thumbnailDataWithSize(ThumbnailSize.square(size));
      photoLoadLog(
        'thumbnail id=$assetId bytes=${bytes?.length ?? 0} (${sw.elapsedMilliseconds}ms)',
      );
      return bytes;
    } catch (e) {
      photoLoadLog('thumbnail id=$assetId error=$e (${sw.elapsedMilliseconds}ms)');
      return null;
    }
  }
}
