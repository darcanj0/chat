import 'package:chat/core/services/notification/push_notification_service.dart';
import 'package:chat/util/theme_consumer.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class NotificationsPage extends StatelessWidget with ThemeConsumer {
  const NotificationsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notifications'),
        backgroundColor: getColorScheme(context).primaryContainer,
        elevation: 8,
      ),
      body: Consumer<ChatNotificationService>(
          child: const Text('Dismiss all'),
          builder: (ctx, notifications, child) {
            bool isEmpty = notifications.itemsAmmount == 0;
            return Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8),
                    child: TextButton(
                      onPressed:
                          isEmpty ? null : () => notifications.removeAll(),
                      child: child!,
                    ),
                  ),
                  Expanded(
                    child: isEmpty
                        ? const Center(
                            child: Text('No notifications around here ...'),
                          )
                        : ListView.builder(
                            itemCount: notifications.itemsAmmount,
                            itemBuilder: (ctx, index) {
                              final notification =
                                  notifications.items.elementAt(index);
                              return ListTile(
                                title: Text(notification.title),
                                subtitle: Text(notification.body),
                                onTap: () => notifications.remove(index),
                                key: Key(notification.id),
                              );
                            },
                          ),
                  )
                ]);
          }),
    );
  }
}
