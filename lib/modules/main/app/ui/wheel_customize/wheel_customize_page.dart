import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:lucid_decision/injector.dart';
import 'package:lucid_decision/modules/helpers/position_retained_scroll_physics.dart';
import 'package:lucid_decision/modules/main/app/ui/wheel_customize/wheel_customize_page_view_model.dart';
import 'package:lucid_decision/modules/main/app/ui/wheel_customize/widgets/wheel_slice_item_widget.dart';
import 'package:lucid_decision/modules/main/domain/models/wheel_model.dart';
import 'package:refreshed/get_state_manager/get_state_manager.dart';
import 'package:suga_core/suga_core.dart';

class WheelCustomizePage extends StatefulWidget {
  static String routeName = 'WheelCustomizePage';
  final WheelModel? wheel;
  final bool isAddNewWheel;
  const WheelCustomizePage({super.key, this.wheel, required this.isAddNewWheel});

  @override
  State<WheelCustomizePage> createState() => _WheelCustomizePageState();
}

class _WheelCustomizePageState extends BaseViewState<WheelCustomizePage, WheelCustomizePageViewModel> {
  @override
  WheelCustomizePageViewModel createViewModel() => injector<WheelCustomizePageViewModel>();

  @override
  void loadArguments() {
    viewModel.loadArguments(widget.wheel, widget.isAddNewWheel);
    super.loadArguments();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          GestureDetector(
            onTap: () => viewModel.addWheelSlice(),
            child: Padding(
              padding: EdgeInsets.only(right: 15.w),
              child: const Icon(Icons.add),
            ),
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            margin: EdgeInsets.symmetric(horizontal: 99.w),
            padding: EdgeInsets.symmetric(horizontal: 8.w),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.r),
              border: Border.all(color: Colors.black, width: 2),
            ),
            child: TextField(
              decoration: const InputDecoration(
                hintText: "What should i do today?",
                border: InputBorder.none,
              ),
              controller: viewModel.textEditingController,
              onChanged: viewModel.onEditingTitle,
            ),
          ),
          SizedBox(
            height: 27.h,
          ),
          Expanded(
            child: Obx(
              () => CustomScrollView(
                physics: const PositionRetainedScrollPhysics(),
                slivers: [
                  SliverList.builder(
                    key: Key(viewModel.wheelOptions.length.toString()),
                    itemCount: viewModel.wheelOptions.length,
                    itemBuilder: (context, index) => WheelSliceItemWidget(
                      wheelOption: viewModel.wheelOptions.elementAt(index),
                      onDeleteSlice: () => viewModel.onDeleteSlice(index),
                      onChooseColor: () => viewModel.onChooseColor(index, context),
                      onEditingText: (content) => viewModel.onEditingContent(content, index),
                    ),
                  )
                ],
              ),
            ),
          ),
          Obx(
            () => Visibility(
              visible: viewModel.isCouldSubmit,
              child: GestureDetector(
                onTap: ()  {
                  widget.wheel != null ? viewModel.onEditWheel(widget.wheel!) : viewModel.onAddWheel();
                   context.pop();
                },
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 16.h),
                  margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 27.h),
                  decoration: const BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.all(Radius.circular(4)),
                  ),
                  child: Center(
                    child: Text(
                      "DONE",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
