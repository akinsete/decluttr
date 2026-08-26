import 'dart:io';

import 'package:flutter/material.dart';
import 'package:phosphoricons_flutter/phosphoricons_flutter.dart';
import 'package:video_player/video_player.dart';

import '../testing/widget_keys.dart';
import '../theme/theme.dart';

/// Full-screen dialog that plays a local video file.
class PhotoAssetVideoPlayerDialog extends StatefulWidget {
  const PhotoAssetVideoPlayerDialog({
    super.key,
    required this.filePath,
  });

  final String filePath;

  @override
  State<PhotoAssetVideoPlayerDialog> createState() =>
      _PhotoAssetVideoPlayerDialogState();
}

class _PhotoAssetVideoPlayerDialogState
    extends State<PhotoAssetVideoPlayerDialog> {
  late final VideoPlayerController _controller;
  late final Future<void> _init;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.file(File(widget.filePath));
    _init = _controller.initialize().then((_) {
      if (!mounted) return;
      _controller
        ..setLooping(true)
        ..play();
      setState(() {});
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final dt = context.decluttrTheme;

    return Dialog.fullscreen(
      backgroundColor: dt.ink,
      child: SafeArea(
        child: Stack(
          fit: StackFit.expand,
          children: [
            FutureBuilder<void>(
              future: _init,
              builder: (context, snapshot) {
                if (snapshot.connectionState != ConnectionState.done ||
                    !_controller.value.isInitialized) {
                  return Center(
                    child: CircularProgressIndicator(color: dt.white),
                  );
                }

                return GestureDetector(
                  onTap: () {
                    if (_controller.value.isPlaying) {
                      _controller.pause();
                    } else {
                      _controller.play();
                    }
                    setState(() {});
                  },
                  child: Center(
                    child: AspectRatio(
                      aspectRatio: _controller.value.aspectRatio > 0
                          ? _controller.value.aspectRatio
                          : 1,
                      child: VideoPlayer(_controller),
                    ),
                  ),
                );
              },
            ),
            Positioned(
              top: dt.x3,
              right: dt.x3,
              child: Material(
                color: dt.ink.withValues(alpha: 0.4),
                shape: const CircleBorder(),
                child: IconButton(
                  key: WidgetKeys.swipeVideoPlayerClose,
                  onPressed: () => Navigator.of(context).pop(),
                  icon: Icon(
                    PhosphorIconsRegular.x,
                    color: dt.white,
                    size: dt.x5,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
