import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class MainScreen extends ConsumerStatefulWidget {
  const MainScreen({super.key});

  @override
  MainScreenState createState() => MainScreenState();
}

class MainScreenState extends ConsumerState<MainScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
          child: Center(
              child: Column(
                children: <Widget>[
                  const SizedBox(height: 20.0),
                  const Text("BARO와 함께\n공부, 작업 등 앉아있는 시간동안\n자세를 측정해보세요!", textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.w500),),
                  const SizedBox(height: 20.0),
                  ElevatedButton(
                    onPressed: () => context.push('/category'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xff3492E8),
                    ),
                    child: const Text("측정하기", style: TextStyle(color: Colors.white),),
                  ),
                  const SizedBox(height: 20.0),
                  SizedBox(
                    width: MediaQuery.of(context).size.width*0.8,
                    height: 300,
                    child: const DecoratedBox(
                      decoration: BoxDecoration(color: Color(0xffDAEDFF)),
                    ),
                  ),
                  const SizedBox(height: 20.0),
                  SizedBox(
                    width: MediaQuery.of(context).size.width*0.8,
                    height: 300,
                    child: const DecoratedBox(
                      decoration: BoxDecoration(color: Color(0xffDAEDFF)),
                    ),
                  ),
                  const SizedBox(height: 20.0)
                ],
              )
          )
      ),
    );
  }
}
