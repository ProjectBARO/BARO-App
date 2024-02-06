import 'package:baro_project/widgets/percentage_view.dart';
import 'package:baro_project/widgets/tip_text.dart';
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
                  const Padding(
                    padding: EdgeInsets.only(top: 20.0, bottom: 20.0),
                    child: Text(
                      "BARO와 함께\n공부, 작업 등 앉아있는 시간동안\n자세를 측정해보세요!", 
                      textAlign: TextAlign.center, 
                      style: TextStyle(fontWeight: FontWeight.w500, fontSize: 20.0),),
                  ),
                  ElevatedButton(
                    onPressed: () => context.push('/category'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xff3492E8),
                    ),
                    child: const Text("측정하기", style: TextStyle(color: Colors.white),),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 20.0),
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width*0.8,
                      child: ConstrainedBox(
                        constraints: BoxConstraints(minHeight: MediaQuery.of(context).size.height*0.15),
                        child: DecoratedBox(
                          decoration: const BoxDecoration(color: Color(0xffDAEDFF), borderRadius: BorderRadius.all(Radius.circular(20))),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.only(left: 20.0, right: 20.0, top: 20.0, bottom: 10.0),
                                child: Container(
                                  alignment: Alignment.topLeft,
                                  child: const Text("💡 오늘의 팁", style: TextStyle(fontSize: 22.5, fontWeight: FontWeight.w500)),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 20.0, right: 20.0, bottom: 20.0),
                                child: Container(
                                  alignment: Alignment.topLeft,
                                  child: randomTip(),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 20.0, bottom: 20.0),
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width*0.8,
                      height: MediaQuery.of(context).size.height*0.3,
                      child: const DecoratedBox(
                        decoration: BoxDecoration(color: Color(0xffDAEDFF), borderRadius: BorderRadius.all(Radius.circular(20))),
                        child: PercentageView(),
                      ),
                    ),
                  ),                  
                  SizedBox(
                    width: MediaQuery.of(context).size.width*0.8,
                    height: 300,
                    child: const DecoratedBox(
                      decoration: BoxDecoration(color: Color(0xffDAEDFF), borderRadius: BorderRadius.all(Radius.circular(20))),
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
