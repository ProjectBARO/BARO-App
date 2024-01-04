import 'package:baro_project/widgets/app_bar.dart';
import 'package:baro_project/widgets/custom_drawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class InformationScreen extends ConsumerWidget {
  const InformationScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: customAppBar(context),
      body: const Center(
        child: Text("Information"),
      ),
      endDrawer: customDrawer(context),
    );
  }
}