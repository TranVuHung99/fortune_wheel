import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:lucid_decision/modules/main/domain/models/wheel_model.dart';
import 'package:lucid_decision/modules/main/domain/models/wheel_option_model.dart';

part 'wheel_entity.g.dart';

@JsonSerializable()
@CopyWith()
@HiveType(typeId: 0)
class WheelEntity extends HiveObject{
  @JsonKey(name: "name")
  @HiveField(0)
  final String name;
  @JsonKey(name: "options", toJson: _optionsToJson)
  @HiveField(1)
  final List<WheelOption> options;
  @JsonKey(name: "created_at")
  @HiveField(2)
  final DateTime createdAt;
  @JsonKey(name: "update_at")
  @HiveField(3)
  final DateTime updateAt;
  WheelEntity({
    required this.name,
    required this.createdAt,
    required this.updateAt,
    required this.options,
});

  factory WheelEntity.fromJson(Map<String, dynamic> json) => _$WheelEntityFromJson(json);

  Map<String, dynamic> toJson() => _$WheelEntityToJson(this);

  static List<Map<String, dynamic>> _optionsToJson(List<WheelOption> wheelOptions) => wheelOptions.map((option) => option.toJson()).toList();

  WheelModel formatToModel(int id) => WheelModel(id, name: name, createdAt: createdAt, updateAt: updateAt, options: options);


}