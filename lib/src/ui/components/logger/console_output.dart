import 'dart:collection';

import 'package:logger/logger.dart';

final consoleOutput = ConsoleOutput();
final logger = Logger(
  output: consoleOutput,
);

class ConsoleOutput extends LogOutput {
  final ListQueue<OutputEvent> outputEventBuffer = ListQueue();
  Function(OutputEvent event) outputCallback;
  int bufferSize = 20;

  @override
  void output(OutputEvent event) {
    for (var line in event.lines) {
      print(line);
    }
    if (outputEventBuffer.length == bufferSize) {
      outputEventBuffer.removeFirst();
    }
    outputEventBuffer.add(event);
    if (outputCallback != null) {
      outputCallback(event);
    }
  }
}
