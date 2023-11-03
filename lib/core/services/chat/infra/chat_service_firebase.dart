import 'dart:async';

import 'package:chat/core/models/entities/chat_message.dart';
import 'package:chat/core/models/entities/chat_user.dart';
import 'package:chat/core/services/chat/chat_service.dart';
import 'package:chat/core/services/database/database_service.dart';
import 'package:chat/core/services/database/mappers/firestore/message_firestore_mapper.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ChatServiceFirebase implements IChatService {
  static final _dbProvider = IDbService();
  static final _mapper = ChatMessageFirestoreMapper();
  static final _firestoreStream = FirebaseFirestore.instance
      .collection('messages')
      .withConverter(
        fromFirestore: _mapper.fromFirestore,
        toFirestore: _mapper.toFirestore,
      )
      .snapshots();

  static final _messagesStream = Stream<List<ChatMessage>>.multi((p0) {
    _firestoreStream.listen((snapshot) {
      final List<ChatMessage> messages =
          snapshot.docs.map<ChatMessage>((doc) => doc.data()).toList();
      p0.add(messages);
    });
  });

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
