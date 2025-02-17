import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:lucid_decision/core/extensions/string_ext.dart';
import 'package:lucid_decision/core/helper/ui_helper.dart';
import 'package:lucid_decision/gen/assets.gen.dart';
import 'package:lucid_decision/go_router_config.dart';
import 'package:lucid_decision/injector.dart';
import 'package:lucid_decision/locale_keys.g.dart';
import 'package:lucid_decision/modules/main/app/ui/history/history_wheel_page.dart';
import 'package:lucid_decision/modules/main/app/ui/home/app/ui/home_page_view_model.dart';
import 'package:lucid_decision/modules/main/app/ui/wheel/core/core.dart';
import 'package:lucid_decision/modules/main/app/ui/wheel/core/fortune_item.dart';
import 'package:lucid_decision/modules/main/app/ui/wheel/core/styling.dart';
import 'package:lucid_decision/modules/main/app/ui/wheel/indicators/indicators.dart';
import 'package:lucid_decision/modules/main/app/ui/wheel/indicators/shared.dart';
import 'package:lucid_decision/modules/main/app/ui/wheel/wheel/wheel.dart';
import 'package:lucid_decision/modules/main/app/ui/wheel_customize/wheel_customize_page.dart';
import 'package:lucid_decision/modules/main/domain/models/wheel_model.dart';
import 'package:lucid_decision/theme/ui_text_style.dart';
import 'package:refreshed/refreshed.dart';
import 'package:suga_core/suga_core.dart';
import 'dart:ui' as ui;

class HomePage extends StatefulWidget {
  static String routeName = 'HomePage';
  final WheelModel? wheel;

  const HomePage({
    super.key,
    this.wheel,
  });

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends BaseViewState<HomePage, HomePageViewModel> with AutomaticKeepAliveClientMixin {

  @override
  void loadArguments() {
    viewModel.loadArguments(widget.wheel);
    super.loadArguments();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return SafeArea(
      child: Obx(
        () => Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: AppBar(
            primary: false,
            elevation: 0.0,
            backgroundColor: Colors.white,
            automaticallyImplyLeading: false,
            actions: [
              GestureDetector(
                onTap: () => goRouterConfig.pushNamed(HistoryWheelPage.routeName),
                child: Icon(
                  Icons.history,
                  size: 24.sp,
                  color: Colors.black,
                ),
              ),
              SizedBox(width: 15.w),
              GestureDetector(
                onTap: () => context.goNamed(WheelCustomizePage.routeName),
                child: Icon(
                  Icons.add,
                  size: 24.sp,
                  color: Colors.black,
                ),
              ),
              SizedBox(width: 15.w),
            ],
          ),
          backgroundColor: Colors.white,
          body: viewModel.currentWheel != null
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [

                    SizedBox(height: 40.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          height: 32.h,
                          constraints: BoxConstraints(
                            maxWidth: 300.w,
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.r),
                            color: Colors.white,
                            border: Border.all(width: 1.w, color: Colors.black),
                          ),
                          margin: EdgeInsets.symmetric(horizontal: 20.w),
                          padding: EdgeInsets.symmetric(horizontal: 15.w),
                          child: Text(
                            viewModel.currentWheel!.name,
                            style: UITextStyle.black_18_bold,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 40.h),
                    Stack(
                      alignment: Alignment.center,
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 5.h),
                          height: 400.h,
                          child: FortuneWheel(
                            selected: viewModel.streamController.stream,
                            animateFirst: false,
                            indicators: <FortuneIndicator>[
                              FortuneIndicator(
                                alignment: Alignment.topCenter,
                                child: TriangleIndicator(
                                  color: Colors.black,
                                  width: 40.w,
                                  height: 40.h,
                                ),
                              ),
                            ],
                            items: [
                              for (final (id, option) in viewModel.currentWheel!.options.indexed)
                                FortuneItem(
                                  ratio: option.ratio ?? 1,
                                  child: Container(
                                    constraints: BoxConstraints(maxHeight: 50.h),
                                    margin: EdgeInsets.only(left: 50.w, right: 5.w),
                                    child: RichText(text: displayEmoji(option.content),)
                                  ),
                                  style: FortuneItemStyle(
                                    color: Color(option.color),
                                    borderColor: Colors.white,
                                    textAlign: TextAlign.start,
                                    textStyle: UITextStyle.black_18_bold,
                                    image: viewModel.listOptionBackgrounds[id]
                                  ),
                                ),
                            ],
                            onAnimationEnd: () {
                              viewModel.setResultLabel = viewModel.currentWheel!.options[viewModel.streamController.value].content;
                              viewModel.isShowResult = true;
                            },
                            onAnimationStart: () {
                              viewModel.isShowResult = false;
                            },
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            viewModel.streamController.value = Random().nextInt(viewModel.currentWheel!.options.length);
                          },
                          child: Container(
                            alignment: Alignment.center,
                            width: 80.w,
                            height: 80.h,
                            padding: EdgeInsets.symmetric(horizontal: 5.w),
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.black,
                            ),
                            child: Text(
                              LocaleKeys.start.trans(),
                              style: UITextStyle.white_14,
                              textAlign: TextAlign.center,
                            ),
                          ),
                        )
                      ],
                    ),
                    Visibility(
                      visible: viewModel.isShowResult,
                      child: Container(
                        constraints: BoxConstraints(
                          maxWidth: 300.w,
                          maxHeight: 200.h,
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.r),
                          color: Colors.black,
                          border: Border.all(width: 1.w, color: Colors.white),
                        ),
                        margin: EdgeInsets.symmetric(horizontal: 20.w),
                        padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 5.h),
                        child: Text(
                          viewModel.resultLabel,
                          style: UITextStyle.white_18_bold,
                        ),
                      ),
                    ),
                    SizedBox(height: 8.h),
                    Visibility(
                      visible: viewModel.isShowResult,
                      child: Container(
                        constraints: BoxConstraints(
                          maxWidth: 300.w,
                          maxHeight: 200.h,
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.r),
                          color: Colors.black,
                          border: Border.all(width: 1.w, color: Colors.white),
                        ),
                        margin: EdgeInsets.symmetric(horizontal: 20.w),
                        padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 5.h),
                        child: Text(
                          LocaleKeys.share.trans(),
                          style: UITextStyle.white_18_bold,
                        ),
                      ),
                    ),
                  ],
                )
              : Container(),
          floatingActionButton: viewModel.currentWheel == null
              ? Container()
              : GestureDetector(
                  onTap: () => context.goNamed(WheelCustomizePage.routeName, extra: viewModel.currentWheel),
                  child: Container(
                    alignment: Alignment.center,
                    width: 60.w,
                    height: 60.h,
                    padding: EdgeInsets.symmetric(horizontal: 5.w),
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.black,
                    ),
                    child: Text(
                      LocaleKeys.edit.trans(),
                      style: UITextStyle.white_14,
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
        ),
      ),
    );
  }

  @override
  HomePageViewModel createViewModel() => injector<HomePageViewModel>();

  @override
  bool get wantKeepAlive => true;
}
