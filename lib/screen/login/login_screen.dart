import 'dart:developer';

import 'package:baro_project/model/user.dart' as model_user;
import 'package:baro_project/screen/login/provider/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';
import 'package:sign_in_button/sign_in_button.dart';
import 'component/intro_view.dart';
import 'provider/user_provider.dart';

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
      ref.read(authProvider).getUserInfo(accessToken).then((model_user.User? user) {
        ref.read(userProvider.notifier).setUser(user);
        GoRouter.of(context).go('/main');
        FlutterNativeSplash.remove();
      }).catchError((error) {
        Fluttertoast.showToast(msg: '로그인에 실패했습니다. : $error');
        FlutterNativeSplash.remove();
      });
    } else {
      FlutterNativeSplash.remove();
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
                width: MediaQuery.of(context).size.width * 0.9,
                height: MediaQuery.of(context).size.height * 0.6,
                child: const IntroView(),
              ),
              const SizedBox(height: 50),
              SignInButton(Buttons.google, text: "Google 계정으로 로그인", onPressed: () async {
                try {
                  final user = await auth.getUserFromGoogle();
                  if (user != null) {
                    userState.setUser(user);
                    final token = await auth.getToken(userState.currentUser!);
                    await auth.storeToken(token);
                    if (context.mounted) {
                      context.go('/main');
                    }
                  } else {
                    Fluttertoast.showToast(msg: '로그인에 실패했습니다.');
                  }
                } catch (e) {
                  Fluttertoast.showToast(msg: '로그인 중 오류가 발생했습니다. : $e');
                  log(e.toString());
                }
              })
            ],
          ),
        ));
  }
}
