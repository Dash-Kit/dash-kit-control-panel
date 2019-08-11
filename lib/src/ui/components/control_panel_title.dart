import 'package:flutter/material.dart';

class ControlPanelTitle extends StatelessWidget {
  final String title;

  const ControlPanelTitle({Key key, @required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: TextStyle(
        color: Colors.green,
        fontSize: 18,
        fontWeight: FontWeight.w500,
        letterSpacing: 1.7,
      ),
    );
  }
}
