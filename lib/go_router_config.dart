import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lucid_decision/modules/app_setting/app/ui/app_setting_page.dart';
import 'package:lucid_decision/modules/boarding/app/splash/ui/splash_page.dart';
import 'package:lucid_decision/modules/main/app/ui/history/history_wheel_page.dart';
import 'package:lucid_decision/modules/main/app/ui/main_page.dart';
import 'package:lucid_decision/modules/main/app/ui/home/app/ui/home_page.dart';
import 'package:lucid_decision/modules/main/app/ui/wheel_customize/wheel_customize_page.dart';
import 'package:lucid_decision/modules/main/domain/models/wheel_model.dart';

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
      name: MainPage.routeName,
      path: '/${MainPage.routeName}',
      builder: (BuildContext context, GoRouterState state) {
        return MainPage(wheel: state.extra as WheelModel?);
      },
      routes: [
        GoRoute(
          name: HomePage.routeName,
          path: HomePage.routeName,
          builder: (BuildContext context, GoRouterState state) {
            return HomePage(wheel: state.extra as WheelModel?);
          },
        ),
        GoRoute(
          name: HistoryWheelPage.routeName,
          path: HistoryWheelPage.routeName,
          builder: (BuildContext context, GoRouterState state) {
            return const HistoryWheelPage();
          },
        ),
        GoRoute(
          name: WheelCustomizePage.routeName,
          path: WheelCustomizePage.routeName,
          builder: (BuildContext context, GoRouterState state) {
            return WheelCustomizePage(
              wheel: state.extra as WheelModel?,
              isAddNewWheel: state.uri.queryParameters["isAddNewWheel"] == "true",
            );
          },
        ),
        GoRoute(
          name: AppSettingPage.routeName,
          path: AppSettingPage.routeName,
          builder: (BuildContext context, GoRouterState state) {
            return const AppSettingPage();
          },
        ),
      ],
    ),
  ],
);
