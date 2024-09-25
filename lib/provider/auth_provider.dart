import 'dart:convert';
import 'dart:developer';
import 'package:baro_project/service/user/user.pbgrpc.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:grpc/grpc.dart';
import 'package:http/http.dart' as http;
import '../models/user.dart' as user_model;

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

  Future<user_model.User?> getUserFromGoogle() async {
    final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
    if (googleUser == null) return null;

    final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
    final response = await http.get(
      Uri.parse('https://people.googleapis.com/v1/people/me?personFields=names,birthdays,genders,emailAddresses'),
      headers: {'Authorization': 'Bearer ${googleAuth.accessToken}'}
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final String name = data['names'][0]['displayName'];
      final String email = data['emailAddresses'][0]['value'];
      final String gender = data['genders'][0]['value'];
      final int birthday = data['birthdays'][0]['date']['year'];
      final int age = DateTime.now().year - birthday + 1;

      return user_model.User(email: email, name: name, age: age, gender: gender);
    } else {
      throw Exception('Failed to sign in with google');
    }
  }

  Future<void> signOut() async {
    await _googleSignIn.signOut();
    await storage.deleteAll();
  }

  Future<String> getToken(user_model.User user) async {
    String? fcmToken = await FirebaseMessaging.instance.getToken();

    final channel = ClientChannel(dotenv.get('PROTO_URL'));
    final stub = UserServiceClient(channel);

    try {
      final request = RequestCreateUser(
        name: user.name,
        fcmToken: fcmToken ?? '',
        email: user.email,
        age: user.age ?? 0,
        gender: user.gender ?? '',
      );
      final response = await stub.login(request);
      log(response.toString());
      return response.token;
    } catch (e) {
      throw Exception('Failed to obtain token: $e');
    } finally {
      await channel.shutdown();
    }
  }

  Future<user_model.User> getUserInfo(String accessToken) async {
    final channel = ClientChannel(dotenv.get('PROTO_URL'));
    final stub = UserServiceClient(channel);

    try {
      final response = await stub.getUserInfo(
        Empty(),
        options: CallOptions(
          metadata: {
          'authorization': 'Bearer $accessToken'
        })
      );
      final user = user_model.User.fromproto(response);
      return user;
    } catch (e) {
      throw Exception('Failed to obtain user info: $e');
    } finally {
      await channel.shutdown();
    }
  }

  Future<void> updateUserInfo(user_model.User user) async {
    final channel = ClientChannel(dotenv.get('PROTO_URL'));
    final stub = UserServiceClient(channel);
    String? accessToken = await storage.read(key: 'accessToken');

    try {
      await stub.updateUserInfo(
        RequestUpdateUser(nickname: user.nickname, age: user.age, gender: user.gender),
        options: CallOptions(
          metadata: {
          'authorization': 'Bearer $accessToken'
        })  
      );
    } catch (e) {
      throw Exception('Failed to update user info: $e');
    } finally {
      await channel.shutdown();
    }
  }

  Future<void> deleteUserInfo() async {
    final channel = ClientChannel(dotenv.get('PROTO_URL'));
    final stub = UserServiceClient(channel);
    String? accessToken = await storage.read(key: 'accessToken');

    try {
      await stub.deleteUser(
        Empty(),
        options: CallOptions(
          metadata: {
          'authorization': 'Bearer $accessToken'
        })  
      );
      await signOut();
    } catch (e) {
      throw Exception('Failed to delete user info: $e');
    } finally {
      await channel.shutdown();
    }
  }

  Future<void> storeToken(String accessToken) async {
    await storage.write(key: 'accessToken', value: accessToken);
  }
}
