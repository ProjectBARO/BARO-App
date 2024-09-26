import 'package:flutter/material.dart';

Dialog loadingDialog(ValueNotifier<double> progressNotifier) {
  return Dialog(
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 20.0, bottom: 20.0),
          child: ValueListenableBuilder<double>(
            valueListenable: progressNotifier,
            builder: (context, progress, child) {
              return Column(
                children: [
                  CircularProgressIndicator(
                    value: progress / 100,
                    valueColor: const AlwaysStoppedAnimation<Color>(Colors.green),
                  ),
                  const SizedBox(height: 10),
                  Text('${progress.toStringAsFixed(0)}%', style: const TextStyle(fontSize: 20.0))
                ],
              );
            },
          )
        ),
        const Padding(
          padding: EdgeInsets.only(bottom: 20.0),
          child: Center(
            child: Column(
              children: [
                Text('영상을 처리하는 중입니다.', style: TextStyle(fontSize: 20.0)),
                Text('잠시만 기다려주세요.', style: TextStyle(fontSize: 20.0))
              ],
            ),
          )
        )      
      ],
    ),
  );
}