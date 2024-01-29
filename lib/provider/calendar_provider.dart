import 'package:baro_project/service/calendar_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/calendar.dart';

class CalendarData extends StateNotifier<Map<int, List<Calendar>>> {
  CalendarData() : super({});

  void addData(int date, List<Calendar> calendars) {
    state = {
      ...state,
      date: calendars,
    };
  }
}

final calendarDataProvider = StateNotifierProvider<CalendarData, Map<int, List<Calendar>>>((ref) => CalendarData());

final calendarServiceProvider = Provider<CalendarService>((ref) => CalendarService());

final calendarProvider = FutureProvider.family<List<Calendar>, int>((ref, date) async {
  final calendarData = ref.read(calendarDataProvider);

  if (calendarData.containsKey(date)) {
    return calendarData[date]!;
  }

  final calendarService = ref.read(calendarServiceProvider);

  try {
    final calendars = await calendarService.getCalendars(date);
    ref.watch(calendarDataProvider.notifier).addData(date, calendars!);
    return calendars;
  } catch (_) {
    return <Calendar>[];
  }
});
