import 'package:chat/core/models/chat_message.dart';
import 'package:chat/core/models/chat_user.dart';

abstract class IChatService {
  Future<ChatMessage> save(String text, ChatUser sender);
  Stream<List<ChatMessage>> messagesStream();
}
