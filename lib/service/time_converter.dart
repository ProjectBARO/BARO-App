String convertAnalysisTime(int time) {
    if (time < 60) {
      return '$time초';
    } else if (time < 3600) {
      return '${time ~/ 60}분';
    } else {
      return '${time ~/ 3600}시간 ${time % 3600 ~/ 60}분';
    }
  }