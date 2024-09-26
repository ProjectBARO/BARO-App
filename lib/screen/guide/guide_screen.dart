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
            Image.asset("assets/images/user-guide.png", width: MediaQuery.of(context).size.width * 0.2),
            Padding(
              padding: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.05, bottom: MediaQuery.of(context).size.height*0.05),
              child: const Column(
                children: [
                  Text("카메라를 본인의 왼쪽에 두고 촬영하세요.", style: TextStyle(fontSize: 20.0)),
                  Text("카메라는 약 60cm 떨어진 곳에 두세요.", style: TextStyle(fontSize: 20.0)),
                  Text("귀와 어깨가 잘 보이도록 촬영하세요.", style: TextStyle(fontSize: 20.0)),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(bottom: MediaQuery.of(context).size.height*0.05),
              child: const Column(
                children: [
                  Text("녹화 도중 앱을 종료하면 측정 데이터가 사라집니다.", style: TextStyle(fontSize: 20.0)),
                  Text("동영상이 업로드되기 전까지 앱을 종료하지 마세요.", style: TextStyle(fontSize: 20.0)),
                  Text("자리를 비울때는 녹화를 잠시 멈춰주세요.", style: TextStyle(fontSize: 20.0)),
                ],
              )
            ),
            Padding(
              padding: EdgeInsets.only(bottom: MediaQuery.of(context).size.height*0.05),
              child: const Column(
                children: [
                  Text("녹화된 영상은 분석에만 사용되며, 소리는 녹음되지 않습니다.", style: TextStyle(fontSize: 15.0, color: Colors.grey)),
                  Text("개인정보 보호를 위해 녹화된 영상은 자동으로 삭제됩니다.", style: TextStyle(fontSize: 15.0, color: Colors.grey)),
                  Text("분석 결과는 정확하지 않으며, 통증이 있을 경우 전문가와 상담하세요.", style: TextStyle(fontSize: 15.0, color: Colors.grey)),
                ],
              ),
            ),
            ElevatedButton(
              onPressed: () => context.push('/camera'),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xffDAEDFF),
                minimumSize: Size(MediaQuery.of(context).size.width * 0.25, MediaQuery.of(context).size.height * 0.05),
              ),
              child: const Text("시작", style: TextStyle(fontSize: 17.5, color: Colors.black),),
            ),
          ],
        ),
      ),
    );
  }
}
