import 'package:flutter/material.dart';

import '../../../core/testing/widget_keys.dart';
import '../../../core/theme/theme.dart';
import '../../../core/widgets/photo_asset_thumbnail.dart';
import '../../shared/domain/entities/swipe_item.dart';

/// Horizontal preview of the next swipe items, shown under the active card.
class SwipeUpcomingStrip extends StatelessWidget {
  const SwipeUpcomingStrip({
    super.key,
    required this.items,
    required this.isPhotos,
  });

  final List<SwipeItem> items;
  final bool isPhotos;

  static const thumbSize = 160;

  @override
  Widget build(BuildContext context) {
    if (items.isEmpty) return const SizedBox.shrink();

    final dt = context.decluttrTheme;
    final size = dt.x11;

    return SizedBox(
      key: WidgetKeys.swipeUpcomingStrip,
      height: size,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: items.length,
        separatorBuilder: (_, __) => SizedBox(width: dt.x2),
        itemBuilder: (context, index) {
          final item = items[index];
          return ClipRRect(
            borderRadius: BorderRadius.circular(dt.radiusXs),
            child: SizedBox(
              width: size,
              height: size,
              child: isPhotos
                  ? PhotoAssetThumbnail(
                      assetId: item.id,
                      fallbackGradient: dt.batchPickerGradientAt(item.gradientIndex),
                      thumbnailSize: thumbSize,
                    )
                  : _ContactTile(item: item),
            ),
          );
        },
      ),
    );
  }
}

class _ContactTile extends StatelessWidget {
  const _ContactTile({required this.item});

  final SwipeItem item;

  @override
  Widget build(BuildContext context) {
    final dt = context.decluttrTheme;
    final initial = item.title.trim().isEmpty ? '?' : item.title.trim()[0].toUpperCase();

    return DecoratedBox(
      decoration: BoxDecoration(gradient: dt.batchPickerGradientAt(item.gradientIndex)),
      child: Center(
        child: Text(
          initial,
          style: context.decluttrTypography.statusPill.copyWith(color: dt.white),
        ),
      ),
    );
  }
}
