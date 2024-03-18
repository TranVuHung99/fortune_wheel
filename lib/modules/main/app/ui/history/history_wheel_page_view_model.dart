import 'dart:async';

import 'package:event_bus/event_bus.dart';
import 'package:injectable/injectable.dart';
import 'package:lucid_decision/core/abstracts/app_view_model.dart';
import 'package:lucid_decision/modules/main/domain/events/on_delete_wheel_event.dart';
import 'package:lucid_decision/modules/main/domain/events/on_done_editing_wheel_event.dart';
import 'package:lucid_decision/modules/main/domain/models/wheel_model.dart';
import 'package:lucid_decision/modules/main/domain/usecases/delete_wheel_usecase.dart';
import 'package:lucid_decision/modules/main/domain/usecases/get_all_wheel_usecase.dart';
import 'package:refreshed/get_rx/get_rx.dart';
import 'package:suga_core/suga_core.dart';

@injectable
class HistoryWheelPageViewModel extends AppViewModel {
  final GetAllWheelUsecase _getAllWheelUsecase;
  final DeleteWheelUsecase _deleteWheelUsecase;
  final EventBus _eventBus;

  HistoryWheelPageViewModel(
    this._getAllWheelUsecase,
    this._deleteWheelUsecase,
    this._eventBus,
  );

  final _listWheels = RxList<WheelModel>([]);

  List<WheelModel> get getListWheels => _listWheels.toList();

  StreamSubscription? _editWheelEventListener;

  StreamSubscription? _deleteWheelEventListener;

  void _registerEvent() {
    _editWheelEventListener = _eventBus.on<OnDoneEditingWheelEvent>().listen((event) => loadWheels(isShowLoading: false));
    _deleteWheelEventListener = _eventBus.on<OnDeleteWheelEvent>().listen((event) => loadWheels(isShowLoading: false));
  }

  @override
  void initState() {
    _onInit();
    super.initState();
  }

  @override
  void disposeState() {
    _editWheelEventListener?.cancel();
    _deleteWheelEventListener?.cancel();
    super.disposeState();
  }

  Future<Unit> _onInit() async {
    _registerEvent();
    await loadWheels();
    return unit;
  }

  Future<Unit> loadWheels({bool isShowLoading = true}) async {
    if (isShowLoading) {
      await showLoading();
    }
    await run(() async {
      final data = await _getAllWheelUsecase.run();
      _listWheels.assignAll(data);
    });
    if (isShowLoading) {
      await hideLoading();
    }
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
