import 'package:flutter/material.dart';
import 'package:flutter_platform_control_panel/control_panel.dart';

class ExampleApp extends StatelessWidget {
  final GlobalKey<NavigatorState> navigatorKey;
  final VoidCallback sendTestRequest;

  const ExampleApp({
    Key key,
    this.navigatorKey,
    this.sendTestRequest,
  }) : super(key: key);

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
              ControlPanelGate(child: Text('Debug mode')),
              SizedBox(height: 24),
              RaisedButton(
                child: Text('Send Request'),
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
