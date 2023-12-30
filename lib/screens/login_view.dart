import 'package:sign_in_button/sign_in_button.dart';
import 'package:flutter/material.dart';
import '../widgets/intro_view.dart';

class Login extends StatelessWidget {
  const Login({super.key});

  @override
  Widget build(BuildContext context) {
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
              onPressed: () {},
            )
          ],
        ),
      )
    );
  }
}
