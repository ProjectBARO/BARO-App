import 'package:baro_project/screens/result/util/time_converter.dart';
import 'package:baro_project/screens/result/component/result_text.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:baro_project/widgets/app_bar.dart';
import '../login/provider/user_provider.dart';
import '../camera/provider/video_provider.dart';

class ResultScreen extends ConsumerWidget {
  const ResultScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final videoState = ref.watch(videoProvider);
    final userState = ref.watch(userProvider);
    return PopScope(
        canPop: false,
        onPopInvoked: (didPop) => context.go('/main'),
        child: Scaffold(
          appBar: customAppBar(context),
          body: Center(
            child: Column(
              children: <Widget>[
                const SizedBox(height: 100.0),
                Text.rich(
                  TextSpan(
                    children: <TextSpan>[
                      buildTextSpan('오늘은 '),
                      buildTextSpan('BARO', fontWeight: FontWeight.bold, color: const Color(0xff3492E8)),
                      buildTextSpan('와 함께\n'),
                      buildTextSpan('총 ${convertAnalysisTime(videoState.analysisTime)}동안\n'),
                      buildTextSpan('#${videoState.type}', color: const Color(0xff5200FF)),
                      buildTextSpan('했어요!')
                    ],
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 100.0),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.8,
                  height: MediaQuery.of(context).size.height * 0.2,
                  child: DecoratedBox(
                    decoration: BoxDecoration(color: const Color(0xffDAEDFF), borderRadius: BorderRadius.circular(30)),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Text("${userState?.nickname}님의",
                            style: const TextStyle(fontSize: 17.5, fontWeight: FontWeight.w500)),
                        Text("시간 당 알림 받은 횟수는 총 ${videoState.alertCount}번이에요.",
                            style: const TextStyle(fontSize: 17.5, fontWeight: FontWeight.w500)),
                        const SizedBox(height: 20.0),
                        const Text("보고서가 완성되면 24시간 이내로 알림을 줄게요.",
                            style: TextStyle(fontSize: 17.5, fontWeight: FontWeight.w500))
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 100.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    ElevatedButton(
                      onPressed: () => context.go('/main'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xffDAEDFF),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                      ),
                      child: const Text(
                        '확인',
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                    const SizedBox(width: 20.0),
                    ElevatedButton(
                      onPressed: () => context.go('/calendar'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xffDAEDFF),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                      ),
                      child: const Text('기록', style: TextStyle(color: Colors.black)),
                    )
                  ],
                )
              ],
            ),
          ),
        ));
  }

  
}
