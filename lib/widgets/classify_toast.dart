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
    
      if (classifierState.isTurtle == true) {
        Fluttertoast.showToast(
          msg: '올바른 자세를 유지해주세요!',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
        );
        Vibration.vibrate();
      }
    return const SizedBox.shrink();
  }
}
