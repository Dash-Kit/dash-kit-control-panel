import 'package:dash_kit_control_panel/src/ui/theme/app_colors.dart';
import 'package:flutter/material.dart';

class AppTheme extends StatefulWidget {
  const AppTheme({required this.child, super.key});

  final Widget child;

  @override
  State<StatefulWidget> createState() {
    return _AppThemeState();
  }

  static _AppThemeState of(BuildContext context) {
    return context.findAncestorStateOfType()!;
  }
}

class _AppThemeState extends State<AppTheme> {
  AppColors colors = AppColors.light();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    colors = _getColorsFromTheme();
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }

  AppColors _getColorsFromTheme() {
    return Theme.of(context).brightness == Brightness.dark
        ? AppColors.dark()
        : AppColors.light();
  }
}
