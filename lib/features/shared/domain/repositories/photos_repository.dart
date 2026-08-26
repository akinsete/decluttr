import '../../../../core/error/result.dart';
import '../entities/batch_item.dart';
import '../entities/photo_asset.dart';
import '../entities/photo_batch_page.dart';

abstract class PhotosRepository {
  Future<Result<List<BatchItem>>> fetchBatches();
  Future<Result<List<PhotoAsset>>> fetchPhotosForBatch(String batchId);
  Future<Result<PhotoBatchPage>> fetchPhotosForBatchPage(
    String batchId, {
    required int offset,
    required int limit,
  });
  Future<Result<bool>> requestPermission();
  Future<Result<bool>> hasPermission();
  Future<Result<void>> deletePhotos(List<String> assetIds);

  /// Absolute path to a local file suitable for in-app video playback, or null.
  Future<Result<String?>> resolvePlayablePath(String assetId);
}
