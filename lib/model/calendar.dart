class Calendar {
  int? id;
  DateTime? createdAt;

  Calendar({
    this.id,
    this.createdAt,
  });

  factory Calendar.fromJson(Map<String, dynamic> json) {
    DateTime? dateTime = json['created_at'] == null ? null : DateTime.parse(json['created_at'] as String).toLocal();
    DateTime? simpleDate = dateTime == null
        ? null
        : DateTime(dateTime.year, dateTime.month, dateTime.day);
    return Calendar(
      id: json['id'] as int?,
      createdAt: simpleDate,
    );
  }
}
