import 'package:baro_project/screens/calendar_screen.dart';
import 'package:baro_project/screens/camera_page.dart';
import 'package:baro_project/screens/info_screen.dart';
import 'package:baro_project/screens/youtube_screen.dart';
import 'package:baro_project/widgets/nav_bar.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'screens/login_screen.dart';
import 'screens/main_screen.dart';
import 'screens/noti_screen.dart';

final GlobalKey<NavigatorState> _rootNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'Root');
final GlobalKey<NavigatorState> _shellNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'Shell');

final router = GoRouter(navigatorKey: _rootNavigatorKey, initialLocation: '/login', routes: <RouteBase>[
  GoRoute(
    path: '/login',
    builder: (context, state) => const Login(),
  ),
  GoRoute(
    path: '/camera',
    builder: (context, state) => const CameraPage(),
  ),
  GoRoute(
    path: '/notification',
    builder: (context, state) => const NotificationManager(),
  ),
  ShellRoute(
    navigatorKey: _shellNavigatorKey,
    builder: (context, state, child) => NavBarWidget(child: child),
    routes: <RouteBase>[
      GoRoute(
        path: '/main',
        builder: (context, state) => const MainScreen(),
      ),
      GoRoute(
        path: '/calendar',
        builder: (context, state) => const CalendarScreen(),
      ),
      GoRoute(
        path: '/youtube',
        builder: (context, state) => const YoutubeScreen(),
      ),
      GoRoute(
        path: '/information',
        builder: (context, state) => const InformationScreen(),
      ),
    ],
  ),
]);
