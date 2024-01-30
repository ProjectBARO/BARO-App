class User {
  final String? email;
  final String? name;
  final String? nickname;
  final int? birthday;
  final String? gender;

  User({required this.email, required this.name, this.nickname, required this.birthday, required this.gender});

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'name': name,
      'nickname': nickname,
      'birthday': birthday,
      'gender': gender,
    };
  }

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      email: json['email'] as String?,
      name: json['name'] as String?,
      nickname: json['nickname'] as String?,
      birthday: json['birthday'] as int?,
      gender: json['gender'] as String?,
    );
  }

  User copyWith({String? email, String? name, String? nickname, int? birthday, String? gender}) {
    return User(
      email: email ?? this.email,
      name: name ?? this.name,
      nickname: nickname ?? this.nickname,
      birthday: birthday ?? this.birthday,
      gender: gender ?? this.gender,
    );
  }
}
