import 'package:dash_kit_control_panel/src/panel/control_panel_setting.dart';
import 'package:dash_kit_control_panel/src/services/demo_mode.dart';
import 'package:dash_kit_control_panel/src/ui/components/setting_group.dart';
import 'package:dash_kit_control_panel/src/ui/theme/app_colors.dart';
import 'package:flutter/material.dart';

class DemoSetting extends StatefulWidget implements ControlPanelSetting {
  const DemoSetting(this.props, {super.key});

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
      onTap: () => onChanged(value: !isEnabled),
      child: SizedBox(
        height: 36,
        child: Row(
          children: <Widget>[
            Text(
              'Demo mode',
              style: TextStyle(
                color: AppColors.of(context).text,
                fontSize: 15,
              ),
            ),
            const Spacer(),
            Switch(
              value: isEnabled,
              onChanged: (value) => onChanged(value: value),
              activeTrackColor: Colors.grey,
              activeColor: Colors.green,
            ),
          ],
        ),
      ),
    );
  }

  void onChanged({required bool value}) {
    setState(() => isEnabled = value);

    DemoMode.isEnabled = value;

    widget.props.onDemoModeChanged(value);
  }
}

class DemoSettingProps {
  DemoSettingProps({required this.onDemoModeChanged});

  final ValueChanged<bool> onDemoModeChanged;
}
