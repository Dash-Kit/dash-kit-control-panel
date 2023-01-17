import 'package:dash_kit_control_panel/src/services/logger/console_output.dart';
import 'package:logger/logger.dart' as logger_dependency;

final consoleOutput = ConsoleOutput();

class Logger {
  Logger._(this._logger);

  factory Logger.init({
    int methodCount = 2,
    int bufferSize = 20,
    int lineLength = 120,
    bool printTime = true,
    bool colors = false,
    bool printEmojis = true,
    Map<logger_dependency.Level, bool> excludeBox = const {},
    bool noBoxingByDefault = false,
  }) {
    assert(!_initialized, 'Logger has been already initialized!');

    _initialized = true;
    consoleOutput.bufferSize = bufferSize;

    return Logger._(
      logger_dependency.Logger(
        output: consoleOutput,
        printer: logger_dependency.PrettyPrinter(
          methodCount: methodCount,
          printTime: printTime,
          colors: colors,
          printEmojis: printEmojis,
          lineLength: lineLength,
          excludeBox: excludeBox,
          noBoxingByDefault: noBoxingByDefault,
        ),
      ),
    );
  }

  final logger_dependency.Logger _logger;

  static bool _initialized = false;

  /// Log a message at level [Level.verbose].
  void v(dynamic message, [dynamic error, StackTrace? stackTrace]) {
    _logger.log(logger_dependency.Level.verbose, message, error, stackTrace);
  }

  /// Log a message at level [Level.debug].
  void d(dynamic message, [dynamic error, StackTrace? stackTrace]) {
    _logger.log(logger_dependency.Level.debug, message, error, stackTrace);
  }

  /// Log a message at level [Level.info].
  void i(dynamic message, [dynamic error, StackTrace? stackTrace]) {
    _logger.log(logger_dependency.Level.info, message, error, stackTrace);
  }

  /// Log a message at level [Level.warning].
  void w(dynamic message, [dynamic error, StackTrace? stackTrace]) {
    _logger.log(logger_dependency.Level.warning, message, error, stackTrace);
  }

  /// Log a message at level [Level.error].
  void e(dynamic message, [dynamic error, StackTrace? stackTrace]) {
    _logger.log(logger_dependency.Level.error, message, error, stackTrace);
  }

  /// Log a message at level [Level.wtf].
  void wtf(dynamic message, [dynamic error, StackTrace? stackTrace]) {
    _logger.log(logger_dependency.Level.wtf, message, error, stackTrace);
  }
}
