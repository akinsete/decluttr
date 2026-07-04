import '../../../../core/error/result.dart';
import '../entities/batch_item.dart';
import '../entities/photo_asset.dart';

abstract class PhotosRepository {
  Future<Result<List<BatchItem>>> fetchBatches();
  Future<Result<List<PhotoAsset>>> fetchPhotosForBatch(String batchId);
  Future<Result<bool>> requestPermission();
  Future<Result<bool>> hasPermission();
}
