import 'package:dash_kit_control_panel/dash_kit_control_panel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ExampleApp extends StatelessWidget {
  const ExampleApp({
    required this.navigatorKey,
    required this.sendTestRequest,
    super.key,
  });

  final GlobalKey<NavigatorState> navigatorKey;
  final VoidCallback sendTestRequest;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Debug',
      navigatorKey: navigatorKey,
      themeMode: ThemeMode.system,
      theme: Theme.of(context).copyWith(brightness: Brightness.dark),
      home: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
        ),
        padding: const EdgeInsets.all(16),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Flexible(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 36),
                  child: Image.asset('assets/images/png/dash_dart.png'),
                ),
              ),
              const SizedBox(height: 16),
              const ControlPanelGate(
                child: Text(
                  'Control Panel',
                  style: TextStyle(
                    fontSize: 36,
                    color: Colors.blue,
                    decoration: TextDecoration.none,
                  ),
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              const Text(
                '*Make quick multi-tap on label to open Control Panel',
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.black,
                  decoration: TextDecoration.none,
                ),
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: sendTestRequest,
                child: const Text('Send Request'),
              ),
            ],
          ),
        ),
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}
