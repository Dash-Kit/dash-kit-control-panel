import 'package:flutter/material.dart';
import 'package:flutter_platform_control_panel/src/panel/control_panel_setting.dart';
import 'package:flutter_platform_control_panel/src/ui/components/control_panel_title.dart';
import 'package:flutter_platform_control_panel/src/ui/resources/R.dart';

class ControlPanelPage extends StatelessWidget {
  final List<ControlPanelSetting> settings;

  const ControlPanelPage({Key key, this.settings});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      primary: true,
      appBar: AppBar(
        title: ControlPanelTitle(title: 'Control Panel'),
        backgroundColor: R.color.appBarBackground,
      ),
      backgroundColor: R.color.panelBackground,
      body: SafeArea(
        child: GestureDetector(
          behavior: HitTestBehavior.translucent,
          onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
          child: Container(
            width: double.infinity,
            height: double.infinity,
            child: _buildSettings(),
          ),
        ),
      ),
    );
  }

  Widget _buildSettings() {
    return ListView(
      padding: EdgeInsets.symmetric(vertical: 12),
      children: settings ?? [],
    );
  }
}
