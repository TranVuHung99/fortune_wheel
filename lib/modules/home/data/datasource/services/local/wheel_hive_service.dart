import 'package:hive/hive.dart';
import 'package:injectable/injectable.dart';
import 'package:lucid_decision/modules/home/domain/models/wheel_model.dart';
import 'package:suga_core/suga_core.dart';
import 'package:refreshed/get_rx/get_rx.dart';

@lazySingleton
class WheelHiveService {
  final Box collection;
  WheelHiveService(this.collection);


  Future<List<Wheel>> getAllWheels() async {
    return collection.values.cast<Wheel>().toList();
  }

  Future<Unit> addWheel({required Wheel wheel}) async {
    await collection.add(wheel);
    return unit;
  }
  Future<Unit> editWheel(int id, {required Wheel editWheel}) async {

    await collection.put(id, editWheel);
    return unit;
  }
  Future<Unit> deleteWheel(int id) async {
    await collection.delete(id);
    return unit;
  }
}