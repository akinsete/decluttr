import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../features/shared/data/photos/photo_thumbnail_provider.dart';
import '../theme/theme.dart';

/// Full-bleed photo thumbnail with gradient fallback for swipe cards.
class PhotoAssetThumbnail extends ConsumerWidget {
  const PhotoAssetThumbnail({
    super.key,
    required this.assetId,
    required this.fallbackGradient,
    this.thumbnailSize = 400,
  });

  final String assetId;
  final Gradient fallbackGradient;
  final int thumbnailSize;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final dt = context.decluttrTheme;
    final thumbnailAsync = ref.watch(
      photoThumbnailProvider((assetId: assetId, size: thumbnailSize)),
    );

    return thumbnailAsync.when(
      loading: () => _GradientFill(gradient: fallbackGradient),
      error: (_, __) => _GradientFill(gradient: fallbackGradient),
      data: (bytes) {
        if (bytes == null) {
          return _GradientFill(gradient: fallbackGradient);
        }

        return Stack(
          fit: StackFit.expand,
          children: [
            Image.memory(
              bytes,
              fit: BoxFit.cover,
              gaplessPlayback: true,
            ),
            DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    dt.ink.withValues(alpha: 0),
                    dt.ink.withValues(alpha: 0.28),
                  ],
                  stops: const [0.46, 1],
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}

class _GradientFill extends StatelessWidget {
  const _GradientFill({required this.gradient});

  final Gradient gradient;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(gradient: gradient),
    );
  }
}
