import 'package:alice_lightweight/alice.dart';
import 'package:dash_kit_control_panel/dash_kit_control_panel.dart';
import 'package:dio/dio.dart';
import 'package:example/example_app.dart';
import 'package:example/example_settings_provider.dart';
import 'package:flutter/material.dart';

final alice = Alice();
final navigatorKey = alice.getNavigatorKey();
final dio = Dio();
final logger = Logger.init(bufferSize: 25);

void main() {
  dio.interceptors.add(alice.getDioInterceptor());
  dio.options = BaseOptions(
    connectTimeout: const Duration(seconds: 15),
    receiveTimeout: const Duration(seconds: 15),
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

  _sendTestRequest();
}

void _sendTestRequest() {
  dio
      .get('https://www.google.org')
      .then(logger.i)
      .catchError((e, st) => logger.e('Error loading request', e, st));
}
