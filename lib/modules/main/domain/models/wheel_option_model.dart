
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';

part 'wheel_option_model.g.dart';

@JsonSerializable()
@CopyWith()
@HiveType(typeId: 1)
class WheelOption extends HiveObject {
  @HiveField(0)
  @JsonKey(name: "content")
  final String content;
  @HiveField(1)
  @JsonKey(name: "color")
  final int color;

  WheelOption({required this.content, required this.color});


  factory WheelOption.fromJson(Map<String, dynamic> json) => _$WheelOptionFromJson(json);

  Map<String, dynamic> toJson() => _$WheelOptionToJson(this);

}