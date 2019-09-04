import 'package:flutter/material.dart';
import 'package:flutter_platform_control_panel/src/panel/control_panel_settings_provider.dart';
import 'package:flutter_platform_control_panel/src/ui/control_panel_page.dart';

class ControlPanel {
  static bool isInitialized = false;
  static GlobalKey<NavigatorState> _navigatorKey;
  static ControlPanelSettingsProvider _settingsProvider;

  static void initialize({
    @required GlobalKey<NavigatorState> navigatorKey,
    @required ControlPanelSettingsProvider settingsProvider,
  }) {
    _navigatorKey = navigatorKey;
    _settingsProvider = settingsProvider;

    isInitialized = true;
  }

  static void open() async {
    if (!isInitialized) {
      throw Exception(
          'Control Panel is not initialized. Call `initialize` method before opening the panel.');
    }

    final settings = await _settingsProvider.buildSettings();

    _navigatorKey.currentState.push(
      MaterialPageRoute(
        builder: (context) => ControlPanelPage(settings: settings),
      ),
    );
  }
}
