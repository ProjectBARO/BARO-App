import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../provider/auth_provider.dart';

class InformationScreen extends ConsumerStatefulWidget {
  const InformationScreen({super.key});

  @override
  InformationState createState() => InformationState();
}

class InformationState extends ConsumerState<InformationScreen> {
  @override
  Widget build(BuildContext context) {
    final auth = ref.read(authProvider);

    return Scaffold(
      body: Center(
          child: Column(
        children: <Widget>[
          ElevatedButton(
              child: const Text("로그아웃"),
              onPressed: () async {
              await auth.signOut();
              if (!mounted) return;
              GoRouter.of(context).go('/login');
            }
          ),
        ],
      )),
    );
  }
}
