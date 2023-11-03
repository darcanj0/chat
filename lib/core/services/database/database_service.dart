import 'package:chat/core/models/entities/chat_message.dart';
import 'package:chat/core/models/entities/chat_user.dart';
import 'package:chat/core/services/database/infra/database_service_firebase.dart';

abstract class IDbService {
  Future<void> saveUser(ChatUser user);
  Future<ChatMessage> saveMessage(ChatMessage message);
  factory IDbService() => DbServiceFirebase.instance;
}
