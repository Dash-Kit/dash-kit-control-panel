import 'package:alice/alice.dart';
import 'package:dio/dio.dart';
import 'package:example/example_app.dart';
import './example_settings_provider.dart';
import 'package:flutter_platform_control_panel/control_panel.dart';
import 'package:flutter/material.dart';

final alice = Alice();
final navigatorKey = alice.getNavigatorKey();
final dio = Dio();

Future main() async {
  dio.interceptors.add(alice.getDioInterceptor());
  dio.options = BaseOptions(
    connectTimeout: 15 * 1000,
    receiveTimeout: 15 * 1000,
  );

  runApp(ExampleApp(
    navigatorKey: navigatorKey,
    sendTestRequest: _sendTestRequest,
  ));

  final settingsProvider = ExampleSettingsProvider(
    alice: alice,
    dios: [dio],
  );

  ControlPanel.initialize(
    navigatorKey: navigatorKey,
    settingsProvider: settingsProvider,
  );

  ControlPanel.open();

  _sendTestRequest();
}

void _sendTestRequest() {
  dio
      .get('https://www.google.com')
      .then((response) => print(response))
      .catchError((error) => print(error));
}
