import 'package:injectable/injectable.dart';
import 'package:lucid_decision/modules/main/data/datasource/wheel_datasource.dart';
import 'package:lucid_decision/modules/main/domain/models/wheel_model.dart';
import 'package:lucid_decision/modules/main/domain/models/wheel_option_model.dart';
import 'package:suga_core/suga_core.dart';

@lazySingleton
class WheelRepository extends Repository {
  final WheelDatasource _datasource;
  const WheelRepository(this._datasource);

  Future<int> addWheel({required String name, required List<WheelOption> option, String? banner, String? indicator}) {
    return _datasource.addWheel(name: name,
      option: option,
      banner: banner,
      indicator: indicator,);
  }

  Future<WheelModel> getWheelById(int id) {
    return _datasource.getWheelById(id);
  }

  Future<Unit> deleteWheel(int id) {
    return _datasource.deleteWheel(id);
  }

  Future<Unit> editWheel(int id, {required WheelModel editWheel}) {
    return _datasource.editWheel(id, editWheel: editWheel);
  }

  Future<List<WheelModel>> getAllWheels() async {
    return _datasource.getAllWheels();
  }
}