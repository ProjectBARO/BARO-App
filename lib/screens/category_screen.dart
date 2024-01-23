import 'package:baro_project/provider/video_provider.dart';
import 'package:baro_project/widgets/app_bar_back.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class CategoryScreen extends ConsumerStatefulWidget {
  const CategoryScreen({super.key});

  @override
  CategoryState createState() => CategoryState();
}

class CategoryState extends ConsumerState<CategoryScreen> {
  final TextEditingController _textEditingController = TextEditingController();

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBarBack(context, () => context.go('/main')),
      body: Center(
        child: Column(
          children: <Widget>[
            const SizedBox(height: 50.0),
            const Text("바른 자세를 측정하는 동안\n작업할 유형을 선택하거나 적어주세요!",
                textAlign: TextAlign.center, style: TextStyle(fontSize: 20.0)),
            const SizedBox(height: 20.0),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                ElevatedButton(
                  onPressed: () {
                    _textEditingController.value = const TextEditingValue(text: '공부');
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xffDAEDFF),
                  ),
                  child: const Text("#공부", style: TextStyle(color: Colors.black)),
                ),
                const SizedBox(width: 20.0),
                ElevatedButton(
                  onPressed: () {
                    _textEditingController.value = const TextEditingValue(text: '근무');
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xffDAEDFF),
                  ),
                  child: const Text("#근무", style: TextStyle(color: Colors.black)),
                ),
              ],
            ),
            const SizedBox(height: 20.0),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.4,
              child: TextField(
                controller: _textEditingController,
                decoration: const InputDecoration(
                  hintText: 'ex: 공부, 프로젝트 등',
                ),
              ),
            ),
            const SizedBox(height: 20.0),
            ElevatedButton(
                onPressed: () {
                  String type = _textEditingController.text;
                  ref.read(videoProvider.notifier).setType(type);
                  context.push('/category/guide');
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xffDAEDFF),
                ),
                child: const Text("다음", style: TextStyle(color: Colors.black))),
          ],
        ),
      ),
    );
  }
}
