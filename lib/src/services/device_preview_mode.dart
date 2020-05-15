import 'package:rxdart/rxdart.dart';

// ignore: avoid_classes_with_only_static_members
class DevicePreviewMode {
  static final _subject = ReplaySubject<bool>();
  static final Stream<bool> onModeChanged = _subject.startWith(_isEnabled);
  static var _isEnabled = false;

  static bool get isEnabled => _isEnabled;

  static set isEnabled(bool isEnabled) {
    _subject.add(isEnabled);
    _isEnabled = isEnabled;
  }
}
