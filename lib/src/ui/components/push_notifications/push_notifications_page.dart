import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_platform_control_panel/src/services/push_notifications_observer.dart';
import 'package:flutter_platform_control_panel/src/ui/components/control_panel_title.dart';
import 'package:flutter_platform_control_panel/src/ui/resources/R.dart';

class PushNotificationsPage extends StatefulWidget {
  @override
  _PushNotificationsPageState createState() => _PushNotificationsPageState();
}

class _PushNotificationsPageState extends State<PushNotificationsPage> {
  StreamSubscription _notificationsStreamSubscription;
  StreamSubscription _createNotificationSubscription;
  List<PushNotification> _notifications = [];

  @override
  void initState() {
    _notificationsStreamSubscription =
        PushNotificationsObserver.notificationsStream.listen((notifications) {
      if (mounted) {
        setState(() => _notifications = notifications);
      }
    });

    _createNotificationSubscription =
        Stream.periodic(Duration(milliseconds: 700)).take(10).listen((arg) {
      PushNotificationsObserver.onMessage({
        'title': 'New Push Notification',
        'description': 'An empty description',
      });
    });

    super.initState();
  }

  @override
  void dispose() {
    _notificationsStreamSubscription?.cancel();
    _createNotificationSubscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      primary: true,
      appBar: AppBar(
        title: ControlPanelTitle(title: 'Push Notifications'),
        backgroundColor: R.color.appBarBackground,
      ),
      backgroundColor: R.color.panelBackground,
      body: SafeArea(
        child: GestureDetector(
          behavior: HitTestBehavior.translucent,
          onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
          child: Container(
            width: double.infinity,
            height: double.infinity,
            child: _buildNotifications(),
          ),
        ),
      ),
    );
  }

  Widget _buildNotifications() {
    if (_notifications.isEmpty) {
      return Center(
        child: Text(
          'No notifications',
          style: TextStyle(
            color: Colors.white.withAlpha(200),
            fontSize: 18,
            letterSpacing: 0.8,
          ),
        ),
      );
    }

    return ListView(
      children: _notifications.map(_buildPushNotificationItem).toList(),
    );
  }

  Widget _buildPushNotificationItem(PushNotification notification) {
    return Container(
      child: Column(
        children: <Widget>[
          _buildNotificationCard(notification),
          Container(
            height: 0.5,
            width: double.infinity,
            color: Colors.white38,
            margin: EdgeInsets.only(top: 16),
          )
        ],
      ),
    );
  }

  Container _buildNotificationCard(PushNotification notification) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        children: <Widget>[
          _buildTitle(notification),
          Container(width: 16),
          _buildTimeContainer(notification),
        ],
      ),
    );
  }

  Widget _buildTimeContainer(PushNotification notification) {
    final date = notification.date;

    if (date == null) {
      return Container();
    }

    return Row(
      children: <Widget>[
        Icon(
          Icons.access_time,
          size: 13,
          color: Colors.green,
        ),
        SizedBox(width: 4),
        Text(
          '${date.hour}:${date.minute}:${date.second}',
          style: TextStyle(
            color: Colors.green,
            fontSize: 13,
            fontWeight: FontWeight.w400,
          ),
        ),
      ],
    );
  }

  Expanded _buildTitle(PushNotification notification) {
    return Expanded(
      child: Text(
        notification.notification['title'],
        style: TextStyle(
          color: Colors.white,
          fontSize: 16,
        ),
      ),
    );
  }
}
