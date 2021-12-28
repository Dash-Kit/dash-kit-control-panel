import 'dart:math';

import 'package:dash_kit_control_panel/dash_kit_control_panel.dart';
import 'package:dash_kit_control_panel/src/ui/resources/r.dart';
import 'package:flutter/material.dart';

class SettingGroup extends StatelessWidget {
  const SettingGroup({
    Key? key,
    required this.setting,
    required this.child,
    this.backgroundColor,
    this.onTap,
  }) : super(key: key);

  final Widget child;
  final Color? backgroundColor;
  final VoidCallback? onTap;
  final Setting setting;

  @override
  Widget build(BuildContext context) {
    if (onTap != null) {
      return GestureDetector(
        onTap: onTap,
        child: _buildContent(),
      );
    }

    return _buildContent();
  }

  Widget _buildContent() {
    return Stack(
      children: <Widget>[
        _buildSettingContent(),
        if (setting.title.isNotEmpty) _buildTitle(),
      ],
    );
  }

  Widget _buildTitle() {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 22),
        padding: const EdgeInsets.symmetric(horizontal: 4, vertical: sqrt1_2),
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 40, 40, 40),
          border: Border.all(color: R.color.settingGroupBorder),
          borderRadius: BorderRadius.circular(3),
        ),
        child: Text(
          setting.title,
          style: const TextStyle(fontSize: 11, color: Colors.white54),
        ),
      ),
    );
  }

  Widget _buildSettingContent() {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
      padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 12),
      decoration: BoxDecoration(
        border: Border.all(color: R.color.settingGroupBorder),
        borderRadius: BorderRadius.circular(5),
        color: backgroundColor ?? R.color.settingGroupBackground,
      ),
      child: child,
    );
  }
}
