import 'package:injectable/injectable.dart';
import 'package:lucid_decision/modules/main/data/datasource/repositories/wheel_repository.dart';
import 'package:lucid_decision/modules/main/domain/models/wheel_model.dart';
import 'package:suga_core/suga_core.dart';

@lazySingleton
class GetAllWheelUsecase extends Usecase {
  final WheelRepository _repository;

  const GetAllWheelUsecase(this._repository);

  Future<List<WheelModel>> run() =>
      _repository.getAllWheels();
}