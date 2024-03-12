import 'dart:async';

import 'package:injectable/injectable.dart';
import 'package:lucid_decision/core/abtracts/app_view_model.dart';
import 'package:refreshed/get_rx/get_rx.dart';

import 'package:suga_core/suga_core.dart';

@injectable
class HomePageViewModel extends AppViewModel {
  HomePageViewModel();

  Rx<int> streamController = 0.obs;

  final _resultLabel = "".obs;

  String get resultLabel => _resultLabel.value;

  set setResultLabel(String value) => _resultLabel.value = value;

  final RxBool _isStarting = RxBool(false);

  bool get isStarting => _isStarting.value;

  final items = <String>[
    'Lam viec',
    'Ngu',
    'Choi Game',
    'Di dao',
    'Nau an',
    'Choi the thao',
    'Hen ho',
    'Tap ta',
  ];

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
    return unit;
  }
}
