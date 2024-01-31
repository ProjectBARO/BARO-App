import 'dart:convert';
import 'dart:developer';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;
import '../models/user.dart';

final authProvider = Provider<AuthService>((ref) => AuthService());

class AuthService {
  final GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: [
      'email',
      'profile',
      'https://www.googleapis.com/auth/user.birthday.read',
      'https://www.googleapis.com/auth/user.gender.read'
    ],
  );
  final storage = const FlutterSecureStorage();

  Future<User?> signInWithGoogle() async {
    final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
    if (googleUser == null) return null;

    final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
    final response = await http.get(
        Uri.parse('https://people.googleapis.com/v1/people/me?personFields=names,birthdays,genders,emailAddresses'),
        headers: {'Authorization': 'Bearer ${googleAuth.accessToken}'});

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final String name = data['names'][0]['displayName'];
      final String email = data['emailAddresses'][0]['value'];
      final String gender = data['genders'][0]['value'];
      final int birthday = data['birthdays'][0]['date']['year'];

      return User(email: email, name: name, birthday: birthday, gender: gender);
    } else {
      throw Exception('Failed to sign in with google');
    }
  }

  Future<void> signOut() async {
    await _googleSignIn.signOut();
    storage.deleteAll();
  }

  Future<String> getToken(User user) async {
    String? fcmToken = await FirebaseMessaging.instance.getToken();
    log(fcmToken!);
    final response = await http.post(
      Uri.parse('${dotenv.get('SERVER_URL')}/login'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        'age': user.birthday,
        'email': user.email,
        'gender': user.gender,
        'name': user.name,
        'fcm_token': fcmToken
      }),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body)['data']['token'];
    } else {
      throw Exception('Failed to obtain token.');
    }
  }

  Future<User?> getUserInfo(String accessToken) async {
    final response = await http.get(
      Uri.parse('${dotenv.get('SERVER_URL')}/users/me'),
      headers: {'Authorization': 'Bearer $accessToken'},
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body)['data'];
      return User.fromJson(data);
    } else {
      throw Exception('Failed to obtain user info.');
    }
  }

  Future<void> storeToken(String accessToken) async {
    await storage.write(key: 'accessToken', value: accessToken);
  }
}
