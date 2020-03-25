import 'dart:collection';

import 'package:logger/logger.dart' as logger_dependency;

class ConsoleOutput extends logger_dependency.LogOutput {
  final ListQueue<logger_dependency.OutputEvent> outputEventBuffer =
      ListQueue();
  Function(logger_dependency.OutputEvent event) outputCallback;
  int bufferSize = 20;

  @override
  void output(logger_dependency.OutputEvent event) {
    event.lines.forEach(print);

    if (outputEventBuffer.length == bufferSize) {
      outputEventBuffer.removeFirst();
    }
    outputEventBuffer.add(event);
    if (outputCallback != null) {
      outputCallback(event);
    }
  }
}
