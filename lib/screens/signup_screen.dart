import 'package:baro_project/provider/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class SignUp extends ConsumerStatefulWidget {
  const SignUp({super.key});

  @override
  SignUpState createState() => SignUpState();
}

class SignUpState extends ConsumerState<SignUp> {
  final TextEditingController _ageController = TextEditingController();
  final _gender = ['남성', '여성'];
  String? _selectedGender;

  @override
  Widget build(BuildContext context) {
    final auth = ref.read(authProvider);
    final user = ref.read(userProvider.notifier);

    return Scaffold(
        appBar: AppBar(
          leading: Image.asset("assets/images/logo.png", fit: BoxFit.contain),
          backgroundColor: Colors.white,
        ),
        body: Center(
          child: Column(
            children: [
              const SizedBox(height: 30),
              const Text("성별과 나이를 입력해주세요.", style: TextStyle(fontSize: 20)),
              const SizedBox(height: 30),
              TextField(
                controller: _ageController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: '나이',
                ),
              ),
              const SizedBox(height: 30),
              DropdownButton(
                  value: _selectedGender,
                  items: _gender.map((String value) {
                    return DropdownMenuItem(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      _selectedGender = value!;
                    });
                  }),
              const SizedBox(height: 30),
              ElevatedButton(
                child: const Text('완료'),
                onPressed: () {
                  user.updateUser(int.parse(_ageController.text), _selectedGender!);
                  auth.getToken(user.currentUser!).then((String token) {
                    auth.storeToken(token, "refreshToken");
                  });
                  GoRouter.of(context).go('/test');
                },
              )
            ],
          ),
        ));
  }
}
