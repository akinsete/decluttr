import 'dart:async';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/foundation.dart' show FlutterError, debugPrint;
import 'package:flutter/material.dart' show FontWeight;
import 'package:flutter/services.dart' show FontLoader, rootBundle;
import 'package:flutter_test/flutter_test.dart';
import 'package:google_fonts/google_fonts.dart';

Future<void> testExecutable(FutureOr<void> Function() testMain) async {
  TestWidgetsFlutterBinding.ensureInitialized();
  GoogleFonts.config.allowRuntimeFetching = false;

  final basedir = (goldenFileComparator as LocalFileComparator).basedir;
  goldenFileComparator = _ToleranceGoldenFileComparator(
    basedir.resolve('_config'),
    tolerance: 0.02,
  );

  await _loadTestFonts();
  await testMain();
}

class _ToleranceGoldenFileComparator extends LocalFileComparator {
  _ToleranceGoldenFileComparator(super.testFile, {required this.tolerance});

  final double tolerance;

  @override
  Future<bool> compare(Uint8List imageBytes, Uri golden) async {
    final result = await GoldenFileComparator.compareLists(
      imageBytes,
      await getGoldenBytes(golden),
    );
    if (result.passed) return true;
    if (result.diffPercent <= tolerance) return true;
    throw FlutterError(
      'Golden "$golden" failed with ${result.diffPercent}% pixel difference '
      '(tolerance: ${tolerance * 100}%).\n'
      '${result.error ?? ''}',
    );
  }
}

Future<void> _loadTestFonts() async {
  final loaders = <Future<void>>[];

  const phosphorFamilies = {
    'packages/phosphoricons_flutter/PhosphorRegular':
        'packages/phosphoricons_flutter/lib/fonts/Phosphor.ttf',
    'packages/phosphoricons_flutter/PhosphorFill':
        'packages/phosphoricons_flutter/lib/fonts/Phosphor-Fill.ttf',
    'packages/phosphoricons_flutter/PhosphorLight':
        'packages/phosphoricons_flutter/lib/fonts/Phosphor-Light.ttf',
    'packages/phosphoricons_flutter/PhosphorBold':
        'packages/phosphoricons_flutter/lib/fonts/Phosphor-Bold.ttf',
    'packages/phosphoricons_flutter/PhosphorThin':
        'packages/phosphoricons_flutter/lib/fonts/Phosphor-Thin.ttf',
    'packages/phosphoricons_flutter/PhosphorDuotone':
        'packages/phosphoricons_flutter/lib/fonts/Phosphor-Duotone.ttf',
  };

  for (final entry in phosphorFamilies.entries) {
    loaders.add(_tryLoadFontFromAsset(
      family: entry.key,
      assetPath: entry.value,
    ));
  }

  final flutterRoot = Platform.environment['FLUTTER_ROOT'];
  if (flutterRoot != null) {
    loaders.add(_tryLoadFontFromFile(
      family: 'MaterialIcons',
      filePath:
          '$flutterRoot/bin/cache/artifacts/material_fonts/MaterialIcons-Regular.otf',
    ));
  }

  await Future.wait(loaders);

  // Mirror AppText weights so golden snapshots match production typography.
  GoogleFonts.plusJakartaSansTextTheme();
  for (final weight in [
    FontWeight.w400,
    FontWeight.w500,
    FontWeight.w600,
    FontWeight.w700,
    FontWeight.w800,
  ]) {
    GoogleFonts.plusJakartaSans(fontWeight: weight);
  }
  await GoogleFonts.pendingFonts();
}

Future<void> _tryLoadFontFromAsset({
  required String family,
  required String assetPath,
}) async {
  try {
    final bytes = await rootBundle.load(assetPath);
    final loader = FontLoader(family)..addFont(Future.value(bytes));
    await loader.load();
    debugPrint('Loaded test font "$family" from asset: $assetPath');
  } catch (e) {
    debugPrint(
      'Unable to load test font "$family" from asset: $assetPath ($e)',
    );
  }
}

Future<void> _tryLoadFontFromFile({
  required String family,
  required String filePath,
}) async {
  try {
    final file = File(filePath);
    if (!file.existsSync()) {
      debugPrint('Test font file not found: $filePath');
      return;
    }
    final bytes = file.readAsBytesSync();
    final loader = FontLoader(family)
      ..addFont(Future.value(ByteData.view(bytes.buffer)));
    await loader.load();
    debugPrint('Loaded test font "$family" from file: $filePath');
  } catch (e) {
    debugPrint(
      'Unable to load test font "$family" from file: $filePath ($e)',
    );
  }
}
