import 'package:baro_project/widgets/delete_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../provider/auth_provider.dart';
import '../provider/user_provider.dart';
import '../widgets/info_widget.dart';

class InformationScreen extends ConsumerWidget {
  const InformationScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(userProvider);
    return Scaffold(
      body: Center(
        child: ListView(
          children: [
            buildInfoList('이름', user?.name ?? '', context, ref),
            buildInfoList('이메일', user?.email ?? '', context, ref),
            buildInfoList('닉네임', user?.nickname ?? '', context, ref, canEdit: true),
            buildInfoList('성별', getGender(user?.gender), context, ref, canEdit: true),
            buildInfoList('나이', user?.age.toString() ?? '', context, ref, canEdit: true),
            SizedBox(height: MediaQuery.of(context).size.height * 0.2),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: () async {
                      await ref.read(authProvider).signOut().then((value) => context.go('/login'));
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xffDAEDFF),
                      fixedSize: Size(MediaQuery.of(context).size.width*0.3, MediaQuery.of(context).size.height*0.05),
                    ),
                    child: const Text('로그아웃', style: TextStyle(color: Colors.black)),
                  ),
                  ElevatedButton(
                    onPressed: () => deleteDialog(context, ref),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xffDAEDFF),
                      fixedSize: Size(MediaQuery.of(context).size.width*0.3, MediaQuery.of(context).size.height*0.05),
                    ),
                    child: const Text('회원탈퇴', style: TextStyle(color: Colors.red)),
                  )
                ],
              ),
            )
          ],
        ),
      )
    );
  }
}
