import 'package:baro_project/screens/calendar/calendar_screen.dart';
import 'package:baro_project/screens/category/category_screen.dart';
import 'package:baro_project/screens/guide/guide_screen.dart';
import 'package:baro_project/screens/information/information_screen.dart';
import 'package:baro_project/screens/youtube/youtube_screen.dart';
import 'package:baro_project/widgets/nav_bar.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'screens/camera/camera_screen.dart';
import 'screens/login/login_screen.dart';
import 'screens/main/main_screen.dart';
import 'screens/report/report_screen.dart';
import 'screens/result/result_screen.dart';

final GlobalKey<NavigatorState> _rootNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'Root');
final GlobalKey<NavigatorState> _shellNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'Shell');

final router = GoRouter(navigatorKey: _rootNavigatorKey, initialLocation: '/login', routes: <RouteBase>[
  GoRoute(
    path: '/login',
    builder: (context, state) => const Login(),
  ),
  GoRoute(
    path: '/category', 
    builder: (context, state) => const CategoryScreen(),
  ),
  GoRoute(
    path: '/guide',
    builder: (context, state) => const GuideScreen(),
  ),
  GoRoute(
    path: '/camera',
    builder: (context, state) => const CameraScreen(),
  ),
  GoRoute(
    path: '/result',
    builder: (context, state) => const ResultScreen(),
  ),
  GoRoute(
    path: '/report',
    builder: (context, state) => const ReportScreen(),
  ),
  ShellRoute(
    navigatorKey: _shellNavigatorKey,
    builder: (context, state, child) => NavBarWidget(child: child),
    routes: <RouteBase>[
      GoRoute(
        path: '/main',
        pageBuilder: (context, state) => const NoTransitionPage(child: MainScreen()),
      ),
      GoRoute(
        path: '/calendar',
        pageBuilder: (context, state) => const NoTransitionPage(child: CalendarScreen()),
      ),
      GoRoute(
        path: '/youtube',
        pageBuilder: (context, state) => NoTransitionPage(child: YoutubeScreen()),
      ),
      GoRoute(
        path: '/information',
        pageBuilder: (context, state) => const NoTransitionPage(child: InformationScreen())
      ),
    ],
  ),
]);
