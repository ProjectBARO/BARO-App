import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ResultScreen extends StatelessWidget {
  const ResultScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () => context.go('/main'),
              child: const Text("Main"),
            ),
            ElevatedButton(
              onPressed: () => context.go('/calendar'),
              child: const Text("Calendar"),
            )
          ],
        ),
      ),
    );
  }
}