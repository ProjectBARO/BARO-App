import 'package:baro_project/widgets/app_bar_back.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import '../provider/date_provider.dart';
import '../provider/report_provider.dart';

class ReportScreen extends ConsumerWidget {
  const ReportScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final report = ref.watch(selectedReportProvider);
    String formattedDate = DateFormat('yyyy년 MM월 dd일').format(ref.watch(dateProvider));

    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) => context.go('/calendar'),
      child: Scaffold(
        appBar: customAppBarBack(context, () => context.go('/calendar')),
        body: Padding(
          padding: const EdgeInsets.only(left: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text("자세 분석 보고서", style: TextStyle(fontSize: 35.0, fontWeight: FontWeight.w500)),
              Text(formattedDate, style: const TextStyle(fontSize: 20.0)),
              SizedBox(height: MediaQuery.of(context).size.height*0.1),
              const Text("자세 점수", style: TextStyle(fontSize: 20.0, color: Colors.grey)),
              Text('${report!.score.toString()}점', style: const TextStyle(fontSize: 50.0, fontWeight: FontWeight.w500))
            ],
          ),
        )
      ),
    );
  }
}
