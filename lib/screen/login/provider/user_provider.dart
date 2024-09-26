import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../model/user.dart';

class UserState extends StateNotifier<User?> {
  UserState() : super(null);

  User? get currentUser => state;

  void setUser(User? user) {
    state = user;
  }
}

final userProvider = StateNotifierProvider<UserState, User?>((ref) => UserState());