import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';

class TimerState {
  final int currentTime;
  TimerState(this.currentTime);
}

class TimerNotifier extends StateNotifier<TimerState> {
  Timer? _timer;

  TimerNotifier() : super(TimerState(0));

  void startTimer() {
    if (_timer?.isActive ?? false) {
      return;
    }
    state = TimerState(10);
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (state.currentTime == 0) {
        timer.cancel();
      } else {
        state = TimerState(state.currentTime - 1);
      }
    });
  }

  void resetTimer() {
    _timer?.cancel();
    state = TimerState(10);
  }
}

final timerProvider = StateNotifierProvider<TimerNotifier, TimerState>((ref) => TimerNotifier());
