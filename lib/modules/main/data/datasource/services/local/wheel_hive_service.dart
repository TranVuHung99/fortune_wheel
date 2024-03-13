import 'package:collection/collection.dart';
import 'package:hive/hive.dart';
import 'package:injectable/injectable.dart';
import 'package:lucid_decision/modules/main/domain/models/wheel_entity.dart';
import 'package:lucid_decision/modules/main/domain/models/wheel_model.dart';
import 'package:suga_core/suga_core.dart';

@lazySingleton
class WheelHiveService {
  final Box collection;
  WheelHiveService(this.collection);


  Future<List<WheelModel>> getAllWheels() async {
    final values = collection.values.cast<WheelEntity>().toList();
    final keys = collection.keys.toList();
    return values.mapIndexed((i, e) => e.formatToModel(keys[i])).toList();
  }

  Future<Unit> addWheel({required WheelEntity wheel}) async {
    await collection.add(wheel);
    return unit;
  }

  Future<Unit> editWheel(int id, {required WheelEntity editWheel}) async {
    await collection.put(id, editWheel);
    return unit;
  }

  Future<Unit> deleteWheel(int id) async {
    await collection.delete(id);
    return unit;
  }
}