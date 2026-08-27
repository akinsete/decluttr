import 'package:decluttr/features/shared/data/repositories/swipe_stats_repository_impl.dart';
import 'package:decluttr/features/shared/domain/entities/swipe_session_record.dart';
import 'package:decluttr/features/shared/domain/repositories/auth_repository.dart';
import 'package:decluttr/features/shared/data/firebase/swipe_stats_firestore_sync.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

class _FakeAuthRepository implements AuthRepository {
  @override
  String? get currentUserId => null;

  @override
  bool get isAnonymous => true;

  @override
  Future<String?> ensureAnonymousUser() async => 'anon-user';

  @override
  Future<void> linkWithEmail({required String email, required String password}) async {}
}

class _FakeFirestoreSync implements SwipeStatsSync {
  @override
  Future<bool> uploadSession({
    required String userId,
    required SwipeSessionRecord session,
  }) async =>
      false;
}

void main() {
  test('recordSession updates lifetime totals locally', () async {
    SharedPreferences.setMockInitialValues({});
    final prefs = await SharedPreferences.getInstance();
    final repo = SwipeStatsRepositoryImpl(
      prefs: prefs,
      authRepository: _FakeAuthRepository(),
      firestoreSync: _FakeFirestoreSync(),
    );

    final session = SwipeSessionRecord(
      sessionId: 's1',
      batchId: '2026-07',
      isPhotos: true,
      keptCount: 3,
      deletedCount: 2,
      deletedBytes: 4800000,
      completed: true,
      startedAt: DateTime(2026, 7, 4),
      endedAt: DateTime(2026, 7, 4, 1),
    );

    await repo.recordSession(session);

    final lifetime = await repo.getLifetimeStats();
    expect(lifetime.totalKept, 3);
    expect(lifetime.totalDeleted, 2);
    expect(lifetime.totalDeletedBytes, 4800000);
    expect(lifetime.sessionCount, 1);
  });

  test('recordSession persists history for weekly insights', () async {
    SharedPreferences.setMockInitialValues({});
    final prefs = await SharedPreferences.getInstance();
    // Pin "today" so week buckets are stable across time zones and CI dates.
    final anchor = DateTime(2026, 8, 26, 12);
    final monday = DateTime(2026, 8, 24);
    final repo = SwipeStatsRepositoryImpl(
      prefs: prefs,
      authRepository: _FakeAuthRepository(),
      firestoreSync: _FakeFirestoreSync(),
      clock: () => anchor,
    );

    await repo.recordSession(
      SwipeSessionRecord(
        sessionId: 's-week',
        batchId: '2026-08',
        isPhotos: true,
        keptCount: 10,
        deletedCount: 5,
        deletedBytes: 1000,
        completed: true,
        startedAt: monday,
        endedAt: monday,
      ),
    );

    final snapshot = await repo.getInsightsSnapshot();
    expect(snapshot.weekCleanedCounts[0], 15);
    expect(snapshot.photosDeleted, 5);
  });

  test('recordCommittedDeletedBytes updates lifetime committed storage', () async {
    SharedPreferences.setMockInitialValues({});
    final prefs = await SharedPreferences.getInstance();
    final repo = SwipeStatsRepositoryImpl(
      prefs: prefs,
      authRepository: _FakeAuthRepository(),
      firestoreSync: _FakeFirestoreSync(),
    );

    await repo.recordCommittedDeletedBytes(240000000);

    final snapshot = await repo.getInsightsSnapshot();
    expect(snapshot.committedDeletedBytes, 240000000);
  });

  test('recordSession enqueues pending when upload fails', () async {
    SharedPreferences.setMockInitialValues({});
    final prefs = await SharedPreferences.getInstance();
    final auth = _FakeAuthRepositoryWithUser();
    final repo = SwipeStatsRepositoryImpl(
      prefs: prefs,
      authRepository: auth,
      firestoreSync: _FakeFirestoreSync(),
    );

    final session = SwipeSessionRecord(
      sessionId: 's2',
      batchId: '2026-07',
      isPhotos: true,
      keptCount: 1,
      deletedCount: 0,
      deletedBytes: 0,
      completed: false,
      startedAt: DateTime(2026, 7, 4),
      endedAt: DateTime(2026, 7, 4, 1),
    );

    await repo.recordSession(session);
    await repo.syncPendingSessions();

    final lifetime = await repo.getLifetimeStats();
    expect(lifetime.sessionCount, 1);
  });
}

class _FakeAuthRepositoryWithUser implements AuthRepository {
  @override
  String? get currentUserId => 'user-1';

  @override
  bool get isAnonymous => true;

  @override
  Future<String?> ensureAnonymousUser() async => 'user-1';

  @override
  Future<void> linkWithEmail({required String email, required String password}) async {}
}
