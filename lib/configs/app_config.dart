import 'package:injectable/injectable.dart';
import 'package:logger/logger.dart';

class AppConfig {
  static const bool debug = true;
  static const String injectionEnvironment = Environment.dev;
  static const Level logLevel = Level.debug;
}
