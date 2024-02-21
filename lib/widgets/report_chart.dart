import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class CustomPieChart extends StatelessWidget {
  const CustomPieChart({
    Key? key,
    required this.value,
    required this.color,
    this.centerSpaceRadius = 50.0,
    this.radius = 7.5,
  }) : super(key: key);

  final double value;
  final Color color;
  final double centerSpaceRadius;
  final double radius;

  @override
  Widget build(BuildContext context) {
    return PieChart(
      PieChartData(
        startDegreeOffset: 270.0,
        centerSpaceRadius: centerSpaceRadius,
        sections: [
          PieChartSectionData(
            color: color,
            value: value,
            radius: radius,
            showTitle: false,
          ),
          PieChartSectionData(
            color: const Color(0xffF1F3F5),
            value: 100 - value,
            radius: radius,
            showTitle: false,
          ),
        ],
      ),
    );
  }
}

class CustomBarChart extends StatelessWidget {
  CustomBarChart(String statusFrequencies, {super.key}) : data = stringToList(statusFrequencies);

  final List<int> data;
  final List<String> titles = ['좋음', '보통', '나쁨', '매우 나쁨'];
  final List<Color> colors = [const Color(0xff3492E8), Colors.greenAccent, Colors.orangeAccent, Colors.redAccent];

  @override
  Widget build(BuildContext context) {
    return BarChart(BarChartData(
        maxY: 100,
        barGroups: data.asMap().entries.map((entry) {
          return BarChartGroupData(
            showingTooltipIndicators: [0],
            x: entry.key,
            barRods: [
              BarChartRodData(
                toY: entry.value.toDouble(),
                color: colors[entry.key],
                width: 20.0,
                borderRadius: const BorderRadius.only(topLeft: Radius.circular(6.0), topRight: Radius.circular(6.0))
              )
            ]
          );
        }).toList(),
        barTouchData: _barTouchData,
        gridData: const FlGridData(
          show: false,
        ),
        borderData: FlBorderData(
            border: const Border(
                top: BorderSide.none,
                bottom: BorderSide(color: Color(0xffE4E4E4), width: 1.0),
                right: BorderSide.none,
                left: BorderSide(color: Color(0xffE4E4E4), width: 1.0))),
        titlesData: FlTitlesData(
            bottomTitles: AxisTitles(sideTitles: _bottomTitles),
            topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
            rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
            leftTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)))));
  }

  BarTouchData get _barTouchData => BarTouchData(
    enabled: false,
    touchTooltipData: BarTouchTooltipData(
      tooltipBgColor: Colors.transparent,
      tooltipPadding: EdgeInsets.zero,
      tooltipMargin: 8,
      getTooltipItem: (
        BarChartGroupData group,
        int groupIndex,
        BarChartRodData rod,
        int rodIndex,
      ) => BarTooltipItem(
        rod.toY.toInt().toString(),
        const TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.w500,
        )
      )
    )
  );

  SideTitles get _bottomTitles => SideTitles(
      showTitles: true,
      getTitlesWidget: (value, meta) {
        String text = '';
        switch (value.toInt()) {
          case 0:
            text = '좋음';
            break;
          case 1:
            text = '보통';
            break;
          case 2:
            text = '나쁨';
            break;
          case 3:
            text = '매우 나쁨';
            break;
        }
        return Text(text);
      });
}

List<int> stringToList(String str) {
  return str.substring(1, str.length - 1).split(' ').map((e) => int.parse(e.trim())).toList();
}
