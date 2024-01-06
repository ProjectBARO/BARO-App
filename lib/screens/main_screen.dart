import 'package:baro_project/provider/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
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
                  const Text("BARO와 함께\n공부, 작업 등 앉아있는 시간동안\n자세를 측정해보세요!", textAlign: TextAlign.center),
                  const SizedBox(height: 20.0),
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xff3492E8),
                    ),
                    child: const Text("측정하기", style: TextStyle(color: Colors.white),),
                  ),
                ],
              )
          )
      ),
    );
  }
}
