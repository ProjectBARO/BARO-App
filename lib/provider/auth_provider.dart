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

  void updateUser(int age, String gender) {
    if (state != null) {
      state = User(
        email: state!.email,
        name: state!.name,
        age: age,
        gender: gender,
      );
    }
  }

  void printUser() {
    print(state!.email);
    print(state!.name);
    print(state!.age);
    print(state!.gender);
  }
}

final userProvider = StateNotifierProvider<UserState, User?>((ref) => UserState());
