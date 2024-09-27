import 'package:baro_project/screen/result/util/time_converter.dart';
import 'package:baro_project/common/app_bar_back.dart';
import 'package:baro_project/screen/report/component/report_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'provider/report_provider.dart';

class ReportScreen extends ConsumerWidget {
  const ReportScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final report = ref.watch(selectedReportProvider);
    String formattedDate = DateFormat('yyyy년 MM월 dd일 HH시 mm분').format(report!.createdAt!.toLocal());

    double degree = 0.0;
    if (report.neckAngles != '[]') {
      degree = double.parse(report.neckAngles!.replaceAll(RegExp(r'[\[\]]'), ''));
    }

    double distance = 0.0;
    if (report.distances != '[]') {
      distance = double.parse(report.distances!.replaceAll(RegExp(r'[\[\]]'), ''));
    }

    return Scaffold(
        backgroundColor: const Color(0xffF1F3F5),
        appBar: customAppBarBack(context, () => context.pop()),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(
                top: MediaQuery.of(context).size.height * 0.01,
                left: MediaQuery.of(context).size.width * 0.025,
                right: MediaQuery.of(context).size.width * 0.025),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.95,
                  height: MediaQuery.of(context).size.height * 0.1,
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.025),
                          child: const Text("자세 분석 보고서", style: TextStyle(fontSize: 35.0, fontWeight: FontWeight.w500)),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.025),
                          child: Text(formattedDate, style: const TextStyle(fontSize: 20.0)),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.01),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.95,
                  height: MediaQuery.of(context).size.height * 0.25,
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(
                              left: MediaQuery.of(context).size.width * 0.025,
                              top: MediaQuery.of(context).size.height * 0.025),
                          child: const Text("자세 점수", style: TextStyle(fontSize: 20.0, color: Colors.grey)),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.025),
                          child: Text('${report.score!.split('.').first}점',
                              style: const TextStyle(fontSize: 50.0, fontWeight: FontWeight.w500)),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              left: MediaQuery.of(context).size.width * 0.025,
                              top: MediaQuery.of(context).size.height * 0.025),
                          child: Row(
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text("측정 시간", style: TextStyle(fontSize: 20.0, color: Colors.grey)),
                                  Text(convertAnalysisTime(report.analysisTime!),
                                      style: const TextStyle(fontSize: 30.0, fontWeight: FontWeight.w500))
                                ],
                              ),
                              SizedBox(width: MediaQuery.of(context).size.width * 0.2),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text("유형", style: TextStyle(fontSize: 20.0, color: Colors.grey)),
                                  Text(report.type!,
                                      style: const TextStyle(fontSize: 30.0, fontWeight: FontWeight.w500))
                                ],
                              ),
                              SizedBox(width: MediaQuery.of(context).size.width * 0.2),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text("알림 횟수", style: TextStyle(fontSize: 20.0, color: Colors.grey)),
                                  Text('${report.alertCount!.toString()}회',
                                      style: const TextStyle(fontSize: 30.0, fontWeight: FontWeight.w500))
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.01),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.3,
                  width: MediaQuery.of(context).size.height * 0.9,
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.4,
                              height: MediaQuery.of(context).size.height * 0.2,
                              child: DecoratedBox(
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(30.0),
                                ),
                                child: Stack(
                                  children: [
                                    CustomPieChart(
                                        value: report.normalRatio!.split('.').first == '0'
                                            ? 0
                                            : double.parse(report.normalRatio!),
                                        color: const Color(0xff3492E8),
                                        radius: 15.0),
                                    Positioned.fill(
                                        child: Center(
                                            child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        const Text('정상 비율',
                                            style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w500)),
                                        Text('${report.normalRatio!.split('.').first}%',
                                            style: const TextStyle(fontSize: 20.0, color: Colors.black)),
                                      ],
                                    ))),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(width: MediaQuery.of(context).size.width * 0.15),
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.4,
                              height: MediaQuery.of(context).size.height * 0.2,
                              child: DecoratedBox(
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(20.0),
                                ),
                                child: Stack(
                                  children: [
                                    CustomPieChart(value: convertDegreeToPercentage(degree), color: Colors.greenAccent),
                                    CustomPieChart(
                                        value: convertDistanceToPercentage(distance),
                                        color: Colors.redAccent,
                                        centerSpaceRadius: 57.5),
                                    Positioned.fill(
                                        child: Center(
                                            child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Text('거리 ${distance.toInt()}cm',
                                            style: const TextStyle(fontSize: 20.0, fontWeight: FontWeight.w500)),
                                        Text('각도 ${degree.toInt()}˚',
                                            style: const TextStyle(fontSize: 20.0, fontWeight: FontWeight.w500)),
                                      ],
                                    ))),
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                        const Text("정상 비율은 측정 중 자세가 정상인 비율을 나타냅니다.",
                            style: TextStyle(fontSize: 15.0, color: Colors.grey)),
                        const Text("빨간색 그래프는 거리, 초록색 그래프는 각도를 나타냅니다.",
                            style: TextStyle(fontSize: 15.0, color: Colors.grey)),
                        const Text("거리는 몸과 귀의 수평 거리를 측정한 것이며, 낮을수록 좋습니다.",
                            style: TextStyle(fontSize: 15.0, color: Colors.grey)),
                        const Text("각도는 목의 기울기를 측정한 것이며, 180도에 가까울수록 좋습니다.",
                            style: TextStyle(fontSize: 15.0, color: Colors.grey)),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.01),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.4,
                  width: MediaQuery.of(context).size.width * 0.95,
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(
                              top: MediaQuery.of(context).size.height * 0.03,
                              bottom: MediaQuery.of(context).size.height * 0.03),
                          child: SizedBox(
                            height: MediaQuery.of(context).size.height * 0.25,
                            width: MediaQuery.of(context).size.width * 0.7,
                            child: CustomBarChart(report.statusFrequencies!),
                          ),
                        ),
                        const Text("측정 중 자세가 좋고 나쁨을 나타낸 그래프입니다.", style: TextStyle(fontSize: 15.0, color: Colors.grey)),
                        const Text(
                          "모든 데이터는 정확하지 않을 수 있으므로, 참고용으로만 사용해주세요.",
                          style: TextStyle(fontSize: 15.0, color: Colors.grey),
                        )
                      ],
                    ),
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.01)
              ],
            ),
          ),
        ));
  }

  double convertDegreeToPercentage(double degree) {
    return degree / 180 * 100;
  }

  double convertDistanceToPercentage(double distance) {
    return distance / 20 * 100;
  }
}
