import 'package:dash_kit_control_panel/src/panel/control_panel_setting.dart';
import 'package:dash_kit_control_panel/src/ui/components/control_panel_title.dart';
import 'package:dash_kit_control_panel/src/ui/theme/app_theme.dart';
import 'package:flutter/material.dart';

class ControlPanelPage extends StatelessWidget {
  const ControlPanelPage({
    required this.settings,
    super.key,
  });

  final List<ControlPanelSetting> settings;

  @override
  Widget build(BuildContext context) {
    return AppTheme(
      child: Builder(
        builder: (context) {
          return Scaffold(
            appBar: AppBar(
              title: const ControlPanelTitle(title: 'Control Panel'),
              backgroundColor: AppTheme.of(context).colors.appBarBackground,
              leading: BackButton(color: AppTheme.of(context).colors.backButton),
            ),
            backgroundColor: AppTheme.of(context).colors.panelBackground,
            body: SafeArea(
              child: GestureDetector(
                behavior: HitTestBehavior.translucent,
                onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
                child: SizedBox.expand(
                  child: ListView(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    children: settings,
                  ),
                ),
              ),
            ),
          );
        }
      ),
    );
  }
}
