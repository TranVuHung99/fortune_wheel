import 'package:injectable/injectable.dart';
import 'package:lucid_decision/modules/main/data/datasource/repositories/wheel_repository.dart';
import 'package:lucid_decision/modules/main/domain/models/wheel_model.dart';
import 'package:suga_core/suga_core.dart';

@lazySingleton
class GetWheelByIdUsecase extends Usecase {
  final WheelRepository _repository;

  const GetWheelByIdUsecase(this._repository);

  Future<WheelModel> run(int id) =>
      _repository.getWheelById(id);
}