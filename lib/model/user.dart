import '../service/proto/user/user.pb.dart';

class User {
  final String? email;
  final String? name;
  final String? nickname;
  final int? age;
  final String? gender;

  User({required this.email, required this.name, this.nickname, required this.age, required this.gender});

  static User fromproto(ResponseUser response) {
    return User(
      email: response.email,
      name: response.name,
      nickname: response.nickname,
      age: response.age,
      gender: response.gender
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
