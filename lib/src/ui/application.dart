import 'package:flutter/cupertino.dart';

class Application extends StatelessWidget {
  const Application({required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return child;
  }

  static Widget appBuilder(
    BuildContext context,
    Widget widget,
  ) {
    return widget;
  }
}
