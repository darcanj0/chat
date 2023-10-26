import 'package:chat/core/models/chat_message.dart';
import 'package:chat/core/services/chat/chat_service.dart';
import 'package:flutter/material.dart';

class Messages extends StatelessWidget {
  const Messages({required this.chatService, super.key});

  final IChatService chatService;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: chatService.messagesStream(),
      builder: (ctx, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator.adaptive(),
          );
        } else if (!snapshot.hasData) {
          return const Center(
            child: Text('Say hi!'),
          );
        }
        final messages = snapshot.data as List<ChatMessage>;
        return ListView.builder(
          itemCount: messages.length,
          itemBuilder: (context, index) {
            return Text(messages[index].text);
          },
        );
      },
    );
  }
}
