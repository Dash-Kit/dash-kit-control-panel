import 'package:flutter/material.dart';

class ControlPanelTitle extends StatelessWidget {
  const ControlPanelTitle({
    required this.title,
    super.key,
  });

  final String title;

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: const TextStyle(
        color: Colors.green,
        fontSize: 18,
        fontWeight: FontWeight.w500,
        letterSpacing: 1.7,
      ),
    );
  }
}
