import 'package:rxdart/rxdart.dart';

// ignore: avoid_classes_with_only_static_members
class DevicePreviewMode {
  static final _subject = ReplaySubject<bool>();
  static final Stream<bool> onModeChanged = _subject.startWith(_isEnabled);
  static var _isEnabled = false;

  /// Returns the current [DevicePreviewMode] enabled value
  static bool get isEnabled => _isEnabled;

  /// Set the current [DevicePreviewMode] enabled value
  static set isEnabled(bool isEnabled) {
    _subject.add(isEnabled);
    _isEnabled = isEnabled;
  }
}
