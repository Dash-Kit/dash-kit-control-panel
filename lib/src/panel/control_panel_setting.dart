import 'package:flutter/widgets.dart';

class Setting {
  final String id;
  final String title;

  Setting({
    @required this.id,
    this.title,
  });
}

abstract class ControlPanelSetting extends Widget {
  Setting get setting;
}
