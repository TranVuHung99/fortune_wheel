import 'package:injectable/injectable.dart';
import 'package:lucid_decision/modules/app_setting/domain/repositories/app_setting_repository.dart';
import 'package:suga_core/suga_core.dart';

@lazySingleton
class GetSpinTimeSettingUsecase extends Usecase {
  final AppSettingRepository _appSettingRepository;

  const GetSpinTimeSettingUsecase(this._appSettingRepository);

  Future<int> run() async => _appSettingRepository.getSpinTimeValue();
}
