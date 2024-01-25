import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarScreen extends ConsumerStatefulWidget {
  const CalendarScreen({super.key});

  @override
  CalendarState createState() => CalendarState();
}

class CalendarState extends ConsumerState<CalendarScreen> {
  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Scaffold(
        body: TableCalendar(
            firstDay: DateTime(2024),
            lastDay: DateTime(2034),
            focusedDay: DateTime.now(),
            locale: 'ko_KR',
            headerStyle: const HeaderStyle(
                titleCentered: true,
                formatButtonVisible: false,
                titleTextStyle: TextStyle(fontWeight: FontWeight.w700, fontSize: 20.0)),
            
        ),
      ),
    );
  }
}
