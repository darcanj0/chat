import 'package:chat/core/models/entities/chat_user.dart';
import 'package:chat/core/services/database/mappers/firestore/firestore_mapper.dart';
import 'package:chat/core/models/mappers/mapper.dart';
import 'package:chat/core/models/mappers/user_mapper.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ChatUserFirestoreMapper implements IFireStoreMapper<ChatUser> {
  @override
  ChatUser fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> doc,
    SnapshotOptions? options,
  ) {
    return mapperDelegate!.fromPersistence({
      'id': doc.id,
      'name': doc['name'],
      'email': doc['email'],
      'imageUrl': doc['imageUrl'],
    });
  }

  @override
  Map<String, Object?> toFirestore(ChatUser user, SetOptions? options) {
    return mapperDelegate!.toPersistence(user);
  }

  @override
  IMapper<ChatUser>? mapperDelegate = ChatUserMapper();

  ChatUserFirestoreMapper();
}
