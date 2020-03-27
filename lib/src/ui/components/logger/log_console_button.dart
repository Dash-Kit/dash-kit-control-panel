import 'package:flutter/material.dart';
import 'package:flutter_platform_control_panel/src/panel/control_panel_setting.dart';
import 'package:flutter_platform_control_panel/src/ui/components/logger/log_console_modal.dart';

class LogConsoleButton extends StatelessWidget implements ControlPanelSetting {
  @override
  Setting get setting => Setting(id: runtimeType.toString());

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
      child: RaisedButton(
        color: Colors.green.withAlpha(240),
        child: FittedBox(
          child: Text(
            'Show logs',
            style: TextStyle(
              color: Colors.white.withAlpha(240),
              letterSpacing: 0.4,
              fontSize: 14,
            ),
          ),
        ),
        onPressed: () => Navigator.of(context).push(LogConsoleModal()),
      ),
    );
  }
}
