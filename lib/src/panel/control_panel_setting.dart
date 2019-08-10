import 'package:flutter/widgets.dart';

class Setting {
  final String id;

  Setting({
    @required this.id,
  });
}

abstract class ControlPanelSetting extends Widget {
  Setting get setting;
}
