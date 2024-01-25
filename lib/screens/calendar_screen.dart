import 'package:baro_project/widgets/custom_calendar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CalendarScreen extends ConsumerWidget {
  const CalendarScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const PopScope(
      canPop: false,
      child: Scaffold(
        body: Center(
          child: Column(
            children: [
              CustomCalendar(),
            ],
          ),
        )
      ),
    );
  }
}
