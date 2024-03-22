import 'dart:async';
import 'dart:math';

import 'package:flex_color_picker/flex_color_picker.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:lucid_decision/core/abstracts/app_view_model.dart';
import 'package:lucid_decision/core/helper/ui_helper.dart';
import 'package:lucid_decision/go_router_config.dart';
import 'package:lucid_decision/modules/main/domain/models/wheel_entity.dart';
import 'package:lucid_decision/modules/main/domain/models/wheel_model.dart';
import 'package:lucid_decision/modules/main/domain/models/wheel_option_model.dart';
import 'package:lucid_decision/modules/main/domain/usecases/add_wheel_usecase.dart';
import 'package:lucid_decision/modules/main/domain/usecases/edit_wheel_usecase.dart';
import 'package:refreshed/refreshed.dart';
import 'package:lucid_decision/core/extensions/context_ext.dart';

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

  Future<Unit> loadArguments(WheelModel? wheel, bool isAddNewWheel) async {
    if (wheel != null && wheel.options.isNotEmpty && isFirstLoaded) {
      _wheelOptions.assignAll(wheel.options);
      _wheelName(wheel.name);
      textEditingController.text = wheel.name;
    } else {
      if (isAddNewWheel && isFirstLoaded) {
        addRandomInitWheel(2);
      }
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
    if(wheelOptions.length <=  1) {
      showToast("Please add more options");
      return unit;
    }
    await showLoading();
    await run(
      () async {
        await _addWheelUsecase.run(name: wheelName, option: wheelOptions);
      },
    );
    goRouterConfig.routerDelegate.navigatorKey.currentContext?.hideKeyboard();
    await hideLoading();
    return unit;
  }

  Future<Unit> onEditWheel(WheelModel wheel) async {
    if(wheelOptions.length <=  1) {
      showToast("Please add more options");
      return unit;
    }
    await showLoading();
    WheelModel newWheel = wheel.copyWithModel(options: wheelOptions, name: wheelName, updateAt: DateTime.now());
    await run(
      () async {
        await _editWheelUsecase.run(
          newWheel.id,
          wheel: newWheel,
        );
      },
    );
    goRouterConfig.routerDelegate.navigatorKey.currentContext?.hideKeyboard();
    await hideLoading();
    goRouterConfig.pop();
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

  void addRandomInitWheel(int times) {
    do {
      _wheelOptions.add(WheelOption(color: Random().nextInt(0xffffffff), content: ""));
    } while (_wheelOptions.length < times);
  }
}
