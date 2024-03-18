import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:lucid_decision/core/abstracts/app_view_model.dart';
import 'package:lucid_decision/modules/main/app/ui/helpers/tab_bar_helper.dart';
import 'package:refreshed/get_rx/get_rx.dart';

@injectable
class MainPageViewModel extends AppViewModel {
  MainPageViewModel();

  final RxInt _pageIndex = RxInt(TabBarHelper.homeIndex);

  int get pageIndex => _pageIndex.value;

  set pageIndex(int value) {
    _pageIndex.value = value;
    tabController.animateTo(pageIndex);
  }

  late TabController tabController;

  void initTabController(TickerProviderStateMixin providerStateMixin) {
    tabController = TabController(vsync: providerStateMixin, length: TabBarHelper.length, initialIndex: _pageIndex.value);
    tabController.addListener(() {
      _pageIndex.value = tabController.index;
    });
  }
}
