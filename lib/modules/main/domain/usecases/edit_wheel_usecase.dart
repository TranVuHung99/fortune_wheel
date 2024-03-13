import 'package:injectable/injectable.dart';
import 'package:lucid_decision/modules/main/data/datasource/repositories/wheel_repository.dart';
import 'package:lucid_decision/modules/main/domain/models/wheel_model.dart';
import 'package:suga_core/suga_core.dart';

@lazySingleton
class EditWheelUsecase extends Usecase {
  final WheelRepository _repository;

  const EditWheelUsecase(this._repository);

  Future<Unit> run(int id, {required Wheel wheel}) =>
      _repository.editWheel(id, editWheel: wheel);
}