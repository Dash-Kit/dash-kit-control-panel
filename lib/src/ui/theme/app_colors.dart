import 'package:flutter/material.dart';

class AppColors {
  const AppColors._({
    required this.backButton,
    required this.panelBackground,
    required this.appBarBackground,
    required this.settingGroupBackground,
    required this.settingGroupBorder,
    required this.settingLabelBackground,
    required this.text,
    required this.title,
  });

  factory AppColors.light() {
    return AppColors._(
      backButton: Colors.black,
      panelBackground: Colors.white,
      appBarBackground: Colors.white,
      settingGroupBackground: Colors.grey[100]!,
      settingGroupBorder: Colors.black.withValues(alpha: 0.05),
      settingLabelBackground: Colors.grey[200]!,
      text: Colors.black.withAlpha(240),
      title: Colors.black54,
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
      text: Colors.white.withAlpha(240),
      title: Colors.white54,
    );
  }

  final Color backButton;
  final Color panelBackground;
  final Color appBarBackground;
  final Color settingGroupBackground;
  final Color settingGroupBorder;
  final Color settingLabelBackground;
  final Color text;
  final Color title;

  // ignore: prefer_constructors_over_static_methods
  static AppColors of(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark
        ? AppColors.dark()
        : AppColors.light();
  }
}
