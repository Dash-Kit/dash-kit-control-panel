import 'package:dash_kit_control_panel/src/panel/control_panel_setting.dart';
import 'package:dash_kit_control_panel/src/ui/components/setting_group.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// ignore_for_file: avoid-returning-widgets

class PushNotificationsSetting extends StatefulWidget
    implements ControlPanelSetting {
  const PushNotificationsSetting(this.props, {super.key});

  final PushNotificationsSettingProps props;

  @override
  Setting get setting => Setting(
        id: runtimeType.toString(),
        title: props.title,
      );

  @override
  _PushNotificationsSettingState createState() =>
      _PushNotificationsSettingState();
}

class _PushNotificationsSettingState extends State<PushNotificationsSetting> {
  final tokenController = TextEditingController();

  String token = '';

  bool get hasToken => token.isNotEmpty;

  @override
  void initState() {
    widget.props.getToken.then(
      (pushToken) => setState(
        () {
          tokenController.text = pushToken ?? '';
          token = tokenController.text;
        },
      ),
    );

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SettingGroup(
      setting: widget.setting,
      child: Container(
        padding: const EdgeInsets.only(top: 6, bottom: 4),
        child: Form(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                children: <Widget>[
                  Expanded(child: _buildPushTokenInputField()),
                  _buildCopyTokenButton(),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Padding _buildCopyTokenButton() {
    return Padding(
      padding: const EdgeInsets.only(left: 8),
      child: SizedBox(
        width: 70,
        height: 30,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 10),
            backgroundColor:
                hasToken ? Colors.green.withAlpha(245) : Colors.grey.shade700,
          ),
          onPressed: hasToken ? _copyTokenToClipboard : null,
          child: const Text(
            'Copy',
            style: TextStyle(
              fontSize: 13,
              color: Colors.white,
              letterSpacing: 0.2,
            ),
          ),
        ),
      ),
    );
  }

  TextFormField _buildPushTokenInputField() {
    return TextFormField(
      controller: tokenController,
      decoration: InputDecoration(
        labelText: hasToken ? '${widget.props.label}:' : 'No value',
        labelStyle: const TextStyle(
          color: Colors.white70,
          fontSize: 14,
        ),
        contentPadding: const EdgeInsets.symmetric(vertical: 4),
        focusedBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.green),
        ),
      ),
      style: TextStyle(
        color: Colors.white.withAlpha(210),
        fontSize: 15,
      ),
      keyboardType: TextInputType.text,
      maxLines: null,
      enabled: false,
    );
  }

  void _copyTokenToClipboard() {
    Clipboard.setData(ClipboardData(text: token));

    final snackBar = SnackBar(
      content: Text('${widget.props.label} copied to the clipboard'),
      duration: const Duration(seconds: 1),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}

class PushNotificationsSettingProps {
  PushNotificationsSettingProps({
    required this.getToken,
    this.title = 'Push Notifications',
    this.label = 'Device token',
  });

  final Future<String?> getToken;
  final String title;
  final String label;
}
