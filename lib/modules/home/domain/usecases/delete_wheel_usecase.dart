import 'package:injectable/injectable.dart';
import 'package:lucid_decision/core/helper/list_params.dart';
import 'package:lucid_decision/modules/home/data/datasource/repositories/wheel_repository.dart';
import 'package:suga_core/suga_core.dart';

@lazySingleton
class DeleteWheelUsecase extends Usecase {
  final WheelRepository _repository;

  const DeleteWheelUsecase(this._repository);

  Future<Unit> run(int id) =>
      _repository.deleteWheel(id);
}