import 'package:baro_project/widgets/app_bar_back.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class GuideScreen extends ConsumerStatefulWidget {
  const GuideScreen({super.key});

  @override
  GuideState createState() => GuideState();
}

class GuideState extends ConsumerState<GuideScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBarBack(context, () => context.pop()),
      body: Center(
        child: Column(
          children: <Widget>[
            const SizedBox(height: 20.0),
            SizedBox(
              width: MediaQuery.of(context).size.width*0.8,
              height: MediaQuery.of(context).size.height*0.4,
              child: const DecoratedBox(
                decoration: BoxDecoration(color: Color(0xffDAEDFF)),
              ),
            ),
            const SizedBox(height: 20.0),
            const Text("시작버튼을 누르고 5초간 프레임에 맞게 앉아주세요.\n일정 시간동안 자세가 흐트러지면 알림을 보냅니다.", textAlign: TextAlign.center,),
            const SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () => context.push('/category/guide/camera'),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xffDAEDFF),
              ),
              child: const Text("시작", style: TextStyle(color: Colors.black),),
            ),
          ],
        ),
      ),
    );
  }
}
