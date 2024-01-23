class Video {
  String videoUrl;
  int alertCount;
  int analysisTime;
  String type;

  Video({
    required this.videoUrl,
    required this.alertCount,
    required this.analysisTime,
    required this.type,
  });

  Video copyWith({
    String? videoUrl,
    int? alertCount,
    int? analysisTime,
    String? type,
  }) {
    return Video(
      videoUrl: videoUrl ?? this.videoUrl,
      alertCount: alertCount ?? this.alertCount,
      analysisTime: analysisTime ?? this.analysisTime,
      type: type ?? this.type,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'alert_count': alertCount,
      'analysis_time': analysisTime,
      'type': type,
      'video_url': videoUrl,
    };
  }
}