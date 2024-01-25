import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:table_calendar/table_calendar.dart';

class CustomCalendar extends ConsumerStatefulWidget {
  const CustomCalendar({super.key});

  @override
  CustomCalendarState createState() => CustomCalendarState();
}

class CustomCalendarState extends ConsumerState<CustomCalendar> {
  DateTime? _selectedDay;
  DateTime _focusedDay = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return TableCalendar(
      locale: 'ko_KR',
      firstDay: DateTime(2024),
      lastDay: DateTime(2034),
      focusedDay: _focusedDay,
      headerStyle: const HeaderStyle(
          titleCentered: true,
          formatButtonVisible: false,
          titleTextStyle: TextStyle(fontWeight: FontWeight.w700, fontSize: 20.0)),
      calendarStyle: const CalendarStyle(
        isTodayHighlighted: false,
        selectedDecoration: BoxDecoration(color: Color(0xff3492E8), shape: BoxShape.circle),
      ),
      onDaySelected: (selectedDay, focusedDay) {
        setState(() {
          _selectedDay = selectedDay;
          _focusedDay = selectedDay;
        });
      },
      selectedDayPredicate: (date) {
        if (_selectedDay == null) {
          return false;
        }
        return date.year == _selectedDay!.year &&
            date.month == _selectedDay!.month &&
            date.day == _selectedDay!.day;
      },
    );
  }
}
