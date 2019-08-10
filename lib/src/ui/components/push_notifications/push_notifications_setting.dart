import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_platform_control_panel/src/panel/control_panel_setting.dart';

class PushNotificationsSettingProps {
  final Future<String> getToken;

  PushNotificationsSettingProps({
    this.getToken,
  });
}

class PushNotificationsSetting extends StatefulWidget
    implements ControlPanelSetting {
  final PushNotificationsSettingProps props;

  const PushNotificationsSetting(this.props, {Key key}) : super(key: key);

  @override
  _PushNotificationsSettingState createState() =>
      _PushNotificationsSettingState();

  @override
  Setting get setting => Setting(id: runtimeType.toString());
}

class _PushNotificationsSettingState extends State<PushNotificationsSetting> {
  final tokenController = TextEditingController();

  String token;
  bool get hasToken => token != null && token.isNotEmpty;

  @override
  void initState() {
    final getToken = widget.props.getToken;
    if (getToken != null) {
      getToken.then((pushToken) => setState(() {
            tokenController.text = pushToken;
            return token = pushToken;
          }));
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: Form(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              children: <Widget>[
                Expanded(child: buildPushTokenInputField()),
                buildCopyTokenButton(),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Padding buildCopyTokenButton() {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0),
      child: Container(
        width: 70,
        height: 30,
        child: RaisedButton(
          padding: EdgeInsets.symmetric(vertical: 6, horizontal: 10),
          color: hasToken ? Colors.green.withAlpha(245) : Colors.grey.shade700,
          disabledColor: Colors.grey.shade700,
          child: Text(
            'Copy',
            style: TextStyle(
              fontSize: 13,
              color: Colors.white,
              letterSpacing: 0.2,
            ),
          ),
          onPressed: hasToken ? copyTokenToClipboard : null,
        ),
      ),
    );
  }

  TextFormField buildPushTokenInputField() {
    return TextFormField(
      controller: tokenController,
      decoration: InputDecoration(
        labelText: hasToken ? 'Device token:' : 'No device token',
        labelStyle: TextStyle(
          color: Colors.white70,
          fontSize: 14,
        ),
        contentPadding: EdgeInsets.only(bottom: 4, top: 4),
        focusedBorder: UnderlineInputBorder(
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

  void copyTokenToClipboard() {
    Clipboard.setData(ClipboardData(text: token));

    final snackBar = SnackBar(
      content: Text('Device token copied to the clipboard'),
      duration: Duration(seconds: 1),
    );
    Scaffold.of(context).showSnackBar(snackBar);
  }
}
