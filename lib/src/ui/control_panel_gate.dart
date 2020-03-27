import 'package:flutter/material.dart';
import 'package:flutter_platform_control_panel/src/panel/control_panel.dart';

class ControlPanelGate extends StatelessWidget {
  const ControlPanelGate({Key key, @required this.child}) : super(key: key);

  static DateTime _lastDoubleTapEvent;

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onDoubleTap: () {
        final now = DateTime.now();
        final diff = _lastDoubleTapEvent != null
            ? now.millisecondsSinceEpoch -
                _lastDoubleTapEvent.millisecondsSinceEpoch
            : -1;

        if (_lastDoubleTapEvent != null && diff >= 0 && diff <= 2500) {
          _lastDoubleTapEvent = null;

          ControlPanel.open();
        }

        _lastDoubleTapEvent = now;
      },
      child: child,
    );
  }
}
