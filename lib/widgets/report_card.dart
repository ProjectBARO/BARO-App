import 'package:baro_project/provider/date_provider.dart';
import 'package:baro_project/provider/report_provider.dart';
import 'package:baro_project/service/time_converter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

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
        } else {
          return SizedBox(
            height: MediaQuery.of(context).size.height * 0.2,
            child: ListView.builder(
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemCount: reports.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.only(right: 15),
                  child: GestureDetector(
                      onTap: () {
                        ref.read(selectedReportProvider.notifier).state = reports[index];
                        context.go('/report');
                      },
                      child: Card(
                        elevation: 0,
                        color: const Color(0xffDAEDFF),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        child: SizedBox(
                            width: MediaQuery.of(context).size.width * 0.4,
                            child: Stack(
                              children: [
                                Positioned(
                                  top: 10,
                                  right: 10,
                                  child: Text(
                                    reports[index].score.toString(),
                                    style: const TextStyle(fontSize: 40.0, fontWeight: FontWeight.w500),
                                  ),
                                ),
                                Positioned(
                                  bottom: 40,
                                  right: 10,
                                  child: Text(
                                    '${convertAnalysisTime(reports[index].analysisTime!)} 측정',
                                    style: const TextStyle(fontSize: 20.0),
                                  ),
                                ),
                                Positioned(
                                  bottom: 15,
                                  right: 10,
                                  child: Text(
                                    '#${reports[index].type}',
                                    style: const TextStyle(fontSize: 20.0),
                                  ),
                                )
                              ],
                            )),
                      )),
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
