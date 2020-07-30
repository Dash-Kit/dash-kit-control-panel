import 'package:flutter/material.dart';
import 'package:dash_kit_control_panel/dash_kit_control_panel.dart';

class ExampleApp extends StatelessWidget {
  const ExampleApp({
    Key key,
    this.navigatorKey,
    this.sendTestRequest,
  }) : super(key: key);

  final GlobalKey<NavigatorState> navigatorKey;
  final VoidCallback sendTestRequest;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Debug',
      navigatorKey: navigatorKey,
      home: Container(
        decoration: BoxDecoration(
          color: Colors.white,
        ),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              const ControlPanelGate(child: Text('Debug mode')),
              const SizedBox(height: 24),
              RaisedButton(
                child: const Text('Send Request'),
                onPressed: sendTestRequest,
              )
            ],
          ),
        ),
      ),
      theme: ThemeData(primaryColor: Colors.green),
    );
  }
}
