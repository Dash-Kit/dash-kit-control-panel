import 'package:dash_kit_control_panel/src/panel/control_panel_setting.dart';
import 'package:dash_kit_control_panel/src/services/proxy_manager.dart';
import 'package:dash_kit_control_panel/src/ui/components/setting_group.dart';
import 'package:dash_kit_control_panel/src/ui/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// ignore_for_file: avoid-returning-widgets
class ProxySetting extends StatefulWidget implements ControlPanelSetting {
  const ProxySetting(this.props, {super.key});

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

    final initialProxyIpAddress = widget.props.initialProxyIpAddress;
    proxyIpController.text = initialProxyIpAddress;
    proxyIP = initialProxyIpAddress;

    super.initState();
  }

  @override
  void dispose() {
    proxyIpFieldFocusNode.dispose();
    super.dispose();
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
      final number = int.parse(curr);

      return number >= 0 && number < 256;
    });

    if (!isNumberComponentsCorrect) {
      return error;
    }

    return null;
  }

  Padding _buildProxyModeButton() {
    return Padding(
      padding: const EdgeInsets.only(left: 8),
      child: SizedBox(
        width: 70,
        height: 30,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 500),
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 10),
              backgroundColor: isProxyEnabled
                  ? Colors.redAccent
                  : Colors.green.withAlpha(245),
            ),
            onPressed: proxyIP.isEmpty ? null : changeProxyMode,
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
          ),
        ),
      ),
    );
  }

  TextFormField _buildProxyInputField() {
    return TextFormField(
      focusNode: proxyIpFieldFocusNode,
      controller: proxyIpController,
      decoration: InputDecoration(
        labelText: 'Proxy IP address:',
        labelStyle: TextStyle(
          color: AppColors.of(context).text,
          fontSize: 14,
        ),
        contentPadding: const EdgeInsets.symmetric(vertical: 4),
        focusedBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.green),
        ),
      ),
      style: TextStyle(
        color: AppColors.of(context).text,
        fontSize: 15,
      ),
      keyboardType: TextInputType.text,
      inputFormatters: [FilteringTextInputFormatter.allow(RegExp('[0-9.]'))],
      validator: validateIpAdress,
      onEditingComplete: () => proxyForm.currentState?.validate(),
      onFieldSubmitted: (value) {
        submitNewProxyIpAddress(value);
        FocusScope.of(context).requestFocus(FocusNode());
      },
    );
  }
}

class ProxySettingProps {
  ProxySettingProps({
    required this.isEnabled,
    required this.onProxyModeChanged,
    required this.onProxyIpChanged,
    required this.initialProxyIpAddress,
  });

  final ValueChanged<String> onProxyIpChanged;
  final String initialProxyIpAddress;
  final bool isEnabled;
  final ValueChanged<bool> onProxyModeChanged;

  static Future<dynamic> init(ValueChanged<String> onProxyChanged) async {
    await _onProxyChanged(onProxyChanged);
  }

  static Future<dynamic> standart(ValueChanged<String> onProxyChanged) async {
    await init(onProxyChanged);

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

  static Future<void> _onProxyChanged(
    ValueChanged<String> onProxyChanged,
  ) async {
    final isProxyEnabled = await ProxyManager.shared.isProxyEnabled();
    final proxyIP = await ProxyManager.shared.getProxyIpAddress();

    onProxyChanged(isProxyEnabled ? proxyIP : '');
  }
}
