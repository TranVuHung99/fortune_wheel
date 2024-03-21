import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:suga_core/suga_core.dart';

abstract class AppSettingLocalDatasource {
  Future<int> getSpinTimeValue();

  Future<Unit> saveSpinTimeValue(int value);
}

@LazySingleton(as: AppSettingLocalDatasource)
class AppSettingLocalDatasourceImpl implements AppSettingLocalDatasource {
  final SharedPreferences _sharedPreferences;

  AppSettingLocalDatasourceImpl(this._sharedPreferences);

  static const _appSetting = "app_setting_";
  static const _spinTimeKey = "spin_time_key";

  @override
  Future<int> getSpinTimeValue() async {
    const defaultSpinTime = 7;
    return _sharedPreferences.getInt("$_appSetting$_spinTimeKey") ?? defaultSpinTime;
  }

  @override
  Future<Unit> saveSpinTimeValue(int value) async {
    await _sharedPreferences.setInt("$_appSetting$_spinTimeKey", value);
    return unit;
  }
}
