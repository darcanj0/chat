import 'package:chat/core/services/auth/auth_service.dart';
import 'package:chat/core/services/chat/chat_service.dart';
import 'package:chat/core/services/chat/infra/chat_service_mock.dart';
import 'package:chat/interface/components/chat/messages.dart';
import 'package:chat/interface/components/nav/app_drawer.dart';
import 'package:chat/interface/components/chat/new_message.dart';
import 'package:chat/util/theme_consumer.dart';
import 'package:flutter/material.dart';

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
