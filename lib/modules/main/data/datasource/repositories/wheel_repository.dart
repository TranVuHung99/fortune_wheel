import 'package:injectable/injectable.dart';
import 'package:lucid_decision/modules/main/data/datasource/wheel_datasource.dart';
import 'package:lucid_decision/modules/main/domain/models/wheel_model.dart';
import 'package:suga_core/suga_core.dart';

@lazySingleton
class WheelRepository extends Repository {
  final WheelDatasource _datasource;
  const WheelRepository(this._datasource);

  Future<Unit> addWheel({required Wheel wheel}) {
    return _datasource.addWheel(wheel: wheel);
  }

  Future<Unit> deleteWheel(int id) {
    return _datasource.deleteWheel(id);
  }

  Future<Unit> editWheel(int id, {required Wheel editWheel}) {
    return _datasource.editWheel(id, editWheel: editWheel);
  }

  Future<List<Wheel>> getAllWheels() async {
    return _datasource.getAllWheels();
  }
}