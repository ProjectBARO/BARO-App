import 'package:baro_project/widgets/percentage_view.dart';
import 'package:baro_project/widgets/tip_text.dart';
import 'package:baro_project/widgets/video_preview.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
          child: Center(
              child: Column(
                children: <Widget>[
                  const Padding(
                    padding: EdgeInsets.only(top: 20.0, bottom: 20.0),
                    child: Text(
                      "BARO와 함께\n공부, 작업 등 앉아있는 시간동안\n자세를 측정해보세요!", 
                      textAlign: TextAlign.center, 
                      style: TextStyle(fontWeight: FontWeight.w600, fontSize: 20.0)
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () => context.push('/category'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xff3492E8),
                      minimumSize: Size(MediaQuery.of(context).size.width * 0.3, MediaQuery.of(context).size.height * 0.05),
                    ),
                    child: const Text("측정하기", style: TextStyle(fontSize: 20.0, color: Colors.white),),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 20.0),
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width*0.9,
                      height: MediaQuery.of(context).size.height*0.3,
                      child: const DecoratedBox(
                        decoration: BoxDecoration(color: Color(0xffDAEDFF), borderRadius: BorderRadius.all(Radius.circular(20))),
                        child: PercentageView(),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 20.0),
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width * 0.9,
                      child: Stack(
                        alignment: Alignment.topLeft,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 30.0),
                            child: ConstrainedBox(
                              constraints: BoxConstraints(
                                  minHeight: MediaQuery.of(context).size.height * 0.1),
                              child: DecoratedBox(
                                decoration: const BoxDecoration(
                                    color: Color(0xffDAEDFF),
                                    borderRadius: BorderRadius.all(Radius.circular(30))),
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      left: 20.0, right: 20.0, bottom: 20.0, top: 20.0),
                                  child: Container(
                                    alignment: Alignment.topLeft,
                                    child: randomTip(),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const Positioned(
                            top: 0,
                            child: Text(
                              "💡 바른 자세 팁",
                              style: TextStyle(fontSize: 22.5, fontWeight: FontWeight.w500),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(left: 25.0),
                          child: Text("스트레칭 맞춤 영상", style: TextStyle(fontSize: 22.5, fontWeight: FontWeight.w500)),
                        ),
                        GestureDetector(
                          onTap: () => context.go('/youtube'),
                          child: SizedBox(
                            width: MediaQuery.of(context).size.width,
                            height: MediaQuery.of(context).size.height * 0.2,
                            child: const Padding(
                              padding: EdgeInsets.only(left: 20.0, right: 20.0, top: 15.0),
                              child: VideoPreview()
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              )
          )
      ),
    );
  }
}
