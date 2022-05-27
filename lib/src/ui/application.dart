import 'package:dash_kit_control_panel/src/services/device_preview_mode.dart';
import 'package:device_preview/device_preview.dart';
import 'package:flutter/cupertino.dart';

class Application extends StatelessWidget {
  const Application({required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<bool>(
      stream: DevicePreviewMode.onModeChanged,
      builder: (context, snapShoot) => DevicePreview(
          enabled: snapShoot.hasData && snapShoot.data!,
          builder: (context) => child),
    );
  }

  static Widget appBuilder(
    BuildContext context,
    Widget widget,
  ) {
    return DevicePreview.appBuilder(context, widget);
  }
}
