import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class _ScoreData {
  final String scoreLabel;
  final int score;
  final Color color;

  _ScoreData(this.scoreLabel, this.score, this.color);
}

SfCartesianChart customChart(int myScore, int averageScore) {
  return SfCartesianChart(
    isTransposed: true,
    primaryXAxis: const CategoryAxis(
      majorTickLines: MajorTickLines(size: 0),
    ),
    primaryYAxis: const NumericAxis(
      maximum: 100.0, interval: 20.0,
    ),
    series: [
      ColumnSeries<_ScoreData, String>(
        dataSource: [
          _ScoreData('평균 점수', averageScore, Colors.grey),
          _ScoreData('나의 점수', myScore, const Color(0xff3492E8)),
        ],
        xValueMapper: (_ScoreData scores, _) => scores.scoreLabel,
        yValueMapper: (_ScoreData scores, _) => scores.score,
        pointColorMapper: (_ScoreData scores, _) => scores.color,
        width: 0.3,
      )
    ],
  );
}
