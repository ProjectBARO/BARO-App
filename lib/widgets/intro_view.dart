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
            Padding(
              padding: const EdgeInsets.only(left: 20.0),
              child: Container(
                alignment: Alignment.topLeft,
                child: const Text(
                  "앉아 있는 시간,\n건강하게 바로 세우다.",
                  textAlign: TextAlign.left,
                  style: TextStyle(fontSize: 25),
                ),
              ),
            ),
            const Text("2"),
            const Text("3"),
            const Text("4"),
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
