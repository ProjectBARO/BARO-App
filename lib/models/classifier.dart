class Classifier {
  bool isTurtle;
  int alertCount;

  Classifier({this.isTurtle = false, this.alertCount = 0});

  Classifier copyWith({bool? isTurtle, int? alertCount}) {
    return Classifier(
      isTurtle: isTurtle ?? this.isTurtle,
      alertCount: alertCount ?? this.alertCount,
    );
  }
}