class Percentage {
  int? userId;
  String? nickname;
  String? gender;
  int? age;
  String? normalRatio;
  String? myScore;
  String? averageScore;

  Percentage({this.userId, this.nickname, this.gender, this.age, this.normalRatio, this.myScore, this.averageScore});

  factory Percentage.fromJson(Map<String, dynamic> json) {
    return Percentage(
      userId: json['data']['user_id'],
      nickname: json['data']['nickname'],
      gender: json['data']['gender'],
      age: json['data']['age'],
      normalRatio: json['data']['normal_ratio'],
      myScore: json['data']['average_score'],
      averageScore: json['data']['all_average_score']
    );
  }
}
