import 'package:injectable/injectable.dart';
import 'package:lucid_decision/modules/main/data/datasource/repositories/wheel_repository.dart';
import 'package:lucid_decision/modules/main/domain/models/wheel_model.dart';
import 'package:suga_core/suga_core.dart';

@lazySingleton
class AddWheelUsecase extends Usecase {
  final WheelRepository _repository;

  const AddWheelUsecase(this._repository);

  Future<Unit> run(WheelModel wheel) =>
      _repository.addWheel(wheel: wheel);
}