import 'package:flutter/material.dart';
import 'package:flutter_platform_control_panel/src/panel/control_panel_setting.dart';
import 'package:package_info/package_info.dart';

class VersionSetting extends StatefulWidget implements ControlPanelSetting {
  @override
  Setting get setting => Setting(id: runtimeType.toString());

  @override
  _VersionSettingState createState() => _VersionSettingState();
}

class _VersionSettingState extends State<VersionSetting> {
  Map<String, String> fields = {};
  bool showFullDetails = false;

  @override
  void initState() {
    requestPackageInfo();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () => setState(() => showFullDetails = !showFullDetails),
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        padding: EdgeInsets.only(right: 3),
        child: AnimatedCrossFade(
          duration: Duration(milliseconds: 400),
          firstChild: buildVersion(),
          secondChild: buildItems(),
          crossFadeState: !showFullDetails
              ? CrossFadeState.showFirst
              : CrossFadeState.showSecond,
        ),
      ),
    );
  }

  Widget buildVersion() {
    final versionInfo = fields.entries.first;
    if (versionInfo == null) {
      return Container();
    }

    return buildInfoField(versionInfo.key, versionInfo.value);
  }

  Widget buildItems() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: fields.entries.map((e) {
        return Column(
          children: <Widget>[
            buildInfoField(e.key, e.value),
            if (e.key != fields.entries.last?.key) buildDivider(),
          ],
        );
      }).toList(),
    );
  }

  Container buildInfoField(String title, String value) {
    return Container(
      margin: EdgeInsets.fromLTRB(0, 8, 0, 8),
      child: Row(
        children: <Widget>[
          Text(
            title ?? '',
            style: TextStyle(
              color: Colors.white.withAlpha(240),
              fontWeight: FontWeight.w600,
              fontSize: 15,
            ),
          ),
          Spacer(),
          Text(
            value ?? '',
            style: TextStyle(
              color: Colors.white.withAlpha(200),
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }

  Container buildDivider() {
    return Container(
      color: Colors.white.withAlpha(30),
      width: double.infinity,
      height: 0.5,
    );
  }

  void requestPackageInfo() {
    PackageInfo.fromPlatform().then((packageInfo) {
      final version = packageInfo.version ?? '';
      final buildNumber = packageInfo.buildNumber ?? '';
      final appVersion = version.isNotEmpty && buildNumber.isNotEmpty
          ? '$version ($buildNumber)'
          : '(not defined)';

      setState(() {
        fields = {
          'App Version:': appVersion,
          'App Name:': packageInfo.appName ?? '',
          'Package Name:': packageInfo.packageName ?? '',
        };
      });
    }).catchError((error) {
      print('Error on getting package info: ' + error?.toString());
    });
  }
}
