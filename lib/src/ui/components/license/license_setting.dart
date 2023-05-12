import 'dart:developer';

import 'package:dash_kit_control_panel/src/panel/control_panel_setting.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class LicenseSetting extends StatefulWidget implements ControlPanelSetting {
  const LicenseSetting({super.key});

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
      margin: const EdgeInsets.all(16),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.green.withAlpha(240),
        ),
        onPressed: printLicensesInConsole,
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
      ),
    );
  }

  void printLicensesInConsole() {
    var currentPackage = '';
    final output = StringBuffer();
    LicenseRegistry.licenses.listen(
      (data) {
        for (final item in data.paragraphs) {
          final firstPackage = data.packages.elementAt(0);
          if (firstPackage != currentPackage) {
            output
              ..writeln(
                '-------------------------------------------------------',
              )
              ..writeln('--${data.packages.elementAt(0)}--');
          }
          final buffer = StringBuffer();
          for (var i = -1; i < item.indent; i++) {
            buffer.write(' ');
          }
          output.writeln('$buffer${item.text}');
          currentPackage = firstPackage;
        }
      },
      onDone: () => log(
        output.toString(),
      ),
    );
  }
}
