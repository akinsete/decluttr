import 'photo_asset.dart';

/// One page of photos for a month batch (swipe session pagination).
class PhotoBatchPage {
  const PhotoBatchPage({
    required this.items,
    required this.totalCount,
    required this.hasMore,
  });

  final List<PhotoAsset> items;
  final int totalCount;
  final bool hasMore;
}
