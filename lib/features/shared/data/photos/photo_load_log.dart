import 'package:flutter/foundation.dart';

const _tag = 'PhotosLoad';

/// Debug-only timing logs for photo batch / swipe loading.
void photoLoadLog(String message) {
  debugPrint('[$_tag] $message');
}

class PhotoLoadTrace {
  PhotoLoadTrace(this.scope) : _sw = Stopwatch()..start();

  final String scope;
  final Stopwatch _sw;

  void step(String message) {
    photoLoadLog('$scope · $message (+${_sw.elapsedMilliseconds}ms)');
  }

  void finish(String message) {
    photoLoadLog('$scope · $message (total ${_sw.elapsedMilliseconds}ms)');
  }
}
