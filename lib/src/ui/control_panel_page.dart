import 'package:flutter/material.dart';
import 'package:flutter_platform_control_panel/src/panel/control_panel_setting.dart';
import 'package:flutter_platform_control_panel/src/ui/components/control_panel_title.dart';

class ControlPanelPage extends StatelessWidget {
  final List<ControlPanelSetting> settings;

  const ControlPanelPage({Key key, this.settings});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      primary: true,
      appBar: AppBar(
        title: ControlPanelTitle(title: 'Control Panel'),
        backgroundColor: Color.fromARGB(155, 40, 40, 40),
      ),
      backgroundColor: Color.fromARGB(155, 60, 60, 60),
      body: SafeArea(
        child: GestureDetector(
          behavior: HitTestBehavior.translucent,
          onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
          child: Container(
            width: double.infinity,
            height: double.infinity,
            child: buildSettings(),
          ),
        ),
      ),
    );
  }

  Column buildSettings() {
    return Column(
      children: settings ?? [],
    );
  }
}
