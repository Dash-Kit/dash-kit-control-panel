import 'dart:collection';

import 'package:dash_kit_control_panel/src/services/logger/logger.dart';
import 'package:dash_kit_control_panel/src/ui/components/logger/ansi_parser.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

// ignore_for_file: avoid-returning-widgets
class LogConsole extends StatefulWidget {
  const LogConsole({
    this.dark = false,
    this.showCloseButton = false,
    super.key,
  });

  final bool dark;
  final bool showCloseButton;

  @override
  _LogConsoleState createState() => _LogConsoleState();
}

class _LogConsoleState extends State<LogConsole> {
  final ListQueue<RenderedEvent> _renderedBuffer = ListQueue();
  List<RenderedEvent> _filteredBuffer = [];

  final _scrollController = ScrollController();
  final _filterController = TextEditingController();

  Level _filterLevel = Level.trace;
  double _logFontSize = 14;

  var _currentId = 0;
  bool _scrollListenerEnabled = true;
  bool _followBottom = true;

  @override
  void initState() {
    super.initState();

    consoleOutput.outputCallback = (e) {
      if (_renderedBuffer.length == consoleOutput.bufferSize) {
        _renderedBuffer.removeFirst();
      }

      _renderedBuffer.add(_renderEvent(e));
      _refreshFilter();
    };

    _scrollController.addListener(
      () {
        if (!_scrollListenerEnabled) {
          return;
        }

        final scrolledToBottom = _scrollController.offset >=
            _scrollController.position.maxScrollExtent;
        setState(
          () {
            _followBottom = scrolledToBottom;
          },
        );
      },
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    _renderedBuffer.clear();
    for (final event in consoleOutput.outputEventBuffer) {
      _renderedBuffer.add(_renderEvent(event));
    }
    _refreshFilter();
  }

  @override
  void dispose() {
    consoleOutput.outputCallback = null;
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: widget.dark
          ? ThemeData(
              brightness: Brightness.dark,
              colorScheme: colorScheme.copyWith(secondary: Colors.blueGrey),
            )
          : ThemeData(
              brightness: Brightness.light,
              colorScheme:
                  colorScheme.copyWith(secondary: Colors.lightBlueAccent),
            ),
      home: Scaffold(
        body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              _buildTopBar(),
              Expanded(
                child: _buildLogContent(),
              ),
              _buildBottomBar(),
            ],
          ),
        ),
        floatingActionButton: AnimatedOpacity(
          opacity: _followBottom ? 0 : 1,
          duration: const Duration(milliseconds: 150),
          child: Padding(
            padding: const EdgeInsets.only(bottom: 60),
            child: FloatingActionButton(
              mini: true,
              clipBehavior: Clip.antiAlias,
              onPressed: _scrollToBottom,
              child: Icon(
                Icons.arrow_downward,
                color: widget.dark ? Colors.white : Colors.lightBlue[900],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _refreshFilter() {
    final newFilteredBuffer = _renderedBuffer.where((it) {
      final logLevelMatches = it.level.index >= _filterLevel.index;

      if (!logLevelMatches) {
        return false;
      } else if (_filterController.text.isNotEmpty) {
        final filterText = _filterController.text.toLowerCase();

        return it.lowerCaseText.contains(filterText);
      } else {
        return true;
      }
    }).toList();
    _filteredBuffer = newFilteredBuffer;

    if (_followBottom) {
      Future.delayed(Duration.zero, _scrollToBottom);
    }
  }

  Widget _buildLogContent() {
    return Container(
      color: widget.dark ? Colors.black : Colors.grey[150],
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: SizedBox(
          width: 1600,
          child: ListView.builder(
            shrinkWrap: true,
            controller: _scrollController,
            itemBuilder: (context, index) {
              final logEntry = _filteredBuffer[index];

              return Text.rich(
                logEntry.span,
                key: Key(logEntry.id.toString()),
                style: TextStyle(fontSize: _logFontSize),
              );
            },
            itemCount: _filteredBuffer.length,
          ),
        ),
      ),
    );
  }

  Widget _buildTopBar() {
    return LogBar(
      dark: widget.dark,
      child: Row(
        children: <Widget>[
          const Text(
            'Log Console',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const Spacer(),
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              setState(() {
                _logFontSize++;
              });
            },
          ),
          IconButton(
            icon: const Icon(Icons.remove),
            onPressed: () {
              setState(() {
                _logFontSize--;
              });
            },
          ),
          if (widget.showCloseButton)
            IconButton(
              icon: const Icon(Icons.close),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
        ],
      ),
    );
  }

  // ignore: long-method
  Widget _buildBottomBar() {
    return LogBar(
      dark: widget.dark,
      child: Row(
        children: <Widget>[
          Expanded(
            child: TextField(
              style: const TextStyle(fontSize: 20),
              controller: _filterController,
              onChanged: (s) => _refreshFilter(),
              decoration: const InputDecoration(
                labelText: 'Filter log output',
                border: OutlineInputBorder(),
              ),
            ),
          ),
          const SizedBox(width: 20),
          DropdownButton<Level>(
            value: _filterLevel,
            items: const [
              DropdownMenuItem(
                value: Level.trace,
                child: Text('TRACE'),
              ),
              DropdownMenuItem(
                value: Level.debug,
                child: Text('DEBUG'),
              ),
              DropdownMenuItem(
                value: Level.info,
                child: Text('INFO'),
              ),
              DropdownMenuItem(
                value: Level.warning,
                child: Text('WARNING'),
              ),
              DropdownMenuItem(
                value: Level.error,
                child: Text('ERROR'),
              ),
              DropdownMenuItem(
                value: Level.fatal,
                child: Text('FATAL'),
              ),
            ],
            onChanged: (value) {
              _filterLevel = value ?? Level.trace;
              _refreshFilter();
            },
          ),
        ],
      ),
    );
  }

  Future<void> _scrollToBottom() async {
    _scrollListenerEnabled = false;

    setState(() {
      _followBottom = true;
    });

    final scrollPosition = _scrollController.position;
    await _scrollController.animateTo(
      scrollPosition.maxScrollExtent,
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeOut,
    );

    _scrollListenerEnabled = true;
  }

  RenderedEvent _renderEvent(OutputEvent event) {
    final parser = AnsiParser(dark: widget.dark);
    final text = event.lines.join('\n');
    parser.parse(text);

    return RenderedEvent(
      _currentId++,
      event.level,
      TextSpan(children: parser.spans),
      text.toLowerCase(),
    );
  }
}

class LogBar extends StatelessWidget {
  const LogBar({
    required this.dark,
    required this.child,
    super.key,
  });

  final bool dark;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60,
      child: DecoratedBox(
        decoration: BoxDecoration(
          boxShadow: [
            if (!dark)
              BoxShadow(
                color: Colors.grey[400]!,
                blurRadius: 3,
              ),
          ],
        ),
        child: Material(
          color: dark ? Colors.blueGrey[900] : Colors.white,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
            child: child,
          ),
        ),
      ),
    );
  }
}

class RenderedEvent {
  RenderedEvent(
    this.id,
    this.level,
    this.span,
    this.lowerCaseText,
  );

  final int id;
  final Level level;
  final TextSpan span;
  final String lowerCaseText;
}
