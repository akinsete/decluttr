import 'dart:typed_data';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'photo_thumbnail_loader.dart';

/// Cache key for [photoThumbnailProvider] — size affects decode cost on device.
typedef PhotoThumbnailRequest = ({String assetId, int size});

final photoThumbnailLoaderProvider = Provider<PhotoThumbnailLoader>(
  (ref) => const PhotoThumbnailLoader(),
);

final photoThumbnailProvider =
    FutureProvider.autoDispose.family<Uint8List?, PhotoThumbnailRequest>(
  (ref, request) =>
      ref.watch(photoThumbnailLoaderProvider).load(request.assetId, size: request.size),
);
