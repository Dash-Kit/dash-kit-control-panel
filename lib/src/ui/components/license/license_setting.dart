import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:dash_kit_control_panel/src/panel/control_panel_setting.dart';

class LicenseSetting extends StatefulWidget implements ControlPanelSetting {
  const LicenseSetting({Key? key}) : super(key: key);

  @override
  Setting get setting => Setting(
        id: runtimeType.toString(),
        title: 'License',
      );

  @override
  _LicenseSettingState createState() => _LicenseSettingState();
}

class _LicenseSettingState extends State<LicenseSetting> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
      child: RaisedButton(
        color: Colors.green.withAlpha(240),
        child: FittedBox(
          child: Text(
            'Print Licenses In Console',
            style: TextStyle(
              color: Colors.white.withAlpha(240),
              letterSpacing: 0.4,
              fontSize: 14,
            ),
          ),
        ),
        onPressed: printLicensesInConsole,
      ),
    );
  }

  void printLicensesInConsole() {
    String currentPackage = '';
    final StringBuffer output = StringBuffer();
    LicenseRegistry.licenses.listen((data) {
      for (var item in data.paragraphs) {
        if (data.packages.elementAt(0) != currentPackage) {
          output.writeln(
              '-------------------------------------------------------');
          output.writeln('--${data.packages.elementAt(0)}--');
        }
        String _indent = '';
        for (var i = -1; i < item.indent; i++) {
          _indent += ' ';
        }
        output.writeln('$_indent${item.text}');
        currentPackage = data.packages.elementAt(0);
      }
    }, onDone: () => log(output.toString()));
  }
}
