import 'dart:io';

import 'package:alice/alice.dart';
import 'package:dio/dio.dart';
import 'package:flutter_platform_control_panel/control_panel.dart';
import 'package:meta/meta.dart';

String _proxyIp;

Future<List<ControlPanelSetting>> controlPanelConfig({
  @required Alice alice,
  List<Dio> dios = const [],
}) async {
  final demoProps = DemoSettingProps(
    initialValue: false,
    onDemoModeChanged: (value) {
      print('Demo mode is ${value ? 'enabled' : 'disabled'}');
    },
  );

  _configureProxy(dios);
  final proxyProps = await ProxySettingProps.standart((proxyIpAddress) {
    _proxyIp = proxyIpAddress;
  });

  final networkProps = NetworkSettingProps(
    alice: alice,
  );

  final pushProps = PushNotificationsSettingProps(
    getToken: Future.value('token'),
  );

  return [
    VersionSetting(),
    DemoSetting(demoProps),
    ProxySetting(proxyProps),
    PushNotificationsSetting(pushProps),
    NetworkSetting(networkProps),
  ];
}

void _configureProxy(List<Dio> dios) {
  dios.forEach((dio) {
    final adapter = dio.httpClientAdapter as DefaultHttpClientAdapter;

    adapter.onHttpClientCreate = (HttpClient client) {
      client.findProxy = (uri) {
        return _proxyIp != null ? 'PROXY $_proxyIp:8888' : "DIRECT";
      };

      client.badCertificateCallback = (cert, host, port) => _proxyIp != null;
    };
  });
}
