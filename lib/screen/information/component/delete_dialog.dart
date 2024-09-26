import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:baro_project/screen/login/provider/auth_provider.dart';

void deleteDialog(BuildContext context, WidgetRef ref) {
  showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("알림"),
          content: const Text("정말로 회원탈퇴 하시겠습니까?"),
          actions: [
            TextButton(
              onPressed: () async {
                await ref.read(authProvider).deleteUserInfo().then((value) => context.go('/login'));
              },
              child: const Text("확인"),
            ),
            TextButton(
              onPressed: () => context.pop(),
              child: const Text("취소"),
            ),
          ],
        );
      }
    );
}
