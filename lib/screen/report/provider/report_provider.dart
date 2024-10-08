import 'package:baro_project/model/calendar.dart';
import 'package:baro_project/screen/calendar/provider/calendar_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../model/report.dart';

final reportProvider = FutureProvider.family<List<Report>, DateTime>((ref, selectedDay) async {
  int month = int.parse('${selectedDay.year}${selectedDay.month.toString().padLeft(2, '0')}');

  List<Calendar> monthCalendars = ref.read(calendarDataProvider)[month] ?? [];
  List<Calendar> dayCalendars = monthCalendars.where((calendar) => calendar.createdAt!.day == selectedDay.day).toList();

  List<Report> reports = [];
  final reportService = ref.watch(calendarServiceProvider);

  for (var calendar in dayCalendars) {
    var report = await reportService.getReport(calendar.id!);
    reports.add(report!);
  }

  return reports;
});

final selectedReportProvider = StateProvider<Report?>((ref) => null);