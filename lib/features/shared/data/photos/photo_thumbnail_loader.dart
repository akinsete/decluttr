import 'dart:collection';
import 'dart:typed_data';

import 'package:photo_manager/photo_manager.dart';

import 'photo_load_log.dart';

/// Loads device photo thumbnails by [AssetEntity.id].
class PhotoThumbnailLoader {
  const PhotoThumbnailLoader();

  static const _maxCached = 32;
  static final LinkedHashMap<String, Uint8List> _cache = LinkedHashMap();

  Future<Uint8List?> load(String assetId, {int size = 320}) async {
    final key = '$assetId@$size';
    final cached = _cache.remove(key);
    if (cached != null) {
      _cache[key] = cached;
      return cached;
    }

    final sw = Stopwatch()..start();
    try {
      final entity = await AssetEntity.fromId(assetId);
      if (entity == null) {
        photoLoadLog('thumbnail id=$assetId entity=null (${sw.elapsedMilliseconds}ms)');
        return null;
      }
      // Lower JPEG quality keeps video frame extraction snappy on swipe.
      final bytes = await entity.thumbnailDataWithSize(
        ThumbnailSize.square(size),
        quality: 55,
      );
      if (bytes != null) {
        _cache[key] = bytes;
        while (_cache.length > _maxCached) {
          _cache.remove(_cache.keys.first);
        }
      }
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
