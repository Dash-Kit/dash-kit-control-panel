import 'package:flutter/material.dart';
import 'package:flutter_platform_control_panel/src/panel/control_panel_setting.dart';

typedef OnDemoModeChanged = void Function(bool);

class DemoSettingProps {
  final OnDemoModeChanged onDemoModeChanged;
  final bool initialValue;

  DemoSettingProps({this.onDemoModeChanged, this.initialValue});
}

class DemoSetting extends StatelessWidget implements ControlPanelSetting {
  final DemoSettingProps props;

  @override
  Setting get setting => Setting(id: runtimeType.toString());

  const DemoSetting(this.props, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: Row(
        children: <Widget>[
          Text(
            'Demo mode',
            style: TextStyle(
              color: Colors.white.withAlpha(240),
              fontSize: 15,
            ),
          ),
          Spacer(),
          Switch(
            value: props.initialValue,
            onChanged: props.onDemoModeChanged,
            activeTrackColor: Colors.grey,
            activeColor: Colors.green,
          ),
        ],
      ),
    );
  }
}
