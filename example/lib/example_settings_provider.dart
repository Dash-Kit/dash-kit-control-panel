import 'dart:io';

import 'package:alice_lightweight/alice.dart';
import 'package:dash_kit_control_panel/dash_kit_control_panel.dart';
import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';

class ExampleSettingsProvider extends ControlPanelSettingsProvider {
  ExampleSettingsProvider({
    required this.alice,
    required this.dios,
  }) {
    _configureProxy(dios);
    _initLogger();

    ProxySettingProps.init((proxyIpAddress) {
      _proxyIp = proxyIpAddress;
    });
  }

  final Alice alice;
  final List<Dio> dios;

  String _proxyIp = '';

  @override
  Future<List<ControlPanelSetting>> buildSettings() async {
    final demoProps = DemoSettingProps(
      onDemoModeChanged: (value) {
        print('Demo mode is ${value ? 'enabled' : 'disabled'}');
      },
    );

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
      const DevicePreviewSetting(),
      ProxySetting(proxyProps),
      PushNotificationsSetting(pushProps),
      NetworkSetting(networkProps),
      const LicenseSetting(),
      LogConsoleButton(),
    ];
  }

  void _configureProxy(List<Dio> dios) {
    for (final dio in dios) {
      final adapter = dio.httpClientAdapter;

      if (adapter is DefaultHttpClientAdapter) {
        adapter.onHttpClientCreate = (HttpClient client) {
          client.findProxy = (uri) {
            return _proxyIp.isNotEmpty == true
                ? 'PROXY $_proxyIp:8888'
                : 'DIRECT';
          };

          client.badCertificateCallback =
              (cert, host, port) => _proxyIp.isNotEmpty == true;

          return null;
        };
      }
    }
  }

  void _initLogger() {
    final logger = Logger.init(bufferSize: 25);

    logger.v('Verbose log');
    logger.d('Debug log');
    logger.i('Info log');
    logger.w('Warning log');
    logger.e('Error log');
  }
}
