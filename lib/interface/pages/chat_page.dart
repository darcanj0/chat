import 'package:chat/core/services/auth/auth_service.dart';
import 'package:chat/core/services/chat/chat_service.dart';
import 'package:chat/core/services/chat/infra/chat_service_mock.dart';
import 'package:chat/core/services/notification/push_notification_service.dart';
import 'package:chat/interface/components/chat/messages.dart';
import 'package:chat/interface/components/nav/app_drawer.dart';
import 'package:chat/interface/components/chat/new_message.dart';
import 'package:chat/interface/pages/notifications_page.dart';
import 'package:chat/util/theme_consumer.dart';
import 'package:flutter/material.dart';
import 'package:badges/badges.dart' as badges;
import 'package:provider/provider.dart';

class ChatPage extends StatelessWidget with ThemeConsumer {
  ChatPage({
    required this.authService,
    super.key,
  });

  final IAuthService authService;
  final IChatService chatService = ChatServiceMock.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Talkative Chat'),
        backgroundColor: getColorScheme(context).primaryContainer,
        elevation: 8,
        actions: [
          Consumer<ChatNotificationService>(
            builder: (_, notifications, child) {
              return badges.Badge(
                badgeAnimation: const badges.BadgeAnimation.slide(),
                position: badges.BadgePosition.custom(bottom: 20, start: 25),
                ignorePointer: true,
                showBadge: notifications.itemsAmmount > 0,
                badgeContent: Text(
                  notifications.itemsAmmount.toString(),
                  style: getTextTheme(context).bodySmall,
                ),
                child: child,
              );
            },
            child: IconButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => NotificationsPage(),
                ));
              },
              icon: const Icon(Icons.notifications),
            ),
          )
        ],
      ),
      body: SafeArea(
        child: SizedBox.expand(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                  child: Messages(
                chatService: chatService,
                authService: authService,
              )),
              NewMessage(
                chatService: chatService,
                authService: authService,
              ),
            ],
          ),
        ),
      ),
      drawer: AppDrawer(authService: authService),
    );
  }
}
