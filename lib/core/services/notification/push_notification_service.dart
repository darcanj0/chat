import 'dart:async';

import 'package:chat/core/models/entities/chat_notification.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

abstract class IChatNotificationService {
  List<ChatNotification> get items;
  int get itemsAmmount;
  void add(ChatNotification notification);
  void remove(int index);
  void removeAll();

  Future<void> initService();

  factory IChatNotificationService() => ChatNotificationService();
}

class ChatNotificationService
    with ChangeNotifier
    implements IChatNotificationService {
  final List<ChatNotification> _notifications = [];

  @override
  void add(ChatNotification notification) {
    _notifications.add(notification);
    notifyListeners();
  }

  @override
  void remove(int index) {
    _notifications.removeAt(index);
    notifyListeners();
  }

  @override
  List<ChatNotification> get items => [..._notifications];

  @override
  int get itemsAmmount => _notifications.length;

  @override
  void removeAll() {
    _notifications.clear();
    notifyListeners();
  }

  // push notifications
  static final _firebaseMessaging = FirebaseMessaging.instance;

  @override
  Future<void> initService() async {
    await _openedFromMessageWhenTerminated();
    await _configureForeground();
    await _configureBackground();
  }

  Future<void> _configureForeground() async {
    if (await _hasNotificationPermission()) {
      FirebaseMessaging.onMessage.listen(_handlePushNotification);
    }
  }

  Future<void> _configureBackground() async {
    if (await _hasNotificationPermission()) {
      FirebaseMessaging.onMessageOpenedApp.listen(_handlePushNotification);
    }
  }

  Future<void> _openedFromMessageWhenTerminated() async {
    if (await _hasNotificationPermission()) {
      final openedMessage = await _firebaseMessaging.getInitialMessage();
      _handlePushNotification(openedMessage);
    }
  }

  Future<bool> _hasNotificationPermission() async {
    final settings = await _firebaseMessaging.requestPermission();
    return settings.authorizationStatus == AuthorizationStatus.authorized;
  }

  @pragma('vm:entry-point')
  void _handlePushNotification(RemoteMessage? event) {
    if (event == null || event.notification == null) return;
    add(
      ChatNotification(
        id: event.messageId ?? '',
        title: event.notification!.title ?? '',
        body: event.notification!.body ?? '',
      ),
    );
  }
}
