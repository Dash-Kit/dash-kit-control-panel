import 'package:flutter/material.dart';
import 'package:flutter_platform_control_panel/src/panel/control_panel_setting.dart';
import 'package:flutter_platform_control_panel/src/ui/control_panel_page.dart';

class ControlPanel {
  static bool isInitialized = false;
  static GlobalKey<NavigatorState> _navigatorKey;
  static List<ControlPanelSetting> _settings = [];

  static void addSetting(ControlPanelSetting setting) {
    _settings.add(setting);
  }

  static void removeSetting(String settingID) {
    if (settingID == null || settingID.isEmpty) {
      return;
    }

    _settings.removeWhere((s) => s.settingId == settingID);
  }

  static void initialize({
    @required GlobalKey<NavigatorState> navigatorKey,
    @required List<ControlPanelSetting> settings,
  }) {
    _navigatorKey = navigatorKey;
    _settings.removeRange(0, _settings.length);
    _settings.addAll(settings);

    isInitialized = true;
  }

  static void open() {
    if (!isInitialized) {
      throw Exception(
          'Control Panel is not initialized. Call `initialize` method before opening the panel.');
    }

    _navigatorKey.currentState.push(
      MaterialPageRoute(builder: (context) {
        return ControlPanelPage(settings: _settings);
      }),
    );
  }
}
