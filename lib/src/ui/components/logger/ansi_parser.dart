import 'package:flutter/material.dart';

class AnsiParser {
  AnsiParser({
    required this.dark,
  });

  // ignore: constant_identifier_names
  static const TEXT = 0;
  // ignore: constant_identifier_names
  static const BRACKET = 1;
  // ignore: constant_identifier_names
  static const CODE = 2;

  final bool dark;

  Color? foreground;
  Color? background;
  List<TextSpan>? spans;

  // ignore: long-method
  void parse(String s) {
    spans = [];
    var state = TEXT;
    StringBuffer? buffer;
    final text = StringBuffer();
    var code = 0;
    List<int>? codes;

    for (var i = 0; i < s.length; i++) {
      final c = s[i];

      switch (state) {
        case TEXT:
          if (c == '\u001b') {
            state = BRACKET;
            buffer = StringBuffer(c);
            code = 0;
            codes = [];
          } else {
            text.write(c);
          }
          break;

        case BRACKET:
          buffer?.write(c);
          if (c == '[') {
            state = CODE;
          } else {
            state = TEXT;
            text.write(buffer);
          }
          break;

        case CODE:
          buffer?.write(c);
          final codeUnit = c.codeUnitAt(0);
          if (codeUnit >= 48 && codeUnit <= 57) {
            code = code * 10 + codeUnit - 48;
            continue;
          } else if (c == ';') {
            codes?.add(code);
            code = 0;
            continue;
          } else {
            if (text.isNotEmpty) {
              spans?.add(createSpan(text.toString()));
              text.clear();
            }
            state = TEXT;
            if (c == 'm') {
              codes?.add(code);
              handleCodes(codes ?? []);
            } else {
              text.write(buffer);
            }
          }

          break;
      }
    }

    spans?.add(createSpan(text.toString()));
  }

  void handleCodes(List<int> codes) {
    if (codes.isEmpty) {
      codes.add(0);
    }

    switch (codes[0]) {
      case 0:
        foreground = getColor(colorCode: 0, foreground: true);
        background = getColor(colorCode: 0, foreground: false);
        break;
      case 38:
        foreground = getColor(colorCode: codes[2], foreground: true);
        break;
      case 39:
        foreground = getColor(colorCode: 0, foreground: true);
        break;
      case 48:
        background = getColor(colorCode: codes[2], foreground: false);
        break;
      case 49:
        background = getColor(colorCode: 0, foreground: false);
    }
  }

  Color getColor({
    required int colorCode,
    required bool foreground,
  }) {
    switch (colorCode) {
      case 0:
        return foreground ? Colors.black : Colors.transparent;
      case 12:
        return dark ? Colors.lightBlue[300]! : Colors.indigo[700]!;
      case 208:
        return dark ? Colors.orange[300]! : Colors.orange[700]!;
      case 196:
        return dark ? Colors.red[300]! : Colors.red[700]!;
      case 199:
        return dark ? Colors.pink[300]! : Colors.pink[700]!;
      default:
        return foreground ? Colors.black : Colors.transparent;
    }
  }

  TextSpan createSpan(String text) {
    return TextSpan(
      text: text,
      style: TextStyle(
        color: foreground,
        backgroundColor: background,
      ),
    );
  }
}
