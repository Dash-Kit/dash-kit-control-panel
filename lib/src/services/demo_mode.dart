import 'dart:async';

// ignore: avoid_classes_with_only_static_members
class DemoMode {
  static var _isDemoModeEnabled = false;
  static final _onDemoModeChanged = StreamController<bool>.broadcast();

  static bool get isEnabled => _isDemoModeEnabled;

  static set isEnabled(bool isEnabled) {
    if (_isDemoModeEnabled != isEnabled) {
      _onDemoModeChanged.add(isEnabled);
      _isDemoModeEnabled = isEnabled;
    }
  }

  static T? value<T>(T demoValue) {
    if (isEnabled) {
      return demoValue;
    }

    return null;
  }

  static void action(void Function() action) {
    if (isEnabled) {
      action();
    }
  }

  static StreamSubscription<bool> subscribe({
    required void Function()? onEnabled,
    required void Function()? onDisabled,
  }) {
    final notify = (isEnabled) {
      if (isEnabled) {
        onEnabled?.call();
      }

      if (!isEnabled) {
        onDisabled?.call();
      }
    };

    notify(isEnabled);

    return _onDemoModeChanged.stream.listen(notify);
  }
}
