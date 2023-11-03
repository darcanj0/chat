import 'package:chat/core/models/entities/chat_message.dart';
import 'package:chat/core/models/mappers/mapper.dart';

class ChatMessageMapper implements IMapper<ChatMessage> {
  @override
  ChatMessage fromPersistence(Map<String, dynamic> data) {
    return ChatMessage(
      id: data['id'],
      text: data['text'],
      sentAt: DateTime.parse(data['sentAt']),
      userId: data['userId'],
      userImageUrl: data['userImageUrl'],
      userName: data['userName'],
    );
  }

  @override
  Map<String, String> toPersistence(ChatMessage entity) {
    return {
      'text': entity.text,
      'sentAt': entity.sentAt.toIso8601String(),
      'userId': entity.userId,
      'userName': entity.userName,
      'userImageUrl': entity.userImageUrl,
    };
  }

  ChatMessageMapper();
}
