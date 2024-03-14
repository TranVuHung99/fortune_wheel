import 'dart:async';
import 'dart:math';

import 'package:flex_color_picker/flex_color_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:injectable/injectable.dart';
import 'package:lucid_decision/core/abtracts/app_view_model.dart';
import 'package:lucid_decision/go_router_config.dart';
import 'package:lucid_decision/modules/main/domain/models/wheel_model.dart';
import 'package:lucid_decision/modules/main/domain/models/wheel_option_model.dart';
import 'package:lucid_decision/modules/main/domain/usecases/add_wheel_usecase.dart';
import 'package:lucid_decision/modules/main/domain/usecases/edit_wheel_usecase.dart';
import 'package:refreshed/get_rx/get_rx.dart';

import 'package:suga_core/suga_core.dart';

@injectable
class WheelCustomizePageViewModel extends AppViewModel {
  final AddWheelUsecase _addWheelUsecase;
  final EditWheelUsecase _editWheelUsecase;

  WheelCustomizePageViewModel(this._addWheelUsecase, this._editWheelUsecase);

  TextEditingController textEditingController = TextEditingController();

  bool isFirstLoaded = true;

  final _isInputWheelEmpty = RxBool(false);

  final _wheelOptions = RxList<WheelOption>([]);

  final _wheelName = RxString("");

  List<WheelOption> get wheelOptions => _wheelOptions.toList();

  bool get isInputWheelEmpty => _isInputWheelEmpty.value;

  bool get isCouldSubmit => wheelOptions.isNotEmpty;

  String get wheelName => _wheelName.value;

  Future<Unit> loadArguments(WheelModel? wheel) async {
    if (wheel != null && wheel.options.isNotEmpty && isFirstLoaded) {
      _wheelOptions.assignAll(wheel.options);
      _wheelName(wheel.name);
      textEditingController.text = wheel.name;
    } else {
      _isInputWheelEmpty(true);
    }
    isFirstLoaded = false;
    return unit;
  }

  Unit addWheelSlice() {
    _wheelOptions.add(WheelOption(color: Random().nextInt(0xffffffff), content: ""));
    return unit;
  }

  Unit onDeleteSlice(int index) {
    _wheelOptions.removeAt(index);
    return unit;
  }

  Unit onEditingContent(String content, int index) {
    _wheelOptions[index] = _wheelOptions[index].copyWith(content: content);
    return unit;
  }

  Unit onEditingTitle(String content) {
    _wheelName(content);
    return unit;
  }

  Future<Unit> onAddWheel() async {
    WheelModel wheel = WheelModel(
      DateTime.now().millisecondsSinceEpoch,
      name: wheelName,
      createdAt: DateTime.now(),
      updateAt: DateTime.now(),
      options: wheelOptions,
    );
    await showLoading();
    await run(
      () async {
        await _addWheelUsecase.run(wheel);
      },
    );
    goRouterConfig.pop();
    await hideLoading();
    return unit;
  }

  Future<Unit> onEditWheel(WheelModel wheel) async {
    await showLoading();
    await run(
      () async {
        await _editWheelUsecase.run(
          wheel.id,
          wheel: wheel,
        );
      },
    );
    await hideLoading();
    return unit;
  }

  onChooseColor(int index, BuildContext context) async {
    final Color newColor = await showColorPickerDialog(
      context,
      Color(wheelOptions[index].color),
      title: Text('ColorPicker', style: Theme.of(context).textTheme.titleLarge),
      width: 40,
      height: 40,
      spacing: 0,
      runSpacing: 0,
      borderRadius: 0,
      wheelDiameter: 165,
      enableOpacity: true,
      colorCodeHasColor: true,
      pickersEnabled: <ColorPickerType, bool>{
        ColorPickerType.wheel: true,
      },
      actionButtons: const ColorPickerActionButtons(
        okButton: true,
        closeButton: true,
        dialogActionButtons: false,
      ),
      constraints: const BoxConstraints(minHeight: 480, minWidth: 320, maxWidth: 480),
    );
    _wheelOptions[index] = _wheelOptions[index].copyWith(color: newColor.value);
  }
}
