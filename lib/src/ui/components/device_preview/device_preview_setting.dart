import 'package:dash_kit_control_panel/dash_kit_control_panel.dart';
import 'package:dash_kit_control_panel/src/ui/theme/app_colors.dart';
import 'package:flutter/material.dart';

class DevicePreviewSetting extends StatefulWidget
    implements ControlPanelSetting {
  const DevicePreviewSetting({super.key});

  @override
  Setting get setting => Setting(
        id: runtimeType.toString(),
        title: 'Device Preview',
      );

  @override
  _DevicePreviewSettingState createState() => _DevicePreviewSettingState();
}

class _DevicePreviewSettingState extends State<DevicePreviewSetting> {
  _DevicePreviewSettingState() : isEnabled = DevicePreviewMode.isEnabled;

  bool isEnabled;

  @override
  void initState() {
    isEnabled = DevicePreviewMode.isEnabled;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SettingGroup(
      setting: widget.setting,
      onTap: () => onChanged(!isEnabled),
      child: SizedBox(
        height: 36,
        child: Row(
          children: <Widget>[
            Text(
              'Device Preview mode',
              style: TextStyle(
                color: AppColors.of(context).text,
                fontSize: 15,
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

  // ignore: avoid_positional_boolean_parameters
  void onChanged(bool value) {
    setState(() => isEnabled = value);

    DevicePreviewMode.isEnabled = value;
  }
}
