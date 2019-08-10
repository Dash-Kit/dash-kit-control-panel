import 'package:alice/alice.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_control_panel/src/panel/control_panel_setting.dart';

class NetworkSettingProps {
  final Alice alice;

  NetworkSettingProps({this.alice});
}

class NetworkSetting extends StatelessWidget implements ControlPanelSetting {
  final NetworkSettingProps props;

  @override
  Setting get setting => Setting(id: runtimeType.toString());

  const NetworkSetting(this.props, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 16, horizontal: 16),
      child: RaisedButton(
        color: Colors.green.withAlpha(240),
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
        onPressed: () => props.alice.showInspector(),
      ),
    );
  }
}
