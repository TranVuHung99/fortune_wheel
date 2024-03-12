import 'package:logger/logger.dart';
import 'package:injectable/injectable.dart';

class AppConfig {
  static const String injectionEnvironment = Environment.dev;
  static const Level logLevel = Level.debug;
}
