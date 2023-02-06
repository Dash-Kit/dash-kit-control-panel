import 'package:dash_kit_control_panel/src/panel/control_panel_setting.dart';
import 'package:dash_kit_control_panel/src/ui/components/control_panel_title.dart';
import 'package:dash_kit_control_panel/src/ui/resources/r.dart';
import 'package:flutter/material.dart';

// ignore_for_file: avoid-returning-widgets
class ControlPanelPage extends StatelessWidget {
  const ControlPanelPage({
    required this.settings,
    super.key,
  });

  final List<ControlPanelSetting> settings;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const ControlPanelTitle(title: 'Control Panel'),
        backgroundColor: R.color.appBarBackground,
      ),
      backgroundColor: R.color.panelBackground,
      body: SafeArea(
        child: GestureDetector(
          behavior: HitTestBehavior.translucent,
          onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
          child: SizedBox.expand(
            child: _buildSettings(),
          ),
        ),
      ),
    );
  }

  Widget _buildSettings() {
    return ListView(
      padding: const EdgeInsets.symmetric(vertical: 12),
      children: settings,
    );
  }
}
