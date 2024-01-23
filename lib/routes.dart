import 'package:baro_project/screens/calendar_screen.dart';
import 'package:baro_project/screens/category_screen.dart';
import 'package:baro_project/screens/guide_screen.dart';
import 'package:baro_project/screens/info_screen.dart';
import 'package:baro_project/screens/youtube_screen.dart';
import 'package:baro_project/widgets/nav_bar.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'screens/camera_screen.dart';
import 'screens/login_screen.dart';
import 'screens/main_screen.dart';
import 'screens/noti_screen.dart';
import 'screens/result_screen.dart';

final GlobalKey<NavigatorState> _rootNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'Root');
final GlobalKey<NavigatorState> _shellNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'Shell');

final router = GoRouter(navigatorKey: _rootNavigatorKey, initialLocation: '/login', routes: <RouteBase>[
  GoRoute(
    path: '/login',
    builder: (context, state) => const Login(),
  ),
  GoRoute(
    path: '/notification',
    builder: (context, state) => const NotificationManager(),
  ),
  GoRoute(path: '/category', builder: (context, state) => const CategoryScreen(), routes: [
    GoRoute(
      path: 'guide',
      builder: (context, state) => const GuideScreen(),
      routes: [
        GoRoute(
          path: 'camera',
          builder: (context, state) => const CameraScreen(),
          routes: [
            GoRoute(
              path: 'result',
              builder: (context, state) => const ResultScreen(),
            ),
          ],
        )
      ]
    ),
  ]),
  ShellRoute(
    navigatorKey: _shellNavigatorKey,
    builder: (context, state, child) => NavBarWidget(child: child),
    // pageBuilder: (context, state, child) {
    //   return NoTransitionPage(
    //     child: NavBarWidget(child: child),
    //   );
    // },
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
        pageBuilder: (context, state) => const NoTransitionPage(child: YoutubeScreen()),
      ),
      GoRoute(
        path: '/information',
        pageBuilder: (context, state) => const NoTransitionPage(child: InformationScreen())
      ),
    ],
  ),
]);
