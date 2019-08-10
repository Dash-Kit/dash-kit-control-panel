import 'package:alice/alice.dart';
import 'package:dio/dio.dart';
import 'package:example/example_app.dart';
import './control_panel_config.dart';
import 'package:flutter_platform_control_panel/control_panel.dart';
import 'package:flutter/material.dart';

final alice = Alice();
final navigatorKey = alice.getNavigatorKey();
final dio = Dio();

Future main() async {
  dio.interceptors.add(alice.getDioInterceptor());

  runApp(ExampleApp(
    navigatorKey: navigatorKey,
    sendTestRequest: _sendTestRequest,
  ));

  ControlPanel.initialize(
    navigatorKey: navigatorKey,
    settings: await controlPanelConfig(
      alice: alice,
      dios: [dio],
    ),
  );

  ControlPanel.open();

  _sendTestRequest();
}

void _sendTestRequest() {
  dio
      .get('https://google.com')
      .then((response) => print(response))
      .catchError((error) => print(error));
}
