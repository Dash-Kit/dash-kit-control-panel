import 'package:flutter/material.dart';
import 'package:dash_kit_control_panel/src/panel/control_panel_setting.dart';
import 'package:dash_kit_control_panel/src/ui/components/control_panel_title.dart';
import 'package:dash_kit_control_panel/src/ui/resources/r.dart';

class ControlPanelPage extends StatelessWidget {
  const ControlPanelPage({Key key, this.settings}) : super(key: key);

  final List<ControlPanelSetting> settings;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      primary: true,
      appBar: AppBar(
        title: const ControlPanelTitle(title: 'Control Panel'),
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
      padding: const EdgeInsets.symmetric(vertical: 12),
      children: settings ?? [],
    );
  }
}
