import 'package:baro_project/provider/date_provider.dart';
import 'package:baro_project/provider/report_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ReportCard extends ConsumerWidget {
  const ReportCard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedDay = ref.watch(dateProvider);
    final reports = ref.watch(reportProvider(selectedDay));

    return reports.when(
      data: (reports) {
        if (reports.isEmpty) {
          return const Center(child: Text("데이터가 없습니다."));
        }
        else {
          return Expanded(
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: reports.length,
              itemBuilder: (context, index) {
                return Card(
                  child: ListTile(
                    title: Text(reports[index].type!),
                    subtitle: Text(reports[index].createdAt!.toIso8601String()),
                  ),
                );
              },
            ),
          );
        }
      },
      loading: () => const CircularProgressIndicator(),
      error: (error, _) => Text("오류: $error"),
    );
  }
}
