import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:lucid_decision/core/helpers/toast_helper.dart';
import 'package:suga_core/suga_core.dart';

abstract class AppViewModel extends BaseViewModel {
  Future<Unit> showLoading() async {
    await EasyLoading.show();
    return unit;
  }

  Future<Unit> hideLoading() async {
    await EasyLoading.dismiss();
    return unit;
  }

  @override
  Future<Unit> handleError(dynamic error) async {
    showToast(error.toString());
    return unit;
  }
}
