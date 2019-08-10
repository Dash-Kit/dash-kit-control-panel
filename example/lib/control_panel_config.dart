import 'dart:io';

import 'package:alice/alice.dart';
import 'package:dio/dio.dart';
import 'package:flutter_platform_control_panel/control_panel.dart';
import 'package:meta/meta.dart';

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

  final proxyProps = await ProxySettingProps.standart((proxyIP) {
    dios.forEach((dio) {
      final adapter = dio.httpClientAdapter as DefaultHttpClientAdapter;

      adapter.onHttpClientCreate = (HttpClient client) {
        client.findProxy =
            proxyIP != null ? (uri) => "PROXY $proxyIP:8888" : null;

        client.badCertificateCallback = (cert, host, port) => proxyIP != null;
      };
    });
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
