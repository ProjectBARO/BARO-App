class User {
  final String? email;
  final String? name;
  // final String? photoUrl;
  final int? birthday;
  final String? gender;

  User({
    required this.email,
    required this.name,
    // required this.photoUrl,
    required this.birthday,
    required this.gender
  });

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'name' : name,
      // 'photoUrl': photoUrl,
      'birthday': birthday,
      'gender': gender,
    };
  }
}
