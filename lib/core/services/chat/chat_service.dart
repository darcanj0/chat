import 'package:chat/core/models/entities/chat_message.dart';
import 'package:chat/core/models/entities/chat_user.dart';
import 'package:chat/core/services/chat/infra/chat_service_firebase.dart';

abstract class IChatService {
  Future<void> save(String text, ChatUser sender);
  Stream<List<ChatMessage>> messagesStream();

  // factory IChatService() => ChatServiceMock.instance;
  factory IChatService() => ChatServiceFirebase.instance;
}
