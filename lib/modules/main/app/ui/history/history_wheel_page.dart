import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lucid_decision/injector.dart';
import 'package:lucid_decision/modules/main/app/ui/history/history_wheel_page_view_model.dart';
import 'package:lucid_decision/modules/main/app/ui/history/widgets/wheel_item.widget.dart';
import 'package:lucid_decision/modules/main/app/ui/main_page.dart';
import 'package:lucid_decision/modules/main/app/ui/wheel_customize/wheel_customize_page.dart';
import 'package:refreshed/get_state_manager/get_state_manager.dart';
import 'package:suga_core/suga_core.dart';

class HistoryWheelPage extends StatefulWidget {
  static String routeName = "HistoryWheelPage";
  const HistoryWheelPage({super.key});

  @override
  State<HistoryWheelPage> createState() => _HistoryWheelState();
}

class _HistoryWheelState extends BaseViewState<HistoryWheelPage, HistoryWheelPageViewModel> {
  @override
  HistoryWheelPageViewModel createViewModel() => injector<HistoryWheelPageViewModel>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        automaticallyImplyLeading: true,
        title: const Text(
          "History Wheel",
          style: TextStyle(),
        ),
        actions: [
          IconButton(
            onPressed: () => context.goNamed(WheelCustomizePage.routeName),
            icon: const Icon(Icons.add, color: Colors.black),
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: Obx(
              () => RefreshIndicator(
                child: ListView.builder(
                  itemBuilder: (_, index) => WheelItemWidget(
                    wheel: viewModel.getListWheels[index],
                    onClick: () => context.goNamed(MainPage.routeName, extra: viewModel.getListWheels[index]),
                    onDelete: () => viewModel.deleteWheel(viewModel.getListWheels[index].id),
                    onEdit: () => context.pushNamed(WheelCustomizePage.routeName, extra: viewModel.getListWheels[index]),
                  ),
                  itemCount: viewModel.getListWheels.length,
                ),
                onRefresh: () async => viewModel.loadWheels(isShowLoading: false),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
