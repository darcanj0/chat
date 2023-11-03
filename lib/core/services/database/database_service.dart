import 'package:chat/core/models/chat_user.dart';
import 'package:chat/core/services/database/infra/database_service_firebase.dart';

abstract class IDbService {
  Future<void> saveUser(ChatUser user);
  factory IDbService() => DbServiceFirebase.instance;
}
