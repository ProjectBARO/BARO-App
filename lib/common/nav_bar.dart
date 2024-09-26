import 'package:baro_project/common/app_bar.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';

class NavBarWidget extends StatelessWidget {
  const NavBarWidget({super.key, required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Scaffold(
        appBar: customAppBar(context),
        body: child,
        bottomNavigationBar: BottomNavigationBar(
          elevation: 10.0,
          unselectedItemColor: Colors.grey,
          selectedItemColor: Colors.black,
          type: BottomNavigationBarType.fixed,
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: FaIcon(FontAwesomeIcons.house, size: 15.0),
              label: 'Main',
            ),
            BottomNavigationBarItem(
              icon: FaIcon(FontAwesomeIcons.calendar, size: 15.0),
              label: 'Calendar',
            ),
            BottomNavigationBarItem(
              icon: FaIcon(FontAwesomeIcons.youtube, size: 15.0),
              label: 'Youtube',
            ),
            BottomNavigationBarItem(
              icon: FaIcon(FontAwesomeIcons.user, size: 15.0),
              label: 'Information',
            ),
          ],
          onTap: (index) => _onItemTapped(index, context),
          currentIndex: _calculateIndex(context),
        ),
      ),
    );
  }

  void _onItemTapped(int index, BuildContext context) {
    switch (index) {
      case 0:
        GoRouter.of(context).go('/main');
        break;
      case 1:
        GoRouter.of(context).go('/calendar');
        break;
      case 2:
        GoRouter.of(context).go('/youtube');
        break;
      case 3:
        GoRouter.of(context).go('/information');
        break;
    }
  }

  int _calculateIndex(BuildContext context) {
    final currentLocation = GoRouterState.of(context).uri.toString();
    if (currentLocation == '/main') {
      return 0;
    }
    if (currentLocation == '/calendar') {
      return 1;
    }
    if (currentLocation == '/youtube') {
      return 2;
    }
    if (currentLocation == '/information') {
      return 3;
    }
    return 0;
  }
}
