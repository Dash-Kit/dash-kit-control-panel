import 'dart:math';

import 'package:dash_kit_control_panel/dash_kit_control_panel.dart';
import 'package:dash_kit_control_panel/src/ui/theme/app_colors.dart';
import 'package:flutter/material.dart';

class SettingGroup extends StatelessWidget {
  const SettingGroup({
    required this.setting,
    required this.child,
    this.backgroundColor,
    this.onTap,
    super.key,
  });

  final Widget child;
  final Color? backgroundColor;
  final VoidCallback? onTap;
  final Setting setting;

  @override
  Widget build(BuildContext context) {
    final widget = Stack(
      children: <Widget>[
        Container(
          margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
          padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 12),
          decoration: BoxDecoration(
            border: Border.all(
              color: AppColors.of(context).settingGroupBorder,
            ),
            borderRadius: BorderRadius.circular(5),
            color:
                backgroundColor ?? AppColors.of(context).settingGroupBackground,
          ),
          child: child,
        ),
        if (setting.title.isNotEmpty)
          Align(
            alignment: Alignment.centerLeft,
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 22),
              padding: const EdgeInsets.symmetric(
                horizontal: 4,
                vertical: sqrt1_2,
              ),
              decoration: BoxDecoration(
                color: AppColors.of(context).settingLabelBackground,
                border: Border.all(
                  color: AppColors.of(context).settingGroupBorder,
                ),
                borderRadius: BorderRadius.circular(3),
              ),
              child: Text(
                setting.title,
                style: TextStyle(
                  fontSize: 11,
                  color: AppColors.of(context).title,
                ),
              ),
            ),
          ),
      ],
    );

    if (onTap != null) {
      return GestureDetector(
        onTap: onTap,
        child: widget,
      );
    }

    return widget;
  }
}
