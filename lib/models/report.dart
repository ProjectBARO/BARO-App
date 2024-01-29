class Report {
  int? id;
  DateTime? createdAt;
  int? alertCount;
  int? analysisTime;
  String? predict;
  String? type;
  String? score;
  String? normalRatio;
  String? neckAngles;
  String? distances;
  String? statusFrequencies;

  Report({
    this.id,
    this.createdAt,
    this.alertCount,
    this.analysisTime,
    this.predict,
    this.type,
    this.score,
    this.normalRatio,
    this.neckAngles,
    this.distances,
    this.statusFrequencies,
  });

  factory Report.fromJson(Map<String, dynamic> json) {
    return Report(
      id: json['id'] as int?,
      createdAt: json['created_at'] == null ? null : DateTime.parse(json['created_at'] as String),
      alertCount: json['alert_count'] as int?,
      analysisTime: json['analysis_time'] as int?,
      predict: json['predict'] as String?,
      type: json['type'] as String?,
      score: json['score'] as String?,
      normalRatio: json['normal_ratio'] as String?,
      neckAngles: json['neck_angles'] as String?,
      distances: json['distances'] as String?,
      statusFrequencies: json['status_frequencies'] as String?,
    );
  }
}
