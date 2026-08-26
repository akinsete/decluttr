import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/foundation.dart';

import '../../domain/entities/swipe_session_record.dart';

/// One Firestore write + one Analytics event per flushed swipe session.
abstract class SwipeStatsSync {
  Future<bool> uploadSession({
    required String userId,
    required SwipeSessionRecord session,
  });
}

class SwipeStatsFirestoreSync implements SwipeStatsSync {
  SwipeStatsFirestoreSync({
    FirebaseFirestore? firestore,
    FirebaseAnalytics? analytics,
  })  : _firestore = firestore ?? FirebaseFirestore.instance,
        _analytics = analytics ?? FirebaseAnalytics.instance;

  final FirebaseFirestore _firestore;
  final FirebaseAnalytics _analytics;

  @override
  Future<bool> uploadSession({
    required String userId,
    required SwipeSessionRecord session,
  }) async {
    try {
      final batch = _firestore.batch();

      final sessionRef = _firestore
          .collection('users')
          .doc(userId)
          .collection('swipe_sessions')
          .doc(session.sessionId);

      batch.set(sessionRef, {
        'batchId': session.batchId,
        'isPhotos': session.isPhotos,
        'keptCount': session.keptCount,
        'deletedCount': session.deletedCount,
        'deletedBytes': session.deletedBytes,
        'completed': session.completed,
        'startedAt': Timestamp.fromDate(session.startedAt),
        'endedAt': Timestamp.fromDate(session.endedAt),
      });

      final lifetimeRef =
          _firestore.collection('users').doc(userId).collection('stats').doc('lifetime');

      batch.set(
        lifetimeRef,
        {
          'totalKept': FieldValue.increment(session.keptCount),
          'totalDeleted': FieldValue.increment(session.deletedCount),
          'totalDeletedBytes': FieldValue.increment(session.deletedBytes),
          'sessionCount': FieldValue.increment(1),
          'updatedAt': FieldValue.serverTimestamp(),
        },
        SetOptions(merge: true),
      );

      await batch.commit();

      await _analytics.logEvent(
        name: 'swipe_session_flushed',
        parameters: {
          'kept_count': session.keptCount,
          'deleted_count': session.deletedCount,
          'deleted_bytes': session.deletedBytes,
          'is_photos': session.isPhotos ? 1 : 0,
          'batch_id': session.batchId,
          'completed': session.completed ? 1 : 0,
        },
      );

      return true;
    } catch (e, st) {
      debugPrint('SwipeStatsFirestoreSync.uploadSession: $e\n$st');
      return false;
    }
  }
}
