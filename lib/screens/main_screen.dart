import 'package:baro_project/provider/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:baro_project/screens/camera_screen.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:go_router/go_router.dart';

class MainPage extends ConsumerStatefulWidget {
  const MainPage({super.key});

  @override
  MainPageState createState() => MainPageState();
}

class MainPageState extends ConsumerState<MainPage> {
  final storage = const FlutterSecureStorage();

  Future<void> printToken() async {
    String? accessToken = await storage.read(key: "accessToken");
    String? refreshToken = await storage.read(key: "refreshToken");
    print(accessToken);
    print(refreshToken);
  }

  @override
  Widget build(BuildContext context) {
    final user = ref.read(userProvider.notifier);
    final auth = ref.read(authProvider);

    return Scaffold(
        appBar: AppBar(
          leading: Image.asset("assets/images/logo.png", fit: BoxFit.contain),
          backgroundColor: Colors.white,
        ),
        body: Center(
          child: Column(
            children: [
              const Text("성공"),
              ElevatedButton(
                child: const Text("토큰 출력"),
                onPressed: () {
                  printToken();
                },
              ),
              ElevatedButton(
                  child: const Text("로그아웃"),
                  onPressed: () async {
                    await auth.signOut();
                    if (!mounted) return;
                    GoRouter.of(context).go('/login');
                  }),
              ElevatedButton(
                  // 카메라 버튼을 추가합니다.
                  child: const Text("카메라 실행"),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => TakePhotoPage()),
                    );
                  }),
            ],
          ),
        ));
  }
}
