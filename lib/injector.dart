import 'package:event_bus/event_bus.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:lucid_decision/injector.config.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:injectable/injectable.dart';
import 'package:suga_core/suga_core.dart';
import 'package:logger/logger.dart';

import 'configs/app_config.dart';

final injector = GetIt.instance;

@injectableInit
Future<Unit> setupInjector() async {
  await injector.init(environment: Environment.dev);
  return unit;
}

@module
abstract class MainModule {
  @lazySingleton
  @preResolve
  Future<SharedPreferences> getSharePreferences() async => SharedPreferences.getInstance();

  @lazySingleton
  Logger getLogger() => Logger(level: AppConfig.logLevel);

  @lazySingleton
  FlutterSecureStorage secureStorage() => const FlutterSecureStorage(aOptions: AndroidOptions(encryptedSharedPreferences: true));

  @lazySingleton
  EventBus getEventBus() => EventBus();
}
