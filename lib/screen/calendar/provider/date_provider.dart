import 'package:flutter_riverpod/flutter_riverpod.dart';

class DateState extends StateNotifier<DateTime> {
  DateState() : super(DateTime.now());

  void update(DateTime date) {
    state = date;
  }
}

final dateProvider = StateNotifierProvider<DateState, DateTime>((ref) => DateState());