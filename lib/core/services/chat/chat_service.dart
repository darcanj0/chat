import 'package:chat/core/models/chat_message.dart';
import 'package:chat/core/models/chat_user.dart';
import 'package:chat/core/services/chat/infra/chat_service_mock.dart';

abstract class IChatService {
  Future<ChatMessage> save(String text, ChatUser sender);
  Stream<List<ChatMessage>> messagesStream();

  factory IChatService() => ChatServiceMock.instance;
}
