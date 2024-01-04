import 'package:baro_project/provider/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:go_router/go_router.dart';

class MainScreen extends ConsumerStatefulWidget {
  const MainScreen({super.key});

  @override
  MainScreenState createState() => MainScreenState();
}

class MainScreenState extends ConsumerState<MainScreen> {
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
        body: Center(
          child: Column(
            children: [
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
            ],
          ),
        ),
    );
  }
}
