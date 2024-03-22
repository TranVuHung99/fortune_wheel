import 'package:collection/collection.dart';
import 'package:hive/hive.dart';
import 'package:injectable/injectable.dart';
import 'package:lucid_decision/modules/main/data/datasource/exceptions/id_not_found_exception.dart';
import 'package:lucid_decision/modules/main/domain/models/wheel_entity.dart';
import 'package:lucid_decision/modules/main/domain/models/wheel_model.dart';
import 'package:lucid_decision/modules/main/domain/models/wheel_option_model.dart';
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

  Future<WheelModel> getWheelById(int id) async {
    try{
      final wheel =  (collection.get(id) as WheelEntity).formatToModel(id);
      return wheel;
    } catch (e) {
      throw IdNotFoundException();
    }
  }

  Future<int> addWheel({required String name, required List<WheelOption> option, String? banner,String? indicator}) async {
    final  wheel = WheelEntity(
      name: name,
      createdAt: DateTime.now(),
      updateAt: DateTime.now(),
      options: option,
      banner: banner,
      indicator: indicator,
    );
    return collection.add(wheel);
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
