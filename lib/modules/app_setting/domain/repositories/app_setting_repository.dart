import 'package:suga_core/suga_core.dart';

abstract class AppSettingRepository {
  Future<int> getSpinTimeValue();

  Future<Unit> saveSpinTimeValue(int value);
}
