class Calendar {
  int? id;
  DateTime? createdAt;

  Calendar({
    this.id,
    this.createdAt,
  });

  factory Calendar.fromJson(Map<String, dynamic> json) {
    return Calendar(
      id: json['id'] as int?,
      createdAt: json['created_at'] == null ? null : DateTime.parse(json['created_at'] as String)
    );
  }
}
