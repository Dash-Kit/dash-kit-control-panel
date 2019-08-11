import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_platform_control_panel/control_panel.dart';
import 'package:flutter_platform_control_panel/src/ui/resources/R.dart';

class SettingGroup extends StatelessWidget {
  final Widget child;
  final Color backgroundColor;
  final VoidCallback onTap;
  final Setting setting;

  const SettingGroup({
    Key key,
    this.setting,
    this.child,
    this.backgroundColor,
    this.onTap,
  }) : super(key: key);

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
        if (setting?.title != null) _buildTitle(),
      ],
    );
  }

  Widget _buildTitle() {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 22),
        padding: EdgeInsets.symmetric(horizontal: 4, vertical: sqrt1_2),
        decoration: BoxDecoration(
          color: Color.fromARGB(255, 40, 40, 40),
          border: Border.all(color: R.color.settingGroupBorder),
          borderRadius: BorderRadius.circular(3),
        ),
        child: Text(
          setting.title,
          style: TextStyle(fontSize: 11, color: Colors.white54),
        ),
      ),
    );
  }

  Widget _buildSettingContent() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 10),
      padding: EdgeInsets.symmetric(vertical: 4, horizontal: 12),
      decoration: BoxDecoration(
        border: Border.all(color: R.color.settingGroupBorder),
        borderRadius: BorderRadius.circular(5),
        color: backgroundColor ?? R.color.settingGroupBackground,
      ),
      child: child,
    );
  }
}