import 'dart:async';

import 'package:chat/core/models/chat_message.dart';
import 'package:chat/core/models/chat_user.dart';
import 'package:chat/core/services/chat/chat_service.dart';
import 'package:chat/core/services/database/database_service.dart';

class ChatServiceFirebase implements IChatService {
  static final _dbProvider = IDbService();

  static const _messagesStream = Stream<List<ChatMessage>>.empty();

  @override
  Stream<List<ChatMessage>> messagesStream() => _messagesStream;

  @override
  Future<void> save(String text, ChatUser sender) async {
    final message = ChatMessage(
      id: '',
      text: text,
      sentAt: DateTime.now(),
      userId: sender.id,
      userImageUrl: sender.imageUrl,
      userName: sender.name,
    );

    await _dbProvider.saveMessage(message);
  }

  static ChatServiceFirebase get instance => ChatServiceFirebase._();

  ChatServiceFirebase._();
}
