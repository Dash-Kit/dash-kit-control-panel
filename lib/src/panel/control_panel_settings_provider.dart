import 'package:flutter_platform_control_panel/control_panel.dart';

abstract class ControlPanelSettingsProvider {
  Future<List<ControlPanelSetting>> buildSettings();
}
