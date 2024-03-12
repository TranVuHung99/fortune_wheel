import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lucid_decision/modules/boarding/app/splash/ui/splash_page.dart';
import 'package:lucid_decision/modules/home/app/ui/home_page.dart';

final rootNavigatorKey = GlobalKey<NavigatorState>();

final GoRouter goRouterConfig = GoRouter(
  navigatorKey: rootNavigatorKey,
  initialLocation: '/',
  debugLogDiagnostics: false,
  routes: <RouteBase>[
    GoRoute(
      name: SplashPage.routeName,
      path: '/',
      builder: (BuildContext context, GoRouterState state) {
        return const SplashPage();
      },
    ),
    GoRoute(
      name: HomePage.routeName,
      path: '/${HomePage.routeName}',
      builder: (BuildContext context, GoRouterState state) {
        return const HomePage();
      },
    ),
  ],
);
