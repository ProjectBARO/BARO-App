import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

HeaderStyle headerStyle = const HeaderStyle(
  titleCentered: true,
  formatButtonVisible: false,
  titleTextStyle: TextStyle(fontWeight: FontWeight.w700, fontSize: 20.0),
);

CalendarStyle calendarStyle = const CalendarStyle(
  isTodayHighlighted: false,
  selectedDecoration: BoxDecoration(color: Color(0xff3492E8), shape: BoxShape.circle),
  markerDecoration: BoxDecoration(color: Colors.grey, shape: BoxShape.circle),
  markerSize: 5.0,
  markerMargin: EdgeInsets.only(top: 5.0),
  weekendTextStyle: TextStyle(color: Colors.red),
);
