import 'dart:async';

// ignore: avoid_classes_with_only_static_members
class DemoMode {
  static var _isDemoModeEnabled = false;
  static final _onDemoModeChanged = StreamController<bool>.broadcast();

  /// Returns [DemoMode] enabled value
  static bool get isEnabled => _isDemoModeEnabled;

  static set isEnabled(bool isEnabled) {
    if (_isDemoModeEnabled != isEnabled) {
      _onDemoModeChanged.add(isEnabled);
      _isDemoModeEnabled = isEnabled;
    }
  }

  /// Returns a `T` [DemoMode] value if [DemoMode] is enabled
  ///
  /// Otherwise returns `null`
  static T? value<T>(T demoValue) {
    if (isEnabled) {
      return demoValue;
    }

    return null;
  }

  /// Call an action if [DemoMode] is enabled
  ///
  /// Otherwise do nothing
  static void action(void Function() action) {
    if (isEnabled) {
      action();
    }
  }

  /// Returns a [StreamSubscription] for [DemoMode] enabled value
  ///
  /// Fires `onEnabled` if the [DemoMode] is enabled
  /// Fires `onDisabled` if the [DemoMode] is disabled
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
