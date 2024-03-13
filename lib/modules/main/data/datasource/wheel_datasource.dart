import 'package:injectable/injectable.dart';
import 'package:lucid_decision/modules/main/data/datasource/services/local/wheel_hive_service.dart';
import 'package:lucid_decision/modules/main/domain/models/wheel_model.dart';
import 'package:suga_core/suga_core.dart';

abstract class WheelDatasource {
  Future<List<Wheel>> getAllWheels();
  Future<Unit> addWheel({required Wheel wheel});
  Future<Unit> editWheel(int id, {required Wheel editWheel});
  Future<Unit> deleteWheel(int id);
}

@LazySingleton(as: WheelDatasource)
class ImplLocalWheelDataSource implements WheelDatasource {
  final WheelHiveService _service;

  ImplLocalWheelDataSource(this._service);

  @override
  Future<Unit> addWheel({required Wheel wheel}) {
    return _service.addWheel(wheel: wheel);
  }

  @override
  Future<Unit> deleteWheel(int id) {
    return _service.deleteWheel(id);
  }

  @override
  Future<Unit> editWheel(int id, {required Wheel editWheel}) {
    return _service.editWheel(id, editWheel: editWheel);
  }

  @override
  Future<List<Wheel>> getAllWheels() async {
    return _service.getAllWheels();
  }

}