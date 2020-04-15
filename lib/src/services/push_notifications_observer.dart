import 'dart:async';

import 'package:flutter/foundation.dart';

class PushNotification {
  final Map<String, dynamic> notification;
  final DateTime date;

  PushNotification({
    @required this.notification,
    @required this.date,
  });
}

class PushNotificationsObserver {
  static final _notiifcationsStreamController =
      StreamController<List<PushNotification>>.broadcast();

  static var _notifications = <PushNotification>[];

  static Stream<List<PushNotification>> get notificationsStream {
    return _notiifcationsStreamController.stream;
  }

  static void onMessage(Map<String, dynamic> message) {
    _notifications.add(PushNotification(
      notification: message,
      date: DateTime.now(),
    ));

    _notiifcationsStreamController.add(_notifications);
  }

  static void dispose() {
    _notiifcationsStreamController.close();
  }
}
