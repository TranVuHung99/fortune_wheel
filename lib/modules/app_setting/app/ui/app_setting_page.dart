import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lucid_decision/core/extensions/string_ext.dart';
import 'package:lucid_decision/injector.dart';
import 'package:lucid_decision/locale_keys.g.dart';
import 'package:lucid_decision/modules/app_setting/app/ui/app_setting_page_view_model.dart';
import 'package:lucid_decision/modules/app_setting/app/widgets/app_setting_item_widget.dart';
import 'package:lucid_decision/theme/ui_text_style.dart';
import 'package:suga_core/suga_core.dart';

class AppSettingPage extends StatefulWidget {
  static String routeName = 'AppSettingPage';

  const AppSettingPage({super.key});

  @override
  State<AppSettingPage> createState() => _AppSettingPageState();
}

class _AppSettingPageState extends BaseViewState<AppSettingPage, AppSettingPageViewModel> with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.blueGrey,
        appBar: AppBar(
          primary: false,
          elevation: 0.0,
          backgroundColor: Colors.white,
          automaticallyImplyLeading: false,
          title: Text(LocaleKeys.setting.trans(), style: UITextStyle.black_18_bold),
          centerTitle: true,
        ),
        body: Column(
          children: [
            SizedBox(height: 30.h),
            AppSettingItemWidget(
              onClick: () => viewModel.onClickSpinTime(),
              iconLabel: Icon(Icons.access_time_outlined, size: 24.sp),
              title: LocaleKeys.spin_time.trans(),
            ),
            SizedBox(height: 10.h),
            AppSettingItemWidget(
              onClick: () => viewModel.onClickChangeLanguage(),
              iconLabel: Icon(Icons.language, size: 24.sp),
              title: LocaleKeys.language.trans(),
            ),
            SizedBox(height: 10.h),
            AppSettingItemWidget(
              onClick: () {},
              iconLabel: Icon(Icons.info_outline, size: 24.sp),
              title: LocaleKeys.app_info.trans(),
            ),
            SizedBox(height: 10.h),
            AppSettingItemWidget(
              onClick: () {},
              iconLabel: Icon(Icons.help_outline, size: 24.sp),
              title: LocaleKeys.help.trans(),
            ),
          ],
        ),
      ),
    );
  }

  @override
  AppSettingPageViewModel createViewModel() => injector<AppSettingPageViewModel>();

  @override
  bool get wantKeepAlive => true;
}
