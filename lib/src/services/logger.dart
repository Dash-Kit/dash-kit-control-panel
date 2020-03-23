import 'package:flutter_platform_control_panel/src/ui/components/logger/console_output.dart';
import 'package:logger/logger.dart';

bool _initialized = false;

class Logger {
  static void initBufferSize({int bufferSize = 20}) {
    if (_initialized) return;

    _initialized = true;
    consoleOutput.bufferSize = bufferSize;
  }

  /// Log a message at level [Level.verbose].
  static void v(dynamic message, [dynamic error, StackTrace stackTrace]) {
    logger.log(Level.verbose, message, error, stackTrace);
  }

  /// Log a message at level [Level.debug].
  static void d(dynamic message, [dynamic error, StackTrace stackTrace]) {
    logger.log(Level.debug, message, error, stackTrace);
  }

  /// Log a message at level [Level.info].
  static void i(dynamic message, [dynamic error, StackTrace stackTrace]) {
    logger.log(Level.info, message, error, stackTrace);
  }

  /// Log a message at level [Level.warning].
  static void w(dynamic message, [dynamic error, StackTrace stackTrace]) {
    logger.log(Level.warning, message, error, stackTrace);
  }

  /// Log a message at level [Level.error].
  static void e(dynamic message, [dynamic error, StackTrace stackTrace]) {
    logger.log(Level.error, message, error, stackTrace);
  }

  /// Log a message at level [Level.wtf].
  static void wtf(dynamic message, [dynamic error, StackTrace stackTrace]) {
    logger.log(Level.wtf, message, error, stackTrace);
  }
}
