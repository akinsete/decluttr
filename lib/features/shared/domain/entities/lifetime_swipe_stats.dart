import 'swipe_session_record.dart';

class LifetimeSwipeStats {
  const LifetimeSwipeStats({
    this.totalKept = 0,
    this.totalDeleted = 0,
    this.totalDeletedBytes = 0,
    this.committedDeletedBytes = 0,
    this.photosKept = 0,
    this.photosDeleted = 0,
    this.contactsKept = 0,
    this.contactsDeleted = 0,
    this.sessionCount = 0,
  });

  final int totalKept;
  final int totalDeleted;
  final int totalDeletedBytes;
  final int committedDeletedBytes;
  final int photosKept;
  final int photosDeleted;
  final int contactsKept;
  final int contactsDeleted;
  final int sessionCount;

  Map<String, dynamic> toJson() => {
        'totalKept': totalKept,
        'totalDeleted': totalDeleted,
        'totalDeletedBytes': totalDeletedBytes,
        'committedDeletedBytes': committedDeletedBytes,
        'photosKept': photosKept,
        'photosDeleted': photosDeleted,
        'contactsKept': contactsKept,
        'contactsDeleted': contactsDeleted,
        'sessionCount': sessionCount,
      };

  factory LifetimeSwipeStats.fromJson(Map<String, dynamic> json) {
    return LifetimeSwipeStats(
      totalKept: json['totalKept'] as int? ?? 0,
      totalDeleted: json['totalDeleted'] as int? ?? 0,
      totalDeletedBytes: json['totalDeletedBytes'] as int? ?? 0,
      committedDeletedBytes: json['committedDeletedBytes'] as int? ?? 0,
      photosKept: json['photosKept'] as int? ?? 0,
      photosDeleted: json['photosDeleted'] as int? ?? 0,
      contactsKept: json['contactsKept'] as int? ?? 0,
      contactsDeleted: json['contactsDeleted'] as int? ?? 0,
      sessionCount: json['sessionCount'] as int? ?? 0,
    );
  }

  LifetimeSwipeStats applySession(SwipeSessionRecord session) {
    return LifetimeSwipeStats(
      totalKept: totalKept + session.keptCount,
      totalDeleted: totalDeleted + session.deletedCount,
      totalDeletedBytes: totalDeletedBytes + session.deletedBytes,
      committedDeletedBytes: committedDeletedBytes,
      photosKept: photosKept + (session.isPhotos ? session.keptCount : 0),
      photosDeleted: photosDeleted + (session.isPhotos ? session.deletedCount : 0),
      contactsKept: contactsKept + (session.isPhotos ? 0 : session.keptCount),
      contactsDeleted: contactsDeleted + (session.isPhotos ? 0 : session.deletedCount),
      sessionCount: sessionCount + 1,
    );
  }

  LifetimeSwipeStats addCommittedDeletedBytes(int bytes) {
    return LifetimeSwipeStats(
      totalKept: totalKept,
      totalDeleted: totalDeleted,
      totalDeletedBytes: totalDeletedBytes,
      committedDeletedBytes: committedDeletedBytes + bytes,
      photosKept: photosKept,
      photosDeleted: photosDeleted,
      contactsKept: contactsKept,
      contactsDeleted: contactsDeleted,
      sessionCount: sessionCount,
    );
  }
}
