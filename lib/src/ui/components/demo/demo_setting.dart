import 'package:flutter/material.dart';
import 'package:dash_kit_control_panel/src/panel/control_panel_setting.dart';
import 'package:dash_kit_control_panel/src/services/demo_mode.dart';
import 'package:dash_kit_control_panel/src/ui/components/setting_group.dart';

typedef OnDemoModeChanged = void Function(bool);

class DemoSettingProps {
  DemoSettingProps({required this.onDemoModeChanged});

  final OnDemoModeChanged onDemoModeChanged;
}

class DemoSetting extends StatefulWidget implements ControlPanelSetting {
  const DemoSetting(this.props, {Key? key}) : super(key: key);

  final DemoSettingProps props;

  @override
  Setting get setting => Setting(
        id: runtimeType.toString(),
        title: 'Demo',
      );

  @override
  _DemoSettingState createState() => _DemoSettingState();
}

class _DemoSettingState extends State<DemoSetting> {
  _DemoSettingState() : isEnabled = DemoMode.isEnabled;

  bool isEnabled;

  @override
  void initState() {
    isEnabled = DemoMode.isEnabled;

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
            const Spacer(),
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

    DemoMode.isEnabled = value;

    widget.props.onDemoModeChanged(value);
  }
}
