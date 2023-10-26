import 'package:chat/core/models/chat_message.dart';
import 'package:chat/core/services/auth/auth_service.dart';
import 'package:chat/core/services/chat/chat_service.dart';
import 'package:chat/interface/components/chat/message_bubble.dart';
import 'package:chat/util/theme_consumer.dart';
import 'package:flutter/material.dart';

class Messages extends StatelessWidget with ThemeConsumer {
  const Messages({
    required this.chatService,
    required this.authService,
    super.key,
  });

  final IChatService chatService;
  final IAuthService authService;

  @override
  Widget build(BuildContext context) {
    final currentUser = authService.currentUser;
    return StreamBuilder(
      stream: chatService.messagesStream(),
      builder: (ctx, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator.adaptive(),
          );
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            Text(
              'Say hi!',
              style: getTextTheme(context)
                  .displaySmall
                  ?.copyWith(color: Colors.black38),
            ),
            Text(
              'This is the beggining of your chat',
              style: getTextTheme(context)
                  .bodySmall
                  ?.copyWith(color: Colors.black38),
            )
          ]);
        }
        final messages = snapshot.data?.reversed.toList() as List<ChatMessage>;
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView.builder(
            reverse: true,
            itemCount: messages.length,
            itemBuilder: (context, index) {
              final message = messages[index];
              return MessageBubble(
                message: message,
                isFromCurrentUser: currentUser?.id == message.userId,
                key: Key(message.id),
              );
            },
          ),
        );
      },
    );
  }
}
