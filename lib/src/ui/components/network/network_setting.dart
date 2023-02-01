import 'package:alice_lightweight/alice.dart';
import 'package:dash_kit_control_panel/src/panel/control_panel_setting.dart';
import 'package:flutter/material.dart';

class NetworkSettingProps {
  NetworkSettingProps({required this.alice});

  final Alice alice;
}

class NetworkSetting extends StatelessWidget implements ControlPanelSetting {
  const NetworkSetting(this.props, {super.key});

  final NetworkSettingProps props;

  @override
  Setting get setting => Setting(id: runtimeType.toString());

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(16),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.green.withAlpha(240),
        ),
        onPressed: props.alice.showInspector,
        child: FittedBox(
          child: Text(
            'Show network activity',
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
}
