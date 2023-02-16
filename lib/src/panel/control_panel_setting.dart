import 'package:flutter/widgets.dart';

abstract class ControlPanelSetting extends Widget {
  const ControlPanelSetting({super.key});

  Setting get setting;
}

class Setting {
  Setting({
    required this.id,
    this.title = '',
  });

  final String id;
  final String title;
}
