import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../provider/classify_provider.dart';

class ClassifyToast extends ConsumerWidget {
  const ClassifyToast({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final classifyState = ref.watch(classifyProvider);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (classifyState != null) {
        Fluttertoast.showToast(
          msg: classifyState ? '사람' : '거북이',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
        );
      }
    });
    return const SizedBox.shrink();
  }
}
