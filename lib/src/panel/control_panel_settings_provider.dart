// ignore_for_file: one_member_abstracts

import 'package:dash_kit_control_panel/dash_kit_control_panel.dart';

abstract class ControlPanelSettingsProvider {
  Future<List<ControlPanelSetting>> buildSettings();
}
