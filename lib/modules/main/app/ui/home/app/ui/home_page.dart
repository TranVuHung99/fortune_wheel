import 'package:flutter/material.dart';
import 'package:flutter_fortune_wheel/flutter_fortune_wheel.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:lucid_decision/core/extensions/string_ext.dart';
import 'package:lucid_decision/go_router_config.dart';
import 'package:lucid_decision/injector.dart';
import 'package:lucid_decision/locale_keys.g.dart';
import 'package:lucid_decision/modules/main/app/ui/history/history_wheel_page.dart';
import 'package:lucid_decision/modules/main/app/ui/home/app/ui/home_page_view_model.dart';
import 'package:lucid_decision/modules/main/app/ui/wheel_customize/wheel_customize_page.dart';
import 'package:lucid_decision/theme/ui_text_style.dart';
import 'package:refreshed/refreshed.dart';
import 'package:suga_core/suga_core.dart';

class HomePage extends StatefulWidget {
  static String routeName = 'HomePage';

  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends BaseViewState<HomePage, HomePageViewModel> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Obx(
        () => viewModel.currentWheel == null
            ? Container()
            : Scaffold(
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
                body: Column(
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
                            physics: NoPanPhysics(),
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
                              for (var wheelOption in viewModel.currentWheel!.options)
                                FortuneItem(
                                  child: Container(
                                    constraints: BoxConstraints(maxHeight: 50.h),
                                    margin: EdgeInsets.only(left: 50.w, right: 5.w),
                                    child: Text(wheelOption.content),
                                  ),
                                  style: FortuneItemStyle(
                                    color: Color(wheelOption.color),
                                    borderColor: Colors.white,
                                    textAlign: TextAlign.start,
                                    textStyle: UITextStyle.black_18_bold,
                                  ),
                                ),
                            ],
                            onAnimationEnd: () {
                              viewModel.setResultLabel = viewModel.currentWheel!.options[viewModel.streamController.value].content;
                              viewModel.isShowResult = false;
                            },
                            onAnimationStart: () {
                              viewModel.isShowResult = true;
                            },
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            viewModel.streamController.value = Fortune.randomInt(0, viewModel.currentWheel!.options.length);
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
                      visible: !viewModel.isShowResult,
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
                      visible: !viewModel.isShowResult,
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
                ),
                floatingActionButton: GestureDetector(
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
}
