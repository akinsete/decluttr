import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../../domain/entities/insights_snapshot.dart';
import '../../domain/entities/lifetime_swipe_stats.dart';
import '../../domain/entities/swipe_session_record.dart';
import '../../domain/repositories/auth_repository.dart';
import '../../domain/repositories/swipe_stats_repository.dart';
import '../firebase/swipe_stats_firestore_sync.dart';

class SwipeStatsRepositoryImpl implements SwipeStatsRepository {
  SwipeStatsRepositoryImpl({
    required SharedPreferences prefs,
    required AuthRepository authRepository,
    SwipeStatsSync? firestoreSync,
  })  : _prefs = prefs,
        _authRepository = authRepository,
        _firestoreSync = firestoreSync ?? SwipeStatsFirestoreSync();

  static const _lifetimeKey = 'swipe_stats_lifetime';
  static const _pendingKey = 'swipe_stats_pending_sync';
  static const _sessionsKey = 'swipe_stats_sessions_v1';
  static const _maxSessions = 200;
  static const _sessionRetentionDays = 90;

  final SharedPreferences _prefs;
  final AuthRepository _authRepository;
  final SwipeStatsSync _firestoreSync;

  @override
  Future<LifetimeSwipeStats> getLifetimeStats() async {
    final raw = _prefs.getString(_lifetimeKey);
    if (raw == null) return const LifetimeSwipeStats();
    return LifetimeSwipeStats.fromJson(
      jsonDecode(raw) as Map<String, dynamic>,
    );
  }

  @override
  Future<InsightsSnapshot> getInsightsSnapshot() async {
    final lifetime = await getLifetimeStats();
    final sessions = await _readSessions();
    return InsightsSnapshot(
      totalKept: lifetime.totalKept,
      totalDeleted: lifetime.totalDeleted,
      committedDeletedBytes: lifetime.committedDeletedBytes,
      photosDeleted: lifetime.photosDeleted,
      contactsDeleted: lifetime.contactsDeleted,
      weekCleanedCounts: _weekCleanedCounts(sessions, DateTime.now()),
    );
  }

  @override
  Future<void> recordSession(SwipeSessionRecord session) async {
    final lifetime = (await getLifetimeStats()).applySession(session);
    await _prefs.setString(_lifetimeKey, jsonEncode(lifetime.toJson()));
    await _appendSession(session);

    final uploaded = await _tryUpload(session);
    if (!uploaded) {
      await _enqueuePending(session);
    }
  }

  @override
  Future<void> recordCommittedDeletedBytes(int bytes) async {
    if (bytes <= 0) return;
    final lifetime = (await getLifetimeStats()).addCommittedDeletedBytes(bytes);
    await _prefs.setString(_lifetimeKey, jsonEncode(lifetime.toJson()));
  }

  @override
  Future<void> syncPendingSessions() async {
    final pending = await _readPending();
    if (pending.isEmpty) return;

    final remaining = <SwipeSessionRecord>[];
    for (final session in pending) {
      final uploaded = await _tryUpload(session);
      if (!uploaded) {
        remaining.add(session);
      }
    }
    await _writePending(remaining);
  }

  Future<void> _appendSession(SwipeSessionRecord session) async {
    final sessions = await _readSessions();
    sessions.add(session);
    final cutoff = DateTime.now().subtract(const Duration(days: _sessionRetentionDays));
    final trimmed = sessions
        .where((s) => !s.endedAt.isBefore(cutoff))
        .toList();
    while (trimmed.length > _maxSessions) {
      trimmed.removeAt(0);
    }
    await _writeSessions(trimmed);
  }

  Future<List<SwipeSessionRecord>> _readSessions() async {
    final raw = _prefs.getString(_sessionsKey);
    if (raw == null) return [];
    final list = jsonDecode(raw) as List<dynamic>;
    return list
        .map((e) => SwipeSessionRecord.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  Future<void> _writeSessions(List<SwipeSessionRecord> sessions) async {
    if (sessions.isEmpty) {
      await _prefs.remove(_sessionsKey);
      return;
    }
    await _prefs.setString(
      _sessionsKey,
      jsonEncode(sessions.map((s) => s.toJson()).toList()),
    );
  }

  List<int> _weekCleanedCounts(List<SwipeSessionRecord> sessions, DateTime now) {
    final monday = _mondayOfWeek(now);
    final counts = List<int>.filled(7, 0);
    for (final session in sessions) {
      final ended = session.endedAt;
      final day = DateTime(ended.year, ended.month, ended.day);
      final index = day.difference(monday).inDays;
      if (index >= 0 && index < 7) {
        counts[index] += session.keptCount + session.deletedCount;
      }
    }
    return counts;
  }

  DateTime _mondayOfWeek(DateTime date) {
    final normalized = DateTime(date.year, date.month, date.day);
    return normalized.subtract(Duration(days: normalized.weekday - DateTime.monday));
  }

  Future<bool> _tryUpload(SwipeSessionRecord session) async {
    final userId = _authRepository.currentUserId;
    if (userId == null) return false;

    return _firestoreSync.uploadSession(userId: userId, session: session);
  }

  Future<void> _enqueuePending(SwipeSessionRecord session) async {
    final pending = await _readPending();
    pending.add(session);
    await _writePending(pending);
  }

  Future<List<SwipeSessionRecord>> _readPending() async {
    final raw = _prefs.getString(_pendingKey);
    if (raw == null) return [];
    final list = jsonDecode(raw) as List<dynamic>;
    return list
        .map((e) => SwipeSessionRecord.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  Future<void> _writePending(List<SwipeSessionRecord> sessions) async {
    if (sessions.isEmpty) {
      await _prefs.remove(_pendingKey);
      return;
    }
    await _prefs.setString(
      _pendingKey,
      jsonEncode(sessions.map((s) => s.toJson()).toList()),
    );
  }
}
