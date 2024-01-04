import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class NotificationManager extends ConsumerStatefulWidget {
  const NotificationManager({super.key});

  @override
  NotificationState createState() => NotificationState();
}

class NotificationState extends ConsumerState<NotificationManager> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold();
  }
}
