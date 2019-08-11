import 'package:flutter/material.dart';
import 'package:flutter_platform_control_panel/src/panel/control_panel_setting.dart';
import 'package:flutter_platform_control_panel/src/ui/components/setting_group.dart';

typedef OnDemoModeChanged = void Function(bool);

class DemoSettingProps {
  final OnDemoModeChanged onDemoModeChanged;
  final bool initialValue;

  DemoSettingProps({this.onDemoModeChanged, this.initialValue});
}

class DemoSetting extends StatefulWidget implements ControlPanelSetting {
  final DemoSettingProps props;

  @override
  Setting get setting => Setting(
        id: runtimeType.toString(),
        title: 'Demo',
      );

  const DemoSetting(this.props, {Key key}) : super(key: key);

  @override
  _DemoSettingState createState() => _DemoSettingState();
}

class _DemoSettingState extends State<DemoSetting> {
  bool isEnabled;

  @override
  void initState() {
    isEnabled = widget.props.initialValue ?? false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SettingGroup(
      setting: widget.setting,
      onTap: () => onChanged(!isEnabled),
      child: Container(
        height: 36,
        child: Row(
          children: <Widget>[
            Container(
              child: Text(
                'Demo mode',
                style: TextStyle(
                  color: Colors.white.withAlpha(240),
                  fontSize: 15,
                ),
              ),
            ),
            Spacer(),
            Switch(
              value: isEnabled,
              onChanged: onChanged,
              activeTrackColor: Colors.grey,
              activeColor: Colors.green,
            ),
          ],
        ),
      ),
    );
  }

  void onChanged(bool value) {
    setState(() => isEnabled = value);

    widget.props.onDemoModeChanged(value);
  }
}
