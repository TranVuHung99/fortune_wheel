import 'dart:async';

import 'package:lucid_decision/core/helper/loading_helper.dart';
import 'package:lucid_decision/core/helper/ui_helper.dart';
import 'package:lucid_decision/injector.dart';
import 'package:suga_core/suga_core.dart';

abstract class AppViewModel extends BaseViewModel {
  Future<Unit> showLoading() async {
    await injector<LoadingHelper>().showLoading();
    return unit;
  }

  Future<Unit> hideLoading() async {
    await injector<LoadingHelper>().hideLoading();
    return unit;
  }

  @override
  Future<Unit> handleError(dynamic error) async {
    // if (error is RestError) {
    //   final errorCode = error.getHeader(BackendConfig.errorCodeResponseHeader);
    //   await handleRestError(error, errorCode);
    // } else {
    //   showToast(error.toString());
    // }
    showToast(error.toString());
    return unit;
  }

}
