import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:dash_kit_control_panel/src/panel/control_panel_setting.dart';
import 'package:dash_kit_control_panel/src/services/proxy_manager.dart';
import 'package:dash_kit_control_panel/src/ui/components/setting_group.dart';

typedef OnProxyIpChanged = void Function(String);
typedef OnProxyModeChanged = void Function(bool);

class ProxySettingProps {
  ProxySettingProps({
    required this.isEnabled,
    required this.onProxyModeChanged,
    required this.onProxyIpChanged,
    required this.initialProxyIpAddress,
  });

  final OnProxyIpChanged onProxyIpChanged;
  final String initialProxyIpAddress;
  final bool isEnabled;
  final OnProxyModeChanged onProxyModeChanged;

  static Future<dynamic> init(OnProxyIpChanged onProxyChanged) async {
    _onProxyChanged(onProxyChanged);
  }

  static Future<dynamic> standart(OnProxyIpChanged onProxyChanged) async {
    init(onProxyChanged);

    return ProxySettingProps(
      initialProxyIpAddress: await ProxyManager.shared.getProxyIpAddress(),
      onProxyIpChanged: (proxyIP) {
        ProxyManager.shared
            .setProxyIpAddress(proxyIP)
            .then((_) => _onProxyChanged(onProxyChanged));
      },
      isEnabled: await ProxyManager.shared.isProxyEnabled(),
      onProxyModeChanged: (isProxyEnabled) {
        ProxyManager.shared
            .setProxyMode(isProxyEnabled)
            .then((_) => _onProxyChanged(onProxyChanged));
      },
    );
  }

  static Future<void> _onProxyChanged(OnProxyIpChanged onProxyChanged) async {
    final isProxyEnabled = await ProxyManager.shared.isProxyEnabled();
    final proxyIP = await ProxyManager.shared.getProxyIpAddress();

    onProxyChanged(isProxyEnabled ? proxyIP : '');
  }
}

class ProxySetting extends StatefulWidget implements ControlPanelSetting {
  const ProxySetting(this.props, {Key? key}) : super(key: key);

  final ProxySettingProps props;

  @override
  Setting get setting => Setting(
        id: runtimeType.toString(),
        title: 'Proxy',
      );

  @override
  _ProxySettingState createState() => _ProxySettingState();
}

class _ProxySettingState extends State<ProxySetting> {
  final proxyForm = GlobalKey<FormState>();
  final proxyIpFieldFocusNode = FocusNode();
  final proxyIpController = TextEditingController();

  bool isProxyEnabled = false;
  String proxyIP = '';

  @override
  void initState() {
    isProxyEnabled = widget.props.isEnabled;

    proxyIpFieldFocusNode.addListener(() {
      submitNewProxyIpAddress(proxyIpController.text);
    });

    proxyIpController.text = widget.props.initialProxyIpAddress;
    proxyIP = widget.props.initialProxyIpAddress;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SettingGroup(
      setting: widget.setting,
      child: Container(
        padding: const EdgeInsets.only(top: 6, bottom: 4),
        child: Form(
          key: proxyForm,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                children: <Widget>[
                  Expanded(child: _buildProxyInputField()),
                  _buildProxyModeButton(),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Padding _buildProxyModeButton() {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0),
      child: Container(
        width: 70,
        height: 30,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 500),
          child: RaisedButton(
            padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 10),
            color:
                isProxyEnabled ? Colors.redAccent : Colors.green.withAlpha(245),
            disabledColor: Colors.grey.shade700,
            child: FittedBox(
              child: Text(
                isProxyEnabled ? 'Disable' : 'Enable',
                style: const TextStyle(
                  fontSize: 13,
                  color: Colors.white,
                  letterSpacing: 0.2,
                ),
              ),
            ),
            onPressed: proxyIP.isEmpty ? null : changeProxyMode,
          ),
        ),
      ),
    );
  }

  TextFormField _buildProxyInputField() {
    return TextFormField(
      focusNode: proxyIpFieldFocusNode,
      controller: proxyIpController,
      decoration: const InputDecoration(
        labelText: 'Proxy IP address:',
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
      inputFormatters: [FilteringTextInputFormatter.allow(RegExp('[0-9\.]'))],
      validator: validateIpAdress,
      onEditingComplete: () => proxyForm.currentState?.validate(),
      onFieldSubmitted: (value) {
        submitNewProxyIpAddress(value);
        FocusScope.of(context).requestFocus(FocusNode());
      },
    );
  }

  void changeProxyMode() {
    final mode = !isProxyEnabled;

    setState(() {
      isProxyEnabled = mode;
    });

    widget.props.onProxyModeChanged(mode);
  }

  void submitNewProxyIpAddress(String ipAddress) {
    if (proxyForm.currentState?.validate() ?? false) {
      final proxyIP = ipAddress.isEmpty ? null : ipAddress;

      setState(() {
        this.proxyIP = proxyIP ?? '';
      });

      widget.props.onProxyIpChanged(this.proxyIP);
    }
  }

  String? validateIpAdress(String? value) {
    if (value == null || value.isEmpty) {
      return null;
    }

    final components = value.split('.');
    const error = 'Incorrect format of IP address';

    if (components.length != 4) {
      return error;
    }

    final isNumberComponentsCorrect = components.fold(true, (prev, curr) {
      final int number = int.parse(curr);
      return number >= 0 && number < 256;
    });

    if (!isNumberComponentsCorrect) {
      return error;
    }

    return null;
  }
}
