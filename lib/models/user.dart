class User {
  final String? email;
  final String? name;
  final String? nickname;
  final int? age;
  final String? gender;

  User({required this.email, required this.name, this.nickname, required this.age, required this.gender});

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'name': name,
      'nickname': nickname,
      'age': age,
      'gender': gender,
    };
  }

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      email: json['email'] as String?,
      name: json['name'] as String?,
      nickname: json['nickname'] as String?,
      age: json['age'] as int?,
      gender: json['gender'] as String?,
    );
  }

  User copyWith({String? email, String? name, String? nickname, int? age, String? gender}) {
    return User(
      email: email ?? this.email,
      name: name ?? this.name,
      nickname: nickname ?? this.nickname,
      age: age ?? this.age,
      gender: gender ?? this.gender,
    );
  }
}
