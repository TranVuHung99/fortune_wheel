import 'package:event_bus/event_bus.dart';
import 'package:injectable/injectable.dart';
import 'package:lucid_decision/modules/main/data/datasource/repositories/wheel_repository.dart';
import 'package:lucid_decision/modules/main/domain/events/on_done_editing_wheel_event.dart';
import 'package:lucid_decision/modules/main/domain/models/wheel_model.dart';
import 'package:suga_core/suga_core.dart';

@lazySingleton
class EditWheelUsecase extends Usecase {
  final WheelRepository _repository;
  final EventBus _eventBus;

  const EditWheelUsecase(this._repository, this._eventBus);

  Future<Unit> run(int id, {required WheelModel wheel}) async {
    _eventBus.fire(OnDoneEditingWheelEvent(wheel: wheel));
    await _repository.editWheel(id, editWheel: wheel);
    return unit;
  }
}
