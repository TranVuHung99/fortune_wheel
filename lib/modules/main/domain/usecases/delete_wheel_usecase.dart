import 'package:event_bus/event_bus.dart';
import 'package:injectable/injectable.dart';
import 'package:lucid_decision/modules/main/data/datasource/repositories/wheel_repository.dart';
import 'package:lucid_decision/modules/main/domain/events/on_delete_wheel_event.dart';
import 'package:suga_core/suga_core.dart';

@lazySingleton
class DeleteWheelUsecase extends Usecase {
  final WheelRepository _repository;
  final EventBus _eventBus;

  const DeleteWheelUsecase(this._repository, this._eventBus);

  Future<Unit> run(int id) async {
    _eventBus.fire(const OnDeleteWheelEvent());
    await _repository.deleteWheel(id);
    return unit;
  }
}
