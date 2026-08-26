class SwipeSessionRecord {
  const SwipeSessionRecord({
    required this.sessionId,
    required this.batchId,
    required this.isPhotos,
    required this.keptCount,
    required this.deletedCount,
    required this.deletedBytes,
    required this.completed,
    required this.startedAt,
    required this.endedAt,
  });

  final String sessionId;
  final String batchId;
  final bool isPhotos;
  final int keptCount;
  final int deletedCount;
  final int deletedBytes;
  final bool completed;
  final DateTime startedAt;
  final DateTime endedAt;

  Map<String, dynamic> toJson() => {
        'sessionId': sessionId,
        'batchId': batchId,
        'isPhotos': isPhotos,
        'keptCount': keptCount,
        'deletedCount': deletedCount,
        'deletedBytes': deletedBytes,
        'completed': completed,
        'startedAt': startedAt.toIso8601String(),
        'endedAt': endedAt.toIso8601String(),
      };

  factory SwipeSessionRecord.fromJson(Map<String, dynamic> json) {
    return SwipeSessionRecord(
      sessionId: json['sessionId'] as String,
      batchId: json['batchId'] as String,
      isPhotos: json['isPhotos'] as bool? ?? true,
      keptCount: json['keptCount'] as int? ?? 0,
      deletedCount: json['deletedCount'] as int? ?? 0,
      deletedBytes: json['deletedBytes'] as int? ?? 0,
      completed: json['completed'] as bool? ?? false,
      startedAt: DateTime.parse(json['startedAt'] as String),
      endedAt: DateTime.parse(json['endedAt'] as String),
    );
  }
}
