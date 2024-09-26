import 'package:baro_project/screen/calendar/provider/date_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'component/custom_calendar.dart';
import 'component/report_card.dart';

class CalendarScreen extends ConsumerWidget {
  const CalendarScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    String formattedDate = DateFormat('yyyy년 MM월 dd일').format(ref.watch(dateProvider));
    return PopScope(
      canPop: false,
      child: Scaffold(
        body: Center(
          child: Column(
            children: [
              const CustomCalendar(),
              SizedBox(height: MediaQuery.of(context).size.height * 0.03),
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.only(left: 20.0),
                  child: Text(formattedDate, style: const TextStyle(fontSize: 20.0, fontWeight: FontWeight.w500)),
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.06),
              const ReportCard(),
            ],
          ),
        ),
      ),
    );
  }
}
