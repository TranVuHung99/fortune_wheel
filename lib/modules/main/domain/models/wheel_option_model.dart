import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';

part 'wheel_option_model.g.dart';

@JsonSerializable()
@CopyWith()
@HiveType(typeId: 1)
class WheelOption extends HiveObject implements Equatable {
  @HiveField(0)
  @JsonKey(name: "content")
  final String content;
  @HiveField(1)
  @JsonKey(name: "color")
  final int color;
  @HiveField(2)
  @JsonKey(name: "ratio")
  final int? ratio;
  @HiveField(3)
  @JsonKey(name: "background")
  final String? background;

  WheelOption({
    required this.content,
    required this.color,
    this.ratio,
    this.background,
  });

  factory WheelOption.fromJson(Map<String, dynamic> json) => _$WheelOptionFromJson(json);

  Map<String, dynamic> toJson() => _$WheelOptionToJson(this);

  @override
  List<Object?> get props => [content, color, ratio, background];

  @override
  bool? get stringify => null;
}
