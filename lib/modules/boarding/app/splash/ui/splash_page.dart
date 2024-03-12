import 'package:flutter/material.dart';
import 'package:lucid_decision/core/extensions/string_ext.dart';
import 'package:lucid_decision/injector.dart';
import 'package:lucid_decision/locale_keys.g.dart';
import 'package:lucid_decision/modules/boarding/app/splash/ui/splash_page_view_model.dart';
import 'package:suga_core/suga_core.dart';

class SplashPage extends StatefulWidget {
  static String routeName = 'SplashPage';

  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends BaseViewState<SplashPage, SplashPageViewModel> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Text(
          LocaleKeys.app_name.trans(),
        ),
      ),
    );
  }

  @override
  SplashPageViewModel createViewModel() => injector<SplashPageViewModel>();
}
