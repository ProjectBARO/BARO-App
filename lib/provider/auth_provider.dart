import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/user.dart';
import '../service/auth_service.dart';

final authProvider = Provider<AuthService>((ref) => AuthService());

class UserState extends StateNotifier<User?> {
  UserState() : super(null);

  User? get currentUser => state;

  void setUser(User? user) {
    state = user;
  }
}

final userProvider = StateNotifierProvider<UserState, User?>((ref) => UserState());
