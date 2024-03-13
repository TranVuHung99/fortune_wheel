import 'package:flutter/material.dart';
import 'package:lucid_decision/injector.dart';
import 'package:lucid_decision/modules/main/app/ui/history/history_wheel_page_view_model.dart';
import 'package:lucid_decision/modules/main/app/ui/history/widgets/wheel_item.widget.dart';
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
              onPressed: () {
                /// Navigate to add page without wheel param
              },
              icon: const Icon(
                Icons.add,
                color: Colors.black,
              )),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: Obx(
              () => RefreshIndicator(
                child: ListView.builder(
                  itemBuilder: (_, id) => WheelItemWidget(
                    wheel: viewModel.getListWheels[id],
                    onDelete: () {
                      viewModel.deleteWheel(id);
                    },
                  ),
                  itemCount: viewModel.getListWheels.length,
                ),
                onRefresh: () async => viewModel.loadWheels(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
