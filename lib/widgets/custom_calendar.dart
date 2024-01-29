import 'package:baro_project/provider/date_provider.dart';
import 'package:baro_project/util/calendar_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:table_calendar/table_calendar.dart';
import '../models/calendar.dart';
import '../provider/calendar_provider.dart';

class CustomCalendar extends ConsumerStatefulWidget {
  const CustomCalendar({super.key});

  @override
  CustomCalendarState createState() => CustomCalendarState();
}

class CustomCalendarState extends ConsumerState<CustomCalendar> {
  DateTime? _selectedDay;
  DateTime _focusedDay = DateTime.now();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      int date = int.parse('${_focusedDay.year}${_focusedDay.month.toString().padLeft(2, '0')}');
      ref.read(calendarProvider(date));
    });
  }

  @override
  Widget build(BuildContext context) {
    int date = int.parse("${_focusedDay.year}${_focusedDay.month.toString().padLeft(2, '0')}");
    final calendarData = ref.watch(calendarProvider(date));

    return calendarData.when(
      data: (calendars) {
        return TableCalendar(
          locale: 'ko_KR',
          firstDay: DateTime(2024),
          lastDay: DateTime(2034),
          focusedDay: _focusedDay,
          headerStyle: headerStyle,
          calendarStyle: calendarStyle,
          onDaySelected: (selectedDay, focusedDay) {
            setState(() {
              _selectedDay = selectedDay;
              _focusedDay = selectedDay;
            });
            ref.read(dateProvider.notifier).update(selectedDay);
          },
          selectedDayPredicate: (date) {
            if (_selectedDay == null) {
              return false;
            }
            return date.year == _selectedDay!.year &&
                date.month == _selectedDay!.month &&
                date.day == _selectedDay!.day;
          },
          onPageChanged: (focusedDay) {
            int date = int.parse('${focusedDay.year}${focusedDay.month.toString().padLeft(2, '0')}');
            ref.read(calendarProvider(date));
          },
          eventLoader: (day) {
            int month = int.parse('${day.year}${day.month.toString().padLeft(2, '0')}');
            final monthEvents = ref.read(calendarDataProvider)[month];
            if (monthEvents != null) {
              final dayEvents = monthEvents.where((event) => event.createdAt!.day == day.day).toList();
              return dayEvents.isNotEmpty ? [dayEvents[0]] : <Calendar>[];
            }
            return <Calendar>[];
          },
        );
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (_, __) => const Text('레포트 데이터가 존재하지 않습니다.'),
    );
  }
}
