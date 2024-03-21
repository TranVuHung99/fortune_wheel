import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:lucid_decision/core/abstracts/app_view_model.dart';
import 'package:lucid_decision/core/extensions/string_ext.dart';
import 'package:lucid_decision/core/helper/get_context.dart';
import 'package:lucid_decision/go_router_config.dart';
import 'package:lucid_decision/locale_keys.g.dart';
import 'package:lucid_decision/modules/app_setting/app/widgets/all_language_widget.dart';
import 'package:lucid_decision/modules/app_setting/app/widgets/custom_dialog.dart';
import 'package:lucid_decision/modules/app_setting/app/widgets/setting_option_body_widget.dart';
import 'package:lucid_decision/modules/app_setting/domain/enums/language.dart';
import 'package:lucid_decision/modules/app_setting/domain/usecases/get_spin_time_setting_usecase.dart';
import 'package:lucid_decision/modules/app_setting/domain/usecases/save_spin_time_setting_usecase.dart';
import 'package:lucid_decision/modules/boarding/app/splash/ui/splash_page.dart';
import 'package:refreshed/refreshed.dart';
import 'package:suga_core/suga_core.dart';

@injectable
class AppSettingPageViewModel extends AppViewModel {
  final GetSpinTimeSettingUsecase _getSpinTimeSettingUsecase;
  final SaveSpinTimeSettingUsecase _saveSpinTimeSettingUsecase;

  final _language = Rx<Language>(Language.unknown);

  Language get language => _language.value;

  final _spinTime = RxInt(7);

  int get spinTime => _spinTime.value;

  AppSettingPageViewModel(
    this._getSpinTimeSettingUsecase,
    this._saveSpinTimeSettingUsecase,
  );

  @override
  void initState() {
    _loadPage();
    super.initState();
  }

  Future<Unit> _loadPage() async {
    await _assignLanguage();
    await _assignSpinTime();
    return unit;
  }

  Future<Unit> _assignLanguage() async {
    final langCode = Localizations.localeOf(getContext).languageCode;
    if (langCode == 'vi') {
      _language.value = Language.vn;
    } else if (langCode == 'en') {
      _language.value = Language.en;
    }
    return unit;
  }

  Future<Unit> onClickChangeLanguage() async {
    final languageOrigin = _language.value;
    await showDialog(
      context: getContext,
      useSafeArea: true,
      builder: (getContext) {
        return Obx(
          () => CustomDialog(
            body: AllLanguageWidget(
              selectedLanguage: language,
              onClick: (lang) => _language.value = lang,
            ),
            onAccept: () async => _onSubmitNewLanguage(languageOrigin),
            onReject: () async {
              _language.value = languageOrigin;
              goRouterConfig.pop();
            },
          ),
        );
      },
      barrierDismissible: false,
    );
    return unit;
  }

  Future<Unit> _onSubmitNewLanguage(Language langOrigin) async {
    if (langOrigin == language) {
      goRouterConfig.pop();
    } else {
      await EasyLocalization.of(getContext)?.setLocale(Locale(language.getValue()));
      goRouterConfig.goNamed(SplashPage.routeName);
    }
    return unit;
  }

  Future<Unit> _assignSpinTime() async {
    late int fetchSpinTime;
    await run(() async => fetchSpinTime = await _getSpinTimeSettingUsecase.run());
    _spinTime.value = fetchSpinTime;
    return unit;
  }

  Future<Unit> onClickSpinTime() async {
    final spinTimeOrigin = _spinTime.value;
    await showDialog(
      context: getContext,
      useSafeArea: true,
      builder: (getContext) {
        return Obx(
          () => CustomDialog(
            body: SettingOptionBodyWidget(
              selectedValue: spinTime,
              values: const [3, 5, 7, 10, 12, 15, 20],
              titles: [
                LocaleKeys.sec_3.trans(),
                LocaleKeys.sec_5.trans(),
                LocaleKeys.sec_7.trans(),
                LocaleKeys.sec_10.trans(),
                LocaleKeys.sec_12.trans(),
                LocaleKeys.sec_15.trans(),
                LocaleKeys.sec_20.trans()
              ],
              onClick: (value) {
                return _spinTime.value = value;
              },
            ),
            onAccept: _onSubmitNewSpinTime,
            onReject: () async {
              _spinTime.value = spinTimeOrigin;
              goRouterConfig.pop();
            },
          ),
        );
      },
      barrierDismissible: false,
    );
    return unit;
  }

  Future<Unit> _onSubmitNewSpinTime() async {
    await run(() => _saveSpinTimeSettingUsecase.run(spinTime));
    goRouterConfig.pop();
    return unit;
  }
}
