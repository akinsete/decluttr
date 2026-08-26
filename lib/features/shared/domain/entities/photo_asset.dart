class PhotoAsset {
  const PhotoAsset({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.monthKey,
    this.isVideo = false,
    this.durationLabel,
    this.gradientIndex = 0,
    this.sizeBytes = 0,
  });

  final String id;
  final String title;
  final String subtitle;
  final String monthKey;
  final bool isVideo;
  final String? durationLabel;
  final int gradientIndex;
  final int sizeBytes;
}
