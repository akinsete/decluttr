import 'package:flutter/foundation.dart';
import 'package:photo_manager/photo_manager.dart';

import '../../../../core/error/app_failure.dart';
import '../../../../core/error/result.dart';
import '../../domain/entities/batch_item.dart';
import '../../domain/entities/photo_asset.dart';
import '../../domain/entities/photo_batch_page.dart';
import '../../domain/entities/photo_size_formatter.dart';
import '../../domain/repositories/app_preferences_repository.dart';
import '../../domain/repositories/photos_repository.dart';
import '../photos/photo_load_log.dart';
import '../photos/photos_month_grouper.dart';

class PhotosRepositoryImpl implements PhotosRepository {
  PhotosRepositoryImpl({
    required AppPreferencesRepository prefs,
  }) : _prefs = prefs;

  final AppPreferencesRepository _prefs;

  final Map<String, _MonthPhotoIndex> _monthPhotoIndexes = {};

  static const _duplicatesBatch = BatchItem(
    id: 'dup',
    kind: BatchKind.photos,
    title: 'Duplicates',
    subtitle: '11 similar',
    count: 11,
    isDuplicates: true,
  );

  static const _sampleMonths = [
    BatchItem(
      id: '2026-05',
      kind: BatchKind.photos,
      title: 'May 2026',
      subtitle: '7 photos',
      count: 7,
      gradientIndex: 0,
    ),
    BatchItem(
      id: '2026-04',
      kind: BatchKind.photos,
      title: 'April 2026',
      subtitle: '6 photos',
      count: 6,
      gradientIndex: 1,
    ),
    BatchItem(
      id: '2026-03',
      kind: BatchKind.photos,
      title: 'March 2026',
      subtitle: '7 photos',
      count: 7,
      gradientIndex: 2,
    ),
    BatchItem(
      id: '2026-02',
      kind: BatchKind.photos,
      title: 'February 2026',
      subtitle: '5 photos',
      count: 5,
      gradientIndex: 3,
    ),
    BatchItem(
      id: '2026-01',
      kind: BatchKind.photos,
      title: 'January 2026',
      subtitle: '6 photos',
      count: 6,
      gradientIndex: 4,
    ),
    BatchItem(
      id: '2025-12',
      kind: BatchKind.photos,
      title: 'December 2025',
      subtitle: '8 photos',
      count: 8,
      gradientIndex: 0,
    ),
    BatchItem(
      id: '2025-11',
      kind: BatchKind.photos,
      title: 'November 2025',
      subtitle: '5 photos',
      count: 5,
      gradientIndex: 1,
    ),
  ];

  static List<BatchItem> get _sampleBatches => [
        _duplicatesBatch,
        ..._sampleMonths,
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
      return Success(_sampleBatches);
    }

    try {
      final paths = await PhotoManager.getAssetPathList(
        type: RequestType.common,
        hasAll: true,
      );
      if (paths.isEmpty) {
        return Success(_sampleBatches);
      }

      final monthCounts = await _countAssetsByMonth(paths.first);
      if (monthCounts.isEmpty) {
        return Success(_sampleBatches);
      }

      return Success([
        _duplicatesBatch,
        ...batchItemsFromMonthCounts(monthCounts),
      ]);
    } catch (e, st) {
      debugPrint('PhotosRepositoryImpl.fetchBatches: $e\n$st');
      return Success(_sampleBatches);
    }
  }

  @override
  Future<Result<List<PhotoAsset>>> fetchPhotosForBatch(String batchId) async {
    final page = await fetchPhotosForBatchPage(
      batchId,
      offset: 0,
      limit: 1 << 20,
    );
    return switch (page) {
      Success(value: final batch) => Success(batch.items),
      FailureResult(failure: final failure) => FailureResult(failure),
    };
  }

  @override
  Future<Result<PhotoBatchPage>> fetchPhotosForBatchPage(
    String batchId, {
    required int offset,
    required int limit,
  }) async {
    final trace = PhotoLoadTrace('fetchPhotosForBatchPage($batchId off=$offset lim=$limit)');
    if (batchId == _duplicatesBatch.id) {
      final all = _samplePhotos(batchId);
      final slice = all.skip(offset).take(limit).toList();
      trace.finish('sample duplicates ${slice.length} items');
      return Success(
        PhotoBatchPage(
          items: slice,
          totalCount: all.length,
          hasMore: offset + slice.length < all.length,
        ),
      );
    }

    final permission = await hasPermission();
    trace.step('hasPermission');
    if (permission.valueOrNull == false) {
      final all = _samplePhotos(batchId);
      final slice = all.skip(offset).take(limit).toList();
      trace.finish('sample (no permission) ${slice.length} items');
      return Success(
        PhotoBatchPage(
          items: slice,
          totalCount: all.length,
          hasMore: offset + slice.length < all.length,
        ),
      );
    }

    final month = parseMonthKey(batchId);
    if (month == null) {
      final all = _samplePhotos(batchId);
      final slice = all.skip(offset).take(limit).toList();
      trace.finish('sample (bad month key) ${slice.length} items');
      return Success(
        PhotoBatchPage(
          items: slice,
          totalCount: all.length,
          hasMore: offset + slice.length < all.length,
        ),
      );
    }

    try {
      final path = await _pathForMonth(batchId, month.$1, month.$2);
      trace.step('pathForMonth');
      if (path == null) {
        final all = _samplePhotos(batchId);
        final slice = all.skip(offset).take(limit).toList();
        trace.finish('sample (no path) ${slice.length} items');
        return Success(
          PhotoBatchPage(
            items: slice,
            totalCount: all.length,
            hasMore: offset + slice.length < all.length,
          ),
        );
      }

      final index = await _ensureMonthIndex(
        batchId: batchId,
        path: path,
        targetCount: offset + limit,
      );
      trace.step(
        'ensureMonthIndex cached=${index.assets.length} '
        'monthTotal=${index.monthTotalCount} '
        'libPage=${index.libraryPage} exhausted=${index.exhaustedLibrary}',
      );

      final sliceAssets = index.assets.skip(offset).take(limit).toList();
      final photos = await _photoAssetsFromEntities(
        sliceAssets,
        batchId,
        offset,
        resolveFileSizes: false,
        trace: trace,
      );
      trace.step('hydrate ${photos.length} PhotoAssets (sizes deferred)');

      final page = PhotoBatchPage(
        items: photos,
        totalCount: index.monthTotalCount,
        hasMore: offset + photos.length < index.monthTotalCount,
      );
      trace.finish(
        'returned ${photos.length} items totalKnown=${page.totalCount} hasMore=${page.hasMore}',
      );
      return Success(page);
    } catch (e, st) {
      trace.finish('error: $e');
      debugPrint('PhotosRepositoryImpl.fetchPhotosForBatchPage: $e\n$st');
      final all = _samplePhotos(batchId);
      final slice = all.skip(offset).take(limit).toList();
      return Success(
        PhotoBatchPage(
          items: slice,
          totalCount: all.length,
          hasMore: offset + slice.length < all.length,
        ),
      );
    }
  }

  Future<AssetPathEntity?> _pathForMonth(
    String batchId,
    int year,
    int month,
  ) async {
    final cached = _monthPhotoIndexes[batchId];
    if (cached?.path != null) return cached!.path;

    final filter = monthFilterOption(year, month);
    final paths = await PhotoManager.getAssetPathList(
      type: RequestType.common,
      hasAll: true,
      filterOption: filter,
    );
    if (paths.isEmpty) return null;

    final path = paths.first;
    final index = _monthPhotoIndexes.putIfAbsent(batchId, _MonthPhotoIndex.new);
    index.path = path;
    index.monthTotalCount = await path.assetCountAsync;
    photoLoadLog(
      '_pathForMonth($batchId) album="${path.name}" '
      'assetCount=${index.monthTotalCount}',
    );
    return path;
  }

  Future<_MonthPhotoIndex> _ensureMonthIndex({
    required String batchId,
    required AssetPathEntity path,
    required int targetCount,
  }) async {
    final cached = _monthPhotoIndexes.putIfAbsent(batchId, _MonthPhotoIndex.new);
    cached.path ??= path;
    if (cached.monthTotalCount == 0) {
      cached.monthTotalCount = await path.assetCountAsync;
    }

    if (cached.assets.length >= targetCount || cached.exhaustedLibrary) {
      photoLoadLog(
        '_ensureMonthIndex($batchId) cache hit '
        'cached=${cached.assets.length} target=$targetCount '
        'monthTotal=${cached.monthTotalCount}',
      );
      return cached;
    }

    photoLoadLog(
      '_ensureMonthIndex($batchId) monthTotal=${cached.monthTotalCount} '
      'target=$targetCount cached=${cached.assets.length}',
    );
    if (cached.monthTotalCount == 0) {
      cached.exhaustedLibrary = true;
      return cached;
    }

    while (!cached.exhaustedLibrary && cached.assets.length < targetCount) {
      final pageSw = Stopwatch()..start();
      final assets = await path.getAssetListPaged(
        page: cached.libraryPage,
        size: photosMonthScanPageSize,
      );
      photoLoadLog(
        '_ensureMonthIndex($batchId) libPage=${cached.libraryPage} '
        'fetched=${assets.length} in ${pageSw.elapsedMilliseconds}ms',
      );
      if (assets.isEmpty) {
        cached.exhaustedLibrary = true;
        break;
      }

      cached.assets.addAll(assets);
      cached.libraryPage++;
      if (cached.libraryPage * photosMonthScanPageSize >= cached.monthTotalCount) {
        cached.exhaustedLibrary = true;
      }
    }

    photoLoadLog(
      '_ensureMonthIndex($batchId) done cached=${cached.assets.length} '
      'monthTotal=${cached.monthTotalCount} exhausted=${cached.exhaustedLibrary}',
    );
    return cached;
  }

  Future<List<PhotoAsset>> _photoAssetsFromEntities(
    List<AssetEntity> assets,
    String batchId,
    int offset, {
    required bool resolveFileSizes,
    PhotoLoadTrace? trace,
  }) async {
    final photos = <PhotoAsset>[];
    for (final asset in assets) {
      final sizeSw = Stopwatch()..start();
      final sizeBytes = resolveFileSizes ? await _readAssetSizeBytes(asset) : 0;
      if (resolveFileSizes) {
        photoLoadLog(
          'originFile id=${asset.id} size=$sizeBytes '
          'took ${sizeSw.elapsedMilliseconds}ms',
        );
      }
      photos.add(
        PhotoAsset(
          id: asset.id,
          title: asset.title ?? 'IMG_${offset + photos.length + 1}',
          subtitle: photoCardSubtitle(asset.createDateTime, sizeBytes),
          monthKey: batchId,
          isVideo: asset.type == AssetType.video,
          durationLabel: asset.type == AssetType.video
              ? formatVideoDurationSeconds(asset.duration)
              : null,
          gradientIndex: (offset + photos.length) % 6,
          sizeBytes: sizeBytes,
        ),
      );
    }
    if (!resolveFileSizes && assets.isNotEmpty) {
      trace?.step('skipped originFile for ${assets.length} assets (deferred)');
    }
    return photos;
  }

  Future<Map<String, int>> _countAssetsByMonth(AssetPathEntity path) async {
    final total = await path.assetCountAsync;
    if (total == 0) return const {};

    var counts = <String, int>{};
    for (var page = 0; page * photosMonthScanPageSize < total; page++) {
      final assets = await path.getAssetListPaged(
        page: page,
        size: photosMonthScanPageSize,
      );
      for (final asset in assets) {
        counts = incrementMonthCount(counts, asset.createDateTime);
      }
    }
    return counts;
  }

  Future<int> _readAssetSizeBytes(AssetEntity asset) async {
    try {
      final file = await asset.originFile;
      if (file == null) return 0;
      return file.length();
    } catch (_) {
      return 0;
    }
  }

  List<PhotoAsset> _samplePhotos(String batchId) {
    const sampleSizes = [2400000, 1900000, 3100000, 2700000, 2200000, 1600000];
    final month = parseMonthKey(batchId);
    final date = month != null ? DateTime(month.$1, month.$2) : DateTime.now();

    return List.generate(
      6,
      (i) => PhotoAsset(
        id: '$batchId-photo-$i',
        title: 'IMG_014${i + 2}',
        subtitle: photoCardSubtitle(date, sampleSizes[i]),
        monthKey: batchId,
        isVideo: i == 2,
        durationLabel: i == 2 ? '0:18' : null,
        gradientIndex: i,
        sizeBytes: sampleSizes[i],
      ),
    );
  }

  @override
  Future<Result<void>> deletePhotos(List<String> assetIds) async {
    if (assetIds.isEmpty) return const Success(null);

    final permission = await hasPermission();
    if (permission.valueOrNull == false) {
      return const Success(null);
    }

    try {
      final deleted = await PhotoManager.editor.deleteWithIds(assetIds);
      if (deleted.isEmpty) {
        return FailureResult(
          PhotosLoadFailure(message: 'Could not delete selected photos'),
        );
      }
      return const Success(null);
    } catch (e, st) {
      debugPrint('PhotosRepositoryImpl.deletePhotos: $e\n$st');
      return FailureResult(PhotosLoadFailure(message: '$e'));
    }
  }

  @override
  Future<Result<String?>> resolvePlayablePath(String assetId) async {
    try {
      final entity = await AssetEntity.fromId(assetId);
      if (entity == null || entity.type != AssetType.video) {
        return const Success(null);
      }
      final file = await entity.file;
      return Success(file?.path);
    } catch (e, st) {
      debugPrint('PhotosRepositoryImpl.resolvePlayablePath: $e\n$st');
      return FailureResult(PhotosLoadFailure(message: '$e'));
    }
  }
}

class _MonthPhotoIndex {
  AssetPathEntity? path;
  int monthTotalCount = 0;
  final List<AssetEntity> assets = [];
  bool exhaustedLibrary = false;
  int libraryPage = 0;
}
