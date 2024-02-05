import 'package:baro_project/models/percentage.dart';
import 'package:baro_project/service/percentage_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final percentageProvider = FutureProvider<Percentage>((ref) {
  return PercentageService().getPercentage();
});
