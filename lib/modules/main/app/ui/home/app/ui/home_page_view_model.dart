import 'dart:async';

import 'package:event_bus/event_bus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:injectable/injectable.dart';
import 'package:lucid_decision/core/abstracts/app_view_model.dart';
import 'package:lucid_decision/gen/assets.gen.dart';
import 'package:lucid_decision/modules/main/domain/events/on_add_wheel_event.dart';
import 'package:lucid_decision/modules/main/domain/events/on_delete_wheel_event.dart';
import 'package:lucid_decision/modules/main/domain/events/on_done_editing_wheel_event.dart';
import 'package:lucid_decision/modules/main/domain/models/wheel_model.dart';
import 'package:lucid_decision/modules/main/domain/models/wheel_option_model.dart';
import 'package:lucid_decision/modules/main/domain/usecases/add_wheel_usecase.dart';
import 'package:lucid_decision/modules/main/domain/usecases/get_all_wheel_usecase.dart';
import 'package:lucid_decision/modules/main/domain/usecases/get_wheel_by_id_usecase.dart';
import 'package:refreshed/get_rx/get_rx.dart';
import 'dart:ui' as ui;

import 'package:suga_core/suga_core.dart';

@injectable
class HomePageViewModel extends AppViewModel {
  final GetAllWheelUsecase _getAllWheelUsecase;
  final AddWheelUsecase _addWheelUsecase;
  final GetWheelByIdUsecase _getWheelByIdUsecase;
  final EventBus _eventBus;

  HomePageViewModel(
    this._getAllWheelUsecase,
    this._addWheelUsecase,
    this._getWheelByIdUsecase,
    this._eventBus,
  );

  Rx<int> streamController = 0.obs;

  final _listOptionBackgrounds = RxList<ui.Image?>([]);

  final _resultLabel = "".obs;

  String get resultLabel => _resultLabel.value;

  set setResultLabel(String value) => _resultLabel.value = value;

  final RxBool _isShowResult = RxBool(false);

  bool get isShowResult => _isShowResult.value;

  List<ui.Image?> get listOptionBackgrounds => _listOptionBackgrounds.toList();

  set isShowResult(bool value) => _isShowResult.value = value;

  final _currentWheel = Rx<WheelModel?>(null);

  WheelModel? get currentWheel => _currentWheel.value;

  StreamSubscription? _editWheelEventListener;

  StreamSubscription? _deleteWheelEventListener;

  StreamSubscription? _addWheelEventListener;

  @override
  void initState() {
    _loadData();
    super.initState();
  }

  Future<Unit> _loadOptionsBackground(List<WheelOption> options) async {
    List<ui.Image?> loaded = [];
    for(final opt in options) {
      final image = await _loadImageFromAssets(opt.background);
      loaded.add(image);
    }
    _listOptionBackgrounds.assignAll(loaded);
    return unit;
  }

  Future<ui.Image?> _loadImageFromAssets(String? path) async {
    if(path == null) return null;
    final ByteData assetImageByteData = await rootBundle.load("resources/images/test.png");
    final codec = await ui.instantiateImageCodec(
      assetImageByteData.buffer.asUint8List(),
    );
    final imageInfo = await codec.getNextFrame();

    return imageInfo.image;
  }

  @override
  void disposeState() {
    streamController.close();
    _editWheelEventListener?.cancel();
    _addWheelEventListener?.cancel();
    _deleteWheelEventListener?.cancel();
    super.disposeState();
  }

  Future<Unit> _loadData() async {
    _registerEvent();
    await _getWheels();
    return unit;
  }

  Future<Unit> loadArguments(WheelModel? wheel) async {
    if (wheel != null) {
      _currentWheel.value = wheel;
    }
    return unit;
  }

  Future<Unit> _getWheels({bool isAddDefaultWheel = true}) async {
    await showLoading();
    late List<WheelModel> fetchedWheels;
    await run(() async => fetchedWheels = await _getAllWheelUsecase.run());
    if (fetchedWheels.isNotEmpty) {
      _currentWheel.value = fetchedWheels.last;
    } else {
      if (isAddDefaultWheel) {
        await _addDefaultWheel();
      } else {
        _currentWheel.value = null;
      }
    }
    if(currentWheel != null){
      await _loadOptionsBackground(currentWheel!.options);
    }
    await hideLoading();
    return unit;
  }

  Future<Unit> _addDefaultWheel() async {
    final defaultOption = <WheelOption>[
      WheelOption(content: "Work", color: Colors.red.value, ratio: 2),
      WheelOption(content: "School", color: Colors.blue.value),
      WheelOption(content: "Gym", color: Colors.yellow.value),
      WheelOption(content: "Sport", color: Colors.green.value),
      WheelOption(content: "Sleep", color: Colors.amber.value),
      WheelOption(content: "Run", color: Colors.purple.value),
      WheelOption(content: "Clean", color: Colors.lightGreenAccent.value),
      WheelOption(content: "Shoping", color: Colors.orange.value),
    ];
    const name = "What should i do today?";
    await run(() async {
      final addedId = await _addWheelUsecase.run(
        name: name,
        option: defaultOption,
      );
    });
    return unit;
  }

  Future<Unit> getWheelById(int id) async {
    await showLoading();
    await run(() async {
      final wheelAdd = await _getWheelByIdUsecase.run(id);
      _currentWheel.value = wheelAdd;
    });
    await hideLoading();
    return unit;
  }

  void _registerEvent() {
    _editWheelEventListener = _eventBus.on<OnDoneEditingWheelEvent>().listen((event) {
      _currentWheel.value = event.wheel;
      _isShowResult.value = false;
    });
    _addWheelEventListener = _eventBus.on<OnAddWheelEvent>().listen((event) {
      getWheelById(event.wheelId);
      _isShowResult.value = false;
    });
    _deleteWheelEventListener = _eventBus.on<OnDeleteWheelEvent>().listen((event) {
      Future.delayed(const Duration(milliseconds: 500));
      _getWheels(isAddDefaultWheel: false);
    });
  }
}
