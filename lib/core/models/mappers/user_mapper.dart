import 'package:chat/core/models/entities/chat_user.dart';
import 'package:chat/core/models/mappers/mapper.dart';

class ChatUserMapper implements IMapper<ChatUser> {
  @override
  ChatUser fromPersistence(Map<String, dynamic> data) {
    return ChatUser(
      id: data['id'],
      name: data['name'],
      email: data['email'],
      imageUrl: data['imageUrl'],
    );
  }

  @override
  Map<String, String> toPersistence(ChatUser entity) {
    return {
      'name': entity.name,
      'email': entity.email,
      'imageUrl': entity.imageUrl
    };
  }

  ChatUserMapper();
}
