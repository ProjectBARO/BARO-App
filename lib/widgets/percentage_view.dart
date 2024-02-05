import 'package:baro_project/widgets/bar_chart.dart';
import 'package:flutter/material.dart';
import 'package:baro_project/provider/percentage_provider.dart';
import 'package:baro_project/widgets/info_widget.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PercentageView extends ConsumerWidget {
  const PercentageView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final percentageAsyncValue = ref.watch(percentageProvider);

    return percentageAsyncValue.when(data: (data) {
      int ageRange = ((data.age!) ~/ 10) * 10;
      int ratio = double.parse(data.normalRatio!).toInt();
      int myScore = double.parse(data.myScore!).toInt();
      int averageScore = double.parse(data.averageScore!).toInt();

      return Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Container(
                alignment: Alignment.topLeft,
                child: Text(
                  "${data.nickname}님의 주간 평균 자세 점수는\n$ageRange대 ${getGender(data.gender)} 중 상위 $ratio%입니다.",
                  style: const TextStyle(fontSize: 22.5, fontWeight: FontWeight.w500)),
              )
            ),
            Padding(
              padding: const EdgeInsets.only(left: 15.0, right: 20.0),
              child: SizedBox(
                height: MediaQuery.of(context).size.height*0.175,
                child: customChart(myScore, averageScore),  
              ),
            )
          ]
        );
    }, loading: () {
      return Center(
        child: SizedBox(
          width: MediaQuery.of(context).size.width * 0.1,
          height: MediaQuery.of(context).size.width * 0.1,
          child: const CircularProgressIndicator(),
        ),
      );
    }, error: (_, __) {
      return const Center(
        child: Text(
          "측정된 데이터가 없습니다.\n자세를 측정해보세요!",
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 20.0),
        ),
      );
    });
  }
}
