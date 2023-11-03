import 'package:chat/core/models/entities/chat_message.dart';
import 'package:chat/core/models/mappers/mapper.dart';
import 'package:chat/core/models/mappers/message_mapper.dart';
import 'package:chat/core/services/database/mappers/firestore/firestore_mapper.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ChatMessageFirestoreMapper implements IFireStoreMapper<ChatMessage> {
  @override
  ChatMessage fromFirestore(
      DocumentSnapshot<Map<String, dynamic>> doc, SnapshotOptions? options) {
    return mapperDelegate!.fromPersistence({
      'id': doc.id,
      'text': doc['text'],
      'sentAt': DateTime.parse(doc['sentAt']),
      'userId': doc['userId'],
      'userImageUrl': doc['userImageUrl'],
      'userName': doc['userName'],
    });
  }

  @override
  Map<String, Object?> toFirestore(ChatMessage entity, SetOptions? options) {
    return mapperDelegate!.toPersistence(entity);
  }

  @override
  IMapper<ChatMessage>? mapperDelegate = ChatMessageMapper();

  ChatMessageFirestoreMapper();
}
