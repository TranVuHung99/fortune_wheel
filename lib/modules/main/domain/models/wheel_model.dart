import 'package:lucid_decision/modules/main/domain/models/wheel_entity.dart';
import 'package:lucid_decision/modules/main/domain/models/wheel_option_model.dart';

class WheelModel extends WheelEntity {
  final int id;

  WheelModel(
    this.id, {
    required super.name,
    required super.createdAt,
    required super.updateAt,
    required super.options,
    super.banner,
    super.indicator,
  });

  WheelEntity formatToEntity() => WheelEntity(name: name, createdAt: createdAt, updateAt: updateAt, options: options);

  WheelModel copyWithModel({String? name, DateTime? updateAt, List<WheelOption>? options, String? banner, String? indicator}) {
    return WheelModel(
      id,
      createdAt: createdAt,
      name: name ?? this.name,
      updateAt: updateAt ?? this.updateAt,
      options: options ?? this.options,
      banner: banner ?? this.banner,
      indicator: indicator ?? this.indicator,
    );
  }
}
