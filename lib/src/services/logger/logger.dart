import 'package:flutter_platform_control_panel/src/services/logger/console_output.dart';
import 'package:logger/logger.dart' as logger_dependency;

final consoleOutput = ConsoleOutput();
final logger = logger_dependency.Logger(
  output: consoleOutput,
);

bool _initialized = false;

class Logger {
  static void init({int bufferSize = 20}) {
    if (_initialized) {
      return;
    }

    _initialized = true;
    consoleOutput.bufferSize = bufferSize;
  }

  /// Log a message at level [Level.verbose].
  static void v(dynamic message, [dynamic error, StackTrace stackTrace]) {
    logger.log(logger_dependency.Level.verbose, message, error, stackTrace);
  }

  /// Log a message at level [Level.debug].
  static void d(dynamic message, [dynamic error, StackTrace stackTrace]) {
    logger.log(logger_dependency.Level.debug, message, error, stackTrace);
  }

  /// Log a message at level [Level.info].
  static void i(dynamic message, [dynamic error, StackTrace stackTrace]) {
    logger.log(logger_dependency.Level.info, message, error, stackTrace);
  }

  /// Log a message at level [Level.warning].
  static void w(dynamic message, [dynamic error, StackTrace stackTrace]) {
    logger.log(logger_dependency.Level.warning, message, error, stackTrace);
  }

  /// Log a message at level [Level.error].
  static void e(dynamic message, [dynamic error, StackTrace stackTrace]) {
    logger.log(logger_dependency.Level.error, message, error, stackTrace);
  }

  /// Log a message at level [Level.wtf].
  static void wtf(dynamic message, [dynamic error, StackTrace stackTrace]) {
    logger.log(logger_dependency.Level.wtf, message, error, stackTrace);
  }
}
