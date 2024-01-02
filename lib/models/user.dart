class User {
  final String? email;
  final String? name;
  // final String? photoUrl;
  int? age;
  String? gender;

  User({
    required this.email,
    required this.name,
    // required this.photoUrl,
    this.age,
    this.gender,
  });

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'name' : name,
      // 'photoUrl': photoUrl,
      'age': age,
      'gender': gender,
    };
  }
}
