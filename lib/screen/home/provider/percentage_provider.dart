import 'package:baro_project/model/percentage.dart';
import 'package:baro_project/screen/home/util/percentage_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final percentageProvider = FutureProvider<Percentage>((ref) async {
  final data = await PercentageService().getPercentage();
  if (data!.age == null || data.averageScore == null || data.gender == null || data.myScore == null || data.nickname == null || data.normalRatio == null) {
    throw Exception('Failed to load percentage');
  }
  return data;
});
