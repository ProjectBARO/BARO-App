import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:vibration/vibration.dart';

import '../provider/classifier_provider.dart';

class ClassifyToast extends ConsumerWidget {
  const ClassifyToast({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final classifierState = ref.watch(classifierProvider);
    
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (classifierState.isTurtle == true) {
        Fluttertoast.showToast(
          msg: '자세를 고치세요!',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
        );
        Vibration.vibrate();
        log("알림");
      }
    });
    return const SizedBox.shrink();
  }
}
