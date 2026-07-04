import 'package:flutter/foundation.dart';
import 'package:photo_manager/photo_manager.dart';

import '../../../../core/error/app_failure.dart';
import '../../../../core/error/result.dart';
import '../../domain/entities/batch_item.dart';
import '../../domain/entities/photo_asset.dart';
import '../../domain/repositories/app_preferences_repository.dart';
import '../../domain/repositories/photos_repository.dart';

class PhotosRepositoryImpl implements PhotosRepository {
  PhotosRepositoryImpl({
    required AppPreferencesRepository prefs,
  }) : _prefs = prefs;

  final AppPreferencesRepository _prefs;

  static const _sampleBatches = [
    BatchItem(
      id: '2026-05',
      kind: BatchKind.photos,
      title: 'May 2026',
      subtitle: '7 items',
      count: 7,
      gradientIndex: 0,
    ),
    BatchItem(
      id: '2026-04',
      kind: BatchKind.photos,
      title: 'April 2026',
      subtitle: '12 items',
      count: 12,
      gradientIndex: 1,
    ),
    BatchItem(
      id: '2026-03',
      kind: BatchKind.photos,
      title: 'March 2026',
      subtitle: '24 items',
      count: 24,
      gradientIndex: 2,
    ),
  ];

  @override
  Future<Result<bool>> hasPermission() async {
    try {
      final granted = await _prefs.photosGranted();
      if (granted) return const Success(true);
      final state = await PhotoManager.getPermissionState(
        requestOption: const PermissionRequestOption(),
      );
      return Success(state.isAuth);
    } catch (e) {
      return FailureResult(PhotosLoadFailure(message: '$e'));
    }
  }

  @override
  Future<Result<bool>> requestPermission() async {
    try {
      final state = await PhotoManager.requestPermissionExtend();
      final granted = state.isAuth;
      await _prefs.setPhotosGranted(granted);
      return Success(granted);
    } catch (e) {
      return FailureResult(PermissionDeniedFailure(message: '$e'));
    }
  }

  @override
  Future<Result<List<BatchItem>>> fetchBatches() async {
    final permission = await hasPermission();
    if (permission is FailureResult<bool>) {
      return FailureResult(permission.failure);
    }
    if (permission.valueOrNull == false) {
      return const Success(_sampleBatches);
    }

    try {
      final paths = await PhotoManager.getAssetPathList(
        type: RequestType.common,
        hasAll: true,
      );
      if (paths.isEmpty) {
        return const Success(_sampleBatches);
      }

      final recent = paths.first;
      final count = await recent.assetCountAsync;
      if (count == 0) {
        return const Success(_sampleBatches);
      }

      return Success([
        BatchItem(
          id: recent.id,
          kind: BatchKind.photos,
          title: recent.name,
          subtitle: '$count items',
          count: count,
        ),
        ..._sampleBatches,
      ]);
    } catch (e, st) {
      debugPrint('PhotosRepositoryImpl.fetchBatches: $e\n$st');
      return const Success(_sampleBatches);
    }
  }

  @override
  Future<Result<List<PhotoAsset>>> fetchPhotosForBatch(String batchId) async {
    try {
      final paths = await PhotoManager.getAssetPathList(
        type: RequestType.common,
        hasAll: true,
      );
      if (paths.isEmpty) {
        return Success(_samplePhotos(batchId));
      }

      final path = paths.firstWhere(
        (p) => p.id == batchId,
        orElse: () => paths.first,
      );
      final assets = await path.getAssetListPaged(page: 0, size: 20);
      if (assets.isEmpty) {
        return Success(_samplePhotos(batchId));
      }

      return Success(
        assets.asMap().entries.map((entry) {
          final asset = entry.value;
          return PhotoAsset(
            id: asset.id,
            title: asset.title ?? 'IMG_${entry.key}',
            subtitle: asset.relativePath ?? batchId,
            monthKey: batchId,
            isVideo: asset.type == AssetType.video,
            gradientIndex: entry.key % 6,
          );
        }).toList(),
      );
    } catch (e) {
      return Success(_samplePhotos(batchId));
    }
  }

  List<PhotoAsset> _samplePhotos(String batchId) {
    return List.generate(
      6,
      (i) => PhotoAsset(
        id: '$batchId-photo-$i',
        title: 'IMG_014${i + 2}',
        subtitle: batchId,
        monthKey: batchId,
        isVideo: i == 2,
        durationLabel: i == 2 ? '0:18' : null,
        gradientIndex: i,
      ),
    );
  }
}
