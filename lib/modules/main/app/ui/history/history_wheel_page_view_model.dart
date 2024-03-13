import 'dart:async';

import 'package:injectable/injectable.dart';
import 'package:lucid_decision/core/abstracts/app_view_model.dart';
import 'package:lucid_decision/modules/main/domain/models/wheel_model.dart';
import 'package:lucid_decision/modules/main/domain/usecases/delete_wheel_usecase.dart';
import 'package:lucid_decision/modules/main/domain/usecases/get_all_wheel_usecase.dart';
import 'package:refreshed/get_rx/get_rx.dart';
import 'package:suga_core/suga_core.dart';

@injectable
class HistoryWheelPageViewModel extends AppViewModel {
  final GetAllWheelUsecase _getAllWheelUsecase;
  final DeleteWheelUsecase _deleteWheelUsecase;

  HistoryWheelPageViewModel(
    this._getAllWheelUsecase,
    this._deleteWheelUsecase,
  );

  final _listWheels = RxList<Wheel>([]);

  List<Wheel> get getListWheels => _listWheels.toList();

  @override
  void initState() {
    _onInit();
    super.initState();
  }

  Future<Unit> _onInit() async {
    await showLoading();
    await loadWheels();
    await hideLoading();

    return unit;
  }

  Future<Unit> loadWheels() async {
    await showLoading();
    await run(() async {
      final data = await _getAllWheelUsecase.run();
      _listWheels.assignAll(data);
    });
    await hideLoading();
    return unit;
  }

  Future<Unit> deleteWheel(int id) async {
    await showLoading();
    await run(() async {
      await _deleteWheelUsecase.run(id);
    });
    await hideLoading();
    return unit;
  }
}
