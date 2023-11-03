import 'package:chat/core/models/chat_message.dart';
import 'package:chat/core/models/chat_user.dart';
import 'package:chat/core/services/database/database_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DbServiceFirebase implements IDbService {
  static final _db = FirebaseFirestore.instance;
  static final _users = _db.collection('users').withConverter(
        fromFirestore: _userFromFirestore,
        toFirestore: _userToFirestore,
      );
  static final _messages = _db.collection('messages').withConverter(
        fromFirestore: _messageFromFirestore,
        toFirestore: _messageToFirestore,
      );

  @override
  Future<void> saveUser(ChatUser user) async {
    await _users.doc(user.id).set(user);
  }

  @override
  Future<ChatMessage> saveMessage(ChatMessage message) async {
    final docRef = await _messages.add(message);
    final snapshot = await docRef.get();
    return snapshot.data()!;
  }

  static Map<String, Object?> _userToFirestore(
      ChatUser user, SetOptions? options) {
    return {'name': user.name, 'email': user.email, 'imageUrl': user.imageUrl};
  }

  static ChatUser _userFromFirestore(
    DocumentSnapshot<Map<String, dynamic>> doc,
    SnapshotOptions? options,
  ) {
    return ChatUser(
      id: doc.id,
      name: doc['name'],
      email: doc['email'],
      imageUrl: doc['imageUrl'],
    );
  }

  static ChatMessage _messageFromFirestore(
      DocumentSnapshot<Map<String, dynamic>> doc, SnapshotOptions? options) {
    return ChatMessage(
      id: doc.id,
      text: doc['text'],
      sentAt: DateTime.parse(doc['sentAt']),
      userId: doc['userId'],
      userImageUrl: doc['userImageUrl'],
      userName: doc['userName'],
    );
  }

  static Map<String, String> _messageToFirestore(
      ChatMessage message, SetOptions? options) {
    return {
      'text': message.text,
      'sentAt': message.sentAt.toIso8601String(),
      'userId': message.userId,
      'userName': message.userName,
      'userImageUrl': message.userImageUrl,
    };
  }

  DbServiceFirebase._();

  static DbServiceFirebase get instance => DbServiceFirebase._();
}
