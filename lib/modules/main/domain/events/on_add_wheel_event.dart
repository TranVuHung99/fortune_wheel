import 'package:lucid_decision/modules/main/domain/models/wheel_model.dart';
import 'package:suga_core/suga_core.dart';

class OnAddWheelEvent extends Event {
  final WheelModel wheel;

  const OnAddWheelEvent({required this.wheel});
}
