import 'dart:async';

import 'package:decluttr/core/testing/widget_keys.dart';
import 'package:decluttr/features/batch/batch_photos/batch_photos_notifier.dart';
import 'package:decluttr/features/batch/batch_photos/batch_photos_page.dart';
import 'package:decluttr/features/shared/domain/entities/batch_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../helpers/test_app.dart';

final _loadingBatchPhotosCompleter = Completer<List<BatchItem>>();

void main() {
  testWidgets('batch photos shows shimmer while loading', (tester) async {
    final prefs = await initTestPrefs();
    await tester.pumpWidget(
      buildTestApp(
        prefs: prefs,
        overrides: [
          batchPhotosProvider.overrideWith(_LoadingBatchPhotos.new),
        ],
        child: const BatchPhotosPage(),
      ),
    );
    await tester.pump();

    expect(find.byKey(WidgetKeys.batchPhotosLoadingShimmer), findsOneWidget);
    expect(find.byType(CircularProgressIndicator), findsNothing);
  });
}

class _LoadingBatchPhotos extends BatchPhotosNotifier {
  @override
  Future<List<BatchItem>> build() => _loadingBatchPhotosCompleter.future;
}
