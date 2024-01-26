class Report {
  int? id;
  DateTime? createdAt;
  int? alertCount;
  int? analysisTime;
  String? predict;
  String? type;

  Report({
    this.id,
    this.createdAt,
    this.alertCount,
    this.analysisTime,
    this.predict,
    this.type,
  });

  factory Report.fromJson(Map<String, dynamic> json) {
    return Report(
      id: json['id'] as int?,
      createdAt: json['created_at'] == null ? null : DateTime.parse(json['created_at'] as String),
      alertCount: json['alert_count'] as int?,
      analysisTime: json['analysis_time'] as int?,
      predict: json['predict'] as String?,
      type: json['type'] as String?,
    );
  }
}
