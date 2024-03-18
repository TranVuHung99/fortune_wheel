import 'package:event_bus/event_bus.dart';
import 'package:injectable/injectable.dart';
import 'package:lucid_decision/modules/main/data/datasource/repositories/wheel_repository.dart';
import 'package:lucid_decision/modules/main/domain/events/on_add_wheel_event.dart';
import 'package:lucid_decision/modules/main/domain/models/wheel_model.dart';
import 'package:suga_core/suga_core.dart';

@lazySingleton
class AddWheelUsecase extends Usecase {
  final WheelRepository _repository;
  final EventBus _eventBus;

  const AddWheelUsecase(
    this._repository,
    this._eventBus,
  );

  Future<Unit> run(WheelModel wheel) async {
    _eventBus.fire(OnAddWheelEvent(wheel: wheel));
    await _repository.addWheel(wheel: wheel);
    return unit;
  }
}
