import 'dart:async';

import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:lucid_decision/core/abtracts/app_view_model.dart';
import 'package:lucid_decision/modules/main/domain/models/wheel_model.dart';
import 'package:lucid_decision/modules/main/domain/models/wheel_option_model.dart';
import 'package:lucid_decision/modules/main/domain/usecases/add_wheel_usecase.dart';
import 'package:lucid_decision/modules/main/domain/usecases/get_all_wheel_usecase.dart';
import 'package:refreshed/get_rx/get_rx.dart';

import 'package:suga_core/suga_core.dart';

@injectable
class HomePageViewModel extends AppViewModel {
  final GetAllWheelUsecase _getAllWheelUsecase;
  final AddWheelUsecase _addWheelUsecase;

  HomePageViewModel(
    this._getAllWheelUsecase,
    this._addWheelUsecase,
  );

  Rx<int> streamController = 0.obs;

  final _resultLabel = "".obs;

  String get resultLabel => _resultLabel.value;

  set setResultLabel(String value) => _resultLabel.value = value;

  final RxBool _isShowResult = RxBool(true);

  bool get isShowResult => _isShowResult.value;

  set isShowResult(bool value) => _isShowResult.value = value;

  final _currentWheel = Rx<WheelModel?>(null);

  WheelModel? get currentWheel => _currentWheel.value;

  final _wheels = RxList<WheelModel>([]);

  List<WheelModel> get wheels => _wheels.value;

  @override
  void initState() {
    _loadData();
    super.initState();
  }

  @override
  void disposeState() {
    streamController.close();
    super.disposeState();
  }

  Future<Unit> _loadData() async {
    await _getAllWheel();
    await _savedDefaultWheel();
    return unit;
  }

  Future<Unit> _getAllWheel() async {
    late List<WheelModel> fetchedWheels;
    await showLoading();
    final success = await run(
      () async {
        fetchedWheels = await _getAllWheelUsecase.run();
      },
    );
    await hideLoading();
    if (success) {
      wheels.assignAll(fetchedWheels);
    }
    return unit;
  }

  Future<Unit> _savedDefaultWheel() async {
    if (wheels.isNotEmpty) {
      _currentWheel.value = wheels.last;
    } else {
      final success = await run(() async {
        await _addWheelUsecase.run(getDefaultWheel);
      });
      if (success) {
        _currentWheel.value = getDefaultWheel;
      }
    }
    return unit;
  }

  WheelModel get getDefaultWheel => WheelModel(
        DateTime.now().millisecondsSinceEpoch,
        name: "What should i do today?",
        createdAt: DateTime.now(),
        updateAt: DateTime.now(),
        options: <WheelOption>[
          WheelOption(content: "Work", color: Colors.red.value),
          WheelOption(content: "School", color: Colors.blue.value),
          WheelOption(content: "Gym", color: Colors.yellow.value),
          WheelOption(content: "Sport", color: Colors.green.value),
          WheelOption(content: "Sleep", color: Colors.amber.value),
          WheelOption(content: "Run", color: Colors.purple.value),
          WheelOption(content: "Clean", color: Colors.lightGreenAccent.value),
          WheelOption(content: "Shoping", color: Colors.orange.value),
        ],
      );
}
