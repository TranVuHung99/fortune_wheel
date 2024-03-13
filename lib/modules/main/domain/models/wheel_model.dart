
import 'package:lucid_decision/modules/main/domain/models/wheel_entity.dart';

class WheelModel extends WheelEntity {
  final int id;

  WheelModel(
    this.id, {
    required super.name,
    required super.createdAt,
    required super.updateAt,
    required super.options,
  });

  WheelEntity formatToEntity() => WheelEntity(name: name, createdAt: createdAt, updateAt: updateAt, options: options);
}
