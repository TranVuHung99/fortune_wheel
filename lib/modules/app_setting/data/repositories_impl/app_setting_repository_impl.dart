import 'package:injectable/injectable.dart';
import 'package:lucid_decision/modules/app_setting/data/datasources/app_setting_local_datasource.dart';
import 'package:lucid_decision/modules/app_setting/domain/repositories/app_setting_repository.dart';
import 'package:suga_core/suga_core.dart';

@LazySingleton(as: AppSettingRepository)
class AppSettingRepositoryImpl implements AppSettingRepository, Repository {
  final AppSettingLocalDatasource _appSettingLocalDatasource;

  const AppSettingRepositoryImpl(this._appSettingLocalDatasource);

  @override
  Future<int> getSpinTimeValue() => _appSettingLocalDatasource.getSpinTimeValue();

  @override
  Future<Unit> saveSpinTimeValue(int value) async => _appSettingLocalDatasource.saveSpinTimeValue(value);
}
