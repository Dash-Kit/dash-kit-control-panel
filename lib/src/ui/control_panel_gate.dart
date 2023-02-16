import 'package:dash_kit_control_panel/src/panel/control_panel.dart';
import 'package:flutter/material.dart';

class ControlPanelGate extends StatelessWidget {
  const ControlPanelGate({
    required this.child,
    this.isEnabled = true,
    super.key,
  });

  static DateTime? _lastDoubleTapEvent;

  final Widget child;
  final bool isEnabled;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onDoubleTap: isEnabled ? _onDoubleTap : null,
      child: child,
    );
  }

  void _onDoubleTap() {
    // ignore: ban-name
    final now = DateTime.now();
    final diff = _lastDoubleTapEvent != null
        ? now.millisecondsSinceEpoch -
            _lastDoubleTapEvent!.millisecondsSinceEpoch
        : -1;

    if (_lastDoubleTapEvent != null && diff >= 0 && diff <= 2500) {
      _lastDoubleTapEvent = null;

      ControlPanel.open();
    }

    _lastDoubleTapEvent = now;
  }
}
