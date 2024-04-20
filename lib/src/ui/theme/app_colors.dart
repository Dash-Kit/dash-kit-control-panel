import 'package:flutter/material.dart';

class AppColors {
  const AppColors._({
    required this.backButton,
    required this.panelBackground,
    required this.appBarBackground,
    required this.settingGroupBackground,
    required this.settingGroupBorder,
    required this.settingLabelBackground,
  });

  factory AppColors.light() {
    return AppColors._(
      backButton: Colors.black,
      panelBackground: Colors.white,
      appBarBackground: Colors.white,
      settingGroupBackground: Colors.black.withOpacity(0.1),
      settingGroupBorder: Colors.black.withOpacity(0.2),
      settingLabelBackground: Colors.black.withOpacity(0.2),
    );
  }

  factory AppColors.dark() {
    return AppColors._(
      backButton: Colors.white,
      panelBackground: const Color.fromARGB(155, 60, 60, 60),
      appBarBackground: const Color.fromARGB(155, 40, 40, 40),
      settingGroupBackground: Colors.black.withAlpha(17),
      settingGroupBorder: Colors.black.withAlpha(50),
      settingLabelBackground: const Color.fromARGB(255, 40, 40, 40),
    );
  }

  final Color backButton;
  final Color panelBackground;
  final Color appBarBackground;
  final Color settingGroupBackground;
  final Color settingGroupBorder;
  final Color settingLabelBackground;
}
