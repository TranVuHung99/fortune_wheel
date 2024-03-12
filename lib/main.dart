import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lucid_decision/go_router_config.dart';
import 'package:lucid_decision/injector.dart';
import 'package:lucid_decision/theme/ui_theme.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await setupInjector();
  runApp(
    EasyLocalization(
      supportedLocales: const [Locale('en'), Locale('vi')],
      path: 'resources/langs',
      useOnlyLangCode: true,
      fallbackLocale: const Locale('en'),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      builder: (context, child) => MaterialApp.router(
        theme: uiTheme,
        debugShowCheckedModeBanner: false,
        localizationsDelegates: context.localizationDelegates,
        supportedLocales: context.supportedLocales,
        locale: context.locale,
        title: "Lucid Decision",
        builder: (BuildContext context, Widget? child) => MediaQuery(
          data: MediaQuery.of(context).copyWith(textScaler: const TextScaler.linear(1)),
          child: FlutterEasyLoading(child: child),
        ),
        routerConfig: goRouterConfig,
      ),
    );
  }
}
