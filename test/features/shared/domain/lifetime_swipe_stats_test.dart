import 'package:decluttr/features/shared/domain/entities/lifetime_swipe_stats.dart';
import 'package:decluttr/features/shared/domain/entities/swipe_session_record.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('applySession tracks photo and contact splits', () {
    const stats = LifetimeSwipeStats();

    final updated = stats
        .applySession(
          SwipeSessionRecord(
            sessionId: 'p1',
            batchId: '2026-07',
            isPhotos: true,
            keptCount: 2,
            deletedCount: 3,
            deletedBytes: 1000,
            completed: true,
            startedAt: _t,
            endedAt: _t,
          ),
        )
        .applySession(
          SwipeSessionRecord(
            sessionId: 'c1',
            batchId: 'dup',
            isPhotos: false,
            keptCount: 1,
            deletedCount: 4,
            deletedBytes: 0,
            completed: true,
            startedAt: _t,
            endedAt: _t,
          ),
        );

    expect(updated.totalKept, 3);
    expect(updated.totalDeleted, 7);
    expect(updated.photosKept, 2);
    expect(updated.photosDeleted, 3);
    expect(updated.contactsKept, 1);
    expect(updated.contactsDeleted, 4);
  });

  test('addCommittedDeletedBytes accumulates committed storage', () {
    const stats = LifetimeSwipeStats(committedDeletedBytes: 100);

    expect(stats.addCommittedDeletedBytes(240).committedDeletedBytes, 340);
  });
}

final _t = DateTime(2026, 7, 4);
