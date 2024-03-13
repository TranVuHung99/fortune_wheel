import 'package:injectable/injectable.dart';
import 'package:lucid_decision/modules/home/data/datasource/repositories/wheel_repository.dart';
import 'package:lucid_decision/modules/home/domain/models/wheel_model.dart';
import 'package:suga_core/suga_core.dart';

@lazySingleton
class AddWheelUsecase extends Usecase {
  final WheelRepository _repository;

  const AddWheelUsecase(this._repository);

  Future<Unit> run(Wheel wheel) =>
      _repository.addWheel(wheel: wheel);
}