import 'dart:developer';

import 'package:dash_kit_control_panel/src/panel/control_panel_setting.dart';
import 'package:dash_kit_control_panel/src/ui/components/setting_group.dart';
import 'package:dash_kit_control_panel/src/ui/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';

// ignore_for_file: avoid-returning-widgets
class VersionSetting extends StatefulWidget implements ControlPanelSetting {
  const VersionSetting({super.key});

  @override
  Setting get setting => Setting(
        id: runtimeType.toString(),
        title: 'App',
      );

  @override
  _VersionSettingState createState() => _VersionSettingState();
}

class _VersionSettingState extends State<VersionSetting> {
  Map<String, String> fields = {};
  bool showFullDetails = false;

  @override
  void initState() {
    _requestPackageInfo();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SettingGroup(
      setting: widget.setting,
      onTap: () => setState(() => showFullDetails = !showFullDetails),
      child: AnimatedCrossFade(
        duration: const Duration(milliseconds: 400),
        firstChild: _buildVersionInfo(),
        secondChild: _buildAppInfoItems(),
        crossFadeState: !showFullDetails
            ? CrossFadeState.showFirst
            : CrossFadeState.showSecond,
      ),
    );
  }

  Widget _buildVersionInfo() {
    final versionInfo = fields.entries.isNotEmpty ? fields.entries.first : null;
    if (versionInfo == null) {
      return Container();
    }

    return _buildInfoField(versionInfo.key, versionInfo.value);
  }

  Widget _buildAppInfoItems() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: fields.entries.map((e) {
        return Column(
          children: <Widget>[
            _buildInfoField(e.key, e.value),
            if (e.key != fields.entries.last.key) _buildDivider(),
          ],
        );
      }).toList(),
    );
  }

  Container _buildInfoField(String title, String value) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: <Widget>[
          Text(
            title,
            style: TextStyle(
              color: AppColors.of(context).text,
              fontWeight: FontWeight.w400,
              fontSize: 15,
            ),
          ),
          const Spacer(),
          Text(
            value,
            style: TextStyle(
              color: AppColors.of(context).text,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }

  Container _buildDivider() {
    return Container(
      color: Colors.white.withAlpha(30),
      width: double.infinity,
      height: 0.5,
    );
  }

  void _requestPackageInfo() {
    PackageInfo.fromPlatform().then((packageInfo) {
      final version = packageInfo.version;
      final buildNumber = packageInfo.buildNumber;
      final appVersion = version.isNotEmpty && buildNumber.isNotEmpty
          ? '$version ($buildNumber)'
          : '(not defined)';

      setState(() {
        fields = {
          'App Version:': appVersion,
          'App Name:': packageInfo.appName,
          'Package Name:': packageInfo.packageName,
        };
      });
    }).catchError((error) {
      log('Error on getting package info: $error');
    });
  }
}
