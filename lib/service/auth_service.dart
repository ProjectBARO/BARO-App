import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;
import '../models/user.dart';

class AuthService {
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final storage = const FlutterSecureStorage();

  Future<User?> signInWithGoogle() async {
    final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
    if (googleUser == null) return null;

    return User(
      email: googleUser.email,
      name: googleUser.displayName,
      // photoUrl: googleUser.photoUrl,
    );
  }

  Future<void> signOut() async {
    await _googleSignIn.signOut();
    storage.deleteAll();
  }

  void updateUserGenderAndAge(User user, String gender, int age) {
    user.gender = gender;
    user.age = age;
  }

  Future<String> getToken(User user) async {
    final response = await http.post(
      Uri.parse('https://baro-igst5ktwja-uc.a.run.app/login'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(
          <String, dynamic>{'name': user.name!, 'email': user.email!, 'age': user.age!, 'gender': user.gender!}),
    );

    if (response.statusCode == 201) {
      return jsonDecode(response.body)['token'];
    } else {
      print(response.statusCode);
      throw Exception('Failed to obtain token.');
    }
  }

  Future<void> storeToken(String accessToken, String refreshToken) async {
    await storage.write(key: 'accessToken', value: accessToken);
    await storage.write(key: 'refreshToken', value: refreshToken);
  }
}
