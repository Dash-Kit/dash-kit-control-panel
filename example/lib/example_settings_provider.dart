import 'package:alice_lightweight/alice.dart';
import 'package:dash_kit_control_panel/dash_kit_control_panel.dart';
import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:example/main.dart';

class ExampleSettingsProvider extends ControlPanelSettingsProvider {
  ExampleSettingsProvider({
    required this.alice,
    required this.dios,
  }) {
    _configureProxy(dios);

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
        logger.i('Demo mode is ${value ? 'enabled' : 'disabled'}');
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
      const VersionSetting(),
      DemoSetting(demoProps),
      const DevicePreviewSetting(),
      ProxySetting(proxyProps),
      PushNotificationsSetting(pushProps),
      NetworkSetting(networkProps),
      const LicenseSetting(),
      const LogConsoleButton(),
    ];
  }

  void _configureProxy(List<Dio> dios) {
    for (final dio in dios) {
      final adapter = dio.httpClientAdapter;

      if (adapter is IOHttpClientAdapter) {
        adapter.onHttpClientCreate = (client) {
          client
            ..findProxy = (uri) {
              return _proxyIp.isNotEmpty ? 'PROXY $_proxyIp:8888' : 'DIRECT';
            }
            ..badCertificateCallback =
                (cert, host, port) => _proxyIp.isNotEmpty;

          return null;
        };
      }
    }
  }
}
