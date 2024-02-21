import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class IntroView extends StatefulWidget {
  const IntroView({super.key});

  @override
  State<IntroView> createState() => _IntroViewState();
}

class _IntroViewState extends State<IntroView> {
  final _controller = PageController();
  final _pageCount = 4;
  // ignore: unused_field
  var _currentPage = 0.0;

  @override
  void initState() {
    super.initState();
    _controller.addListener(_onPageChanged);
  }

  @override
  void dispose() {
    _controller.removeListener(_onPageChanged);
    _controller.dispose();
    super.dispose();
  }

  void _onPageChanged() {
    setState(() {
      _currentPage = _controller.page!;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        PageView(
          controller: _controller,
          children: <Widget>[
            Container(
              alignment: Alignment.topLeft,
              child: const Text(
                "앉아 있는 시간,\n건강하게 바로 세우다.",
                textAlign: TextAlign.left,
                style: TextStyle(fontSize: 35),
              ),
            ),
            Column(
              children: [
                Image.asset('assets/images/posture.png'),
                const Text('실시간 자세 분석을 통해 바른 자세로 앉아보세요.', style: TextStyle(fontSize: 20))
              ],
            ),
            Column(
              children: [
                Image.asset(
                  width: MediaQuery.of(context).size.height * 0.5,
                  height: MediaQuery.of(context).size.height * 0.4,
                  'assets/images/report.png'
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.05,),
                const Text("자세 분석 결과를 통해 자세 습관을 개선하세요.", style: TextStyle(fontSize: 20))
              ],
            ),
            Column(
              children: [
                Image.asset(
                  width: MediaQuery.of(context).size.height * 0.5,
                  height: MediaQuery.of(context).size.height * 0.4,
                  'assets/images/warning.png'
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.05),
                const Text("제공되는 데이터는 정확하지 않을 수 있습니다.", style: TextStyle(fontSize: 20)),
                const Text("의사나 전문가와 상담하여 정확한 진단을 받으세요.", style: TextStyle(fontSize: 20))
              ],
            )
          ],
        ),
        Positioned(
            bottom: 10,
            left: 0,
            right: 0,
            child: Center(
              child: SmoothPageIndicator(
                  controller: _controller,
                  count: _pageCount,
                  effect: const ExpandingDotsEffect(
                    activeDotColor: Color(0xff3492E8),
                    dotColor: Colors.grey,
                    dotHeight: 8,
                    dotWidth: 8,
                    expansionFactor: 4,
                    spacing: 5,
                  )),
            ))
      ],
    );
  }
}
