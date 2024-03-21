import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lucid_decision/injector.dart';
import 'package:lucid_decision/modules/app_setting/app/ui/app_setting_page.dart';
import 'package:lucid_decision/modules/main/app/ui/helpers/tab_bar_helper.dart';
import 'package:lucid_decision/modules/main/app/ui/main_page_view_model.dart';
import 'package:lucid_decision/modules/main/app/ui/home/app/ui/home_page.dart';
import 'package:lucid_decision/modules/main/domain/models/wheel_model.dart';
import 'package:refreshed/refreshed.dart';
import 'package:suga_core/suga_core.dart';

class MainPage extends StatefulWidget {
  static String routeName = 'MainPage';
  final WheelModel? wheel;

  const MainPage({
    super.key,
    this.wheel,
  });

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends BaseViewState<MainPage, MainPageViewModel> with TickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
    viewModel.initTabController(this);
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: TabBarHelper.length,
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.white,
          body: TabBarView(
            controller: viewModel.tabController,
            physics: const NeverScrollableScrollPhysics(),
            children: [
              HomePage(wheel: widget.wheel),
              const AppSettingPage(),
            ],
          ),
          bottomNavigationBar: Obx(
            () => Container(
              color: Colors.grey,
              child: TabBar(
                controller: viewModel.tabController,
                indicatorColor: Colors.white,
                labelPadding: EdgeInsets.zero,
                tabs: [
                  Tab(
                    icon: Icon(
                      Icons.home,
                      size: 24.sp,
                      color: viewModel.pageIndex == TabBarHelper.homeIndex ? Colors.white : Colors.black,
                    ),
                  ),
                  Tab(
                    icon: Icon(
                      Icons.settings,
                      size: 24.sp,
                      color: viewModel.pageIndex == TabBarHelper.listWheelIndex ? Colors.white : Colors.black,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  MainPageViewModel createViewModel() => injector<MainPageViewModel>();
}
