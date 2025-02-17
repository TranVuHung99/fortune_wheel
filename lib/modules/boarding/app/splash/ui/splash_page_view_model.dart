import 'package:injectable/injectable.dart';
import 'package:lucid_decision/core/abstracts/app_view_model.dart';
import 'package:lucid_decision/go_router_config.dart';
import 'package:lucid_decision/modules/main/app/ui/main_page.dart';

import 'package:suga_core/suga_core.dart';

@injectable
class SplashPageViewModel extends AppViewModel {
  SplashPageViewModel();

  @override
  void initState() {
    _loadData();
    super.initState();
  }

  Future<Unit> _loadData() async {
    await Future.delayed(const Duration(milliseconds: 500));
    goRouterConfig.goNamed(MainPage.routeName);
    return unit;
  }
}
