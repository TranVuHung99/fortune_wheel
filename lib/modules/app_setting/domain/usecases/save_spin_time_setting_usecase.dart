import 'package:injectable/injectable.dart';
import 'package:lucid_decision/modules/app_setting/domain/repositories/app_setting_repository.dart';
import 'package:suga_core/suga_core.dart';

@lazySingleton
class SaveSpinTimeSettingUsecase extends Usecase {
  final AppSettingRepository _appSettingRepository;

  const SaveSpinTimeSettingUsecase(this._appSettingRepository);

  Future<Unit> run(int value) async {
    await _appSettingRepository.saveSpinTimeValue(value);
    return unit;
  }
}
