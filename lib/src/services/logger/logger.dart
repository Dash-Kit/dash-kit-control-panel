import 'package:dash_kit_control_panel/src/services/logger/custom_output.dart';
import 'package:logger/logger.dart' as logger_dependency;
import 'package:logger/logger.dart';

final consoleOutput = CustomOutput();

class Logger {
  Logger._(
    this._logger, {
    this.enabled = true,
  });

  factory Logger.init({
    int methodCount = 2,
    int bufferSize = 20,
    int lineLength = 120,
    DateTimeFormatter dateTimeFormat = DateTimeFormat.onlyTimeAndSinceStart,
    bool colors = false,
    bool printEmojis = true,
    Map<logger_dependency.Level, bool> excludeBox = const {},
    bool noBoxingByDefault = false,
    bool enabled = true,
  }) {
    assert(!_initialized, 'Logger has been already initialized!');

    _initialized = true;
    consoleOutput.bufferSize = bufferSize;

    return Logger._(
      logger_dependency.Logger(
        output: consoleOutput,
        printer: logger_dependency.PrettyPrinter(
          methodCount: methodCount,
          dateTimeFormat: dateTimeFormat,
          colors: colors,
          printEmojis: printEmojis,
          lineLength: lineLength,
          excludeBox: excludeBox,
          noBoxingByDefault: noBoxingByDefault,
        ),
      ),
      enabled: enabled,
    );
  }

  final bool enabled;

  final logger_dependency.Logger _logger;

  static bool _initialized = false;

  /// Log a message at level `Level.trace`.
  void v(dynamic message, [dynamic error, StackTrace? stackTrace]) {
    if (enabled) {
      _logger.log(
        logger_dependency.Level.trace,
        message,
        error: error,
        stackTrace: stackTrace,
      );
    }
  }

  /// Log a message at level `Level.debug`.
  void d(dynamic message, [dynamic error, StackTrace? stackTrace]) {
    if (enabled) {
      _logger.log(
        logger_dependency.Level.debug,
        message,
        error: error,
        stackTrace: stackTrace,
      );
    }
  }

  /// Log a message at level `Level.info`.
  void i(dynamic message, [dynamic error, StackTrace? stackTrace]) {
    if (enabled) {
      _logger.log(
        logger_dependency.Level.info,
        message,
        error: error,
        stackTrace: stackTrace,
      );
    }
  }

  /// Log a message at level `Level.warning`.
  void w(dynamic message, [dynamic error, StackTrace? stackTrace]) {
    if (enabled) {
      _logger.log(
        logger_dependency.Level.warning,
        message,
        error: error,
        stackTrace: stackTrace,
      );
    }
  }

  /// Log a message at level `Level.error`.
  void e(dynamic message, [dynamic error, StackTrace? stackTrace]) {
    if (enabled) {
      _logger.log(
        logger_dependency.Level.error,
        message,
        error: error,
        stackTrace: stackTrace,
      );
    }
  }

  /// Log a message at level `Level.wtf`.
  void wtf(dynamic message, [dynamic error, StackTrace? stackTrace]) {
    if (enabled) {
      _logger.log(
        logger_dependency.Level.fatal,
        message,
        error: error,
        stackTrace: stackTrace,
      );
    }
  }
}
