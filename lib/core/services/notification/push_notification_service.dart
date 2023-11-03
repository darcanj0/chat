import 'package:chat/core/models/chat_notification.dart';
import 'package:flutter/material.dart';

abstract class IChatNotificationService {
  List<ChatNotification> get items;
  int get itemsAmmount;
  void add(ChatNotification notification);
  void remove(int index);
  void removeAll();

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
}
