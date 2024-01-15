import 'package:baro_project/models/user.dart';
import 'package:baro_project/provider/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:go_router/go_router.dart';
import 'package:sign_in_button/sign_in_button.dart';
import '../widgets/intro_view.dart';
import '../provider/user_provider.dart';

class Login extends ConsumerStatefulWidget {
  const Login({super.key});

  @override
  LoginState createState() => LoginState();
}

class LoginState extends ConsumerState<Login> {
  final storage = const FlutterSecureStorage();

  _autoLogin() async {
    String? accessToken = await storage.read(key: "accessToken");
    if (accessToken != null) {
      if (!mounted) return;
      GoRouter.of(context).go('/main');
    }
  }

  @override
  void initState() {
    super.initState();
    _autoLogin();
  }

  @override
  Widget build(BuildContext context) {
    final auth = ref.read(authProvider);
    final userState = ref.read(userProvider.notifier);

    return Scaffold(
        appBar: AppBar(
          leading: Image.asset("assets/images/logo.png", fit: BoxFit.contain),
          backgroundColor: Colors.white,
        ),
        body: Center(
          child: Column(
            children: [
              const SizedBox(height: 20),
              SizedBox(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 0.6,
                child: const IntroView(),
              ),
              const SizedBox(height: 50),
              SignInButton(
                Buttons.google,
                text: "Google 계정으로 로그인",
                onPressed: () {
                  auth.signInWithGoogle().then((User? user) {
                    if (user != null) {
                      userState.setUser(user);
                      auth.getToken(userState.currentUser!).then((String token) {
                        auth.storeToken(token, 'refreshToken');
                      });
                      GoRouter.of(context).go('/main');
                    } else {
                      print("로그인 실패");
                    }
                  });
                },
              )
            ],
          ),
        ));
  }
}
