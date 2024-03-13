import 'package:event_bus/event_bus.dart';
import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';
import 'package:injectable/injectable.dart';
import 'package:lucid_decision/configs/app_config.dart';
import 'package:lucid_decision/core/constants/constants.dart';
import 'package:lucid_decision/modules/home/domain/models/wheel_model.dart';
import 'package:lucid_decision/modules/home/domain/models/wheel_option_model.dart';
import 'package:suga_core/suga_core.dart';
import 'package:path_provider/path_provider.dart' as path_provider;
import 'package:lucid_decision/injector.config.dart';

final injector = GetIt.instance;

@InjectableInit()
Future<Unit> configureDependencies() async {
  await injector.init(environment: AppConfig.injectionEnvironment);
  return unit;
}

@module
abstract class MainModule {

  @lazySingleton
  EventBus getEventBus() => EventBus();

  @lazySingleton
  @preResolve
  Future<Box> getBox() async {
    final appDocumentDirectory = await path_provider.getApplicationDocumentsDirectory();
    Hive.init(appDocumentDirectory.path);
    Hive.registerAdapter(WheelOptionAdapter());
    Hive.registerAdapter(WheelAdapter());
    return Hive.openBox(Constants.appHiveDatasource,);
  }
}
