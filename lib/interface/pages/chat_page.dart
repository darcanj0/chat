import 'package:chat/core/services/auth/auth_service.dart';
import 'package:chat/core/services/chat/infra/chat_service_mock.dart';
import 'package:chat/interface/components/messages.dart';
import 'package:chat/interface/components/nav/app_drawer.dart';
import 'package:chat/interface/components/new_message.dart';
import 'package:chat/util/theme_consumer.dart';
import 'package:flutter/material.dart';

class ChatPage extends StatelessWidget with ThemeConsumer {
  const ChatPage({required this.authService, super.key});

  final IAuthService authService;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Talkative Chat'),
        backgroundColor: getPrimaryColor(context),
      ),
      body: SafeArea(
        child: SizedBox.expand(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                  child: Messages(
                chatService: ChatServiceMock.instance,
              )),
              NewMessage(),
            ],
          ),
        ),
      ),
      drawer: AppDrawer(authService: authService),
    );
  }
}
