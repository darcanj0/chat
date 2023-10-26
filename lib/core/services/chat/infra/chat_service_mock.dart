import 'dart:async';

import 'package:chat/core/models/chat_message.dart';
import 'package:chat/core/models/chat_user.dart';
import 'package:chat/core/services/chat/chat_service.dart';
import 'package:chat/core/services/id/id_provider.dart';

class ChatServiceMock implements IChatService {
  static final IIdProvider _idProvider = UUIDProvider();

  @override
  Stream<List<ChatMessage>> messagesStream() => _messagesStream;

  @override
  Future<ChatMessage> save(String text, ChatUser sender) async {
    final newMessage = ChatMessage(
      id: _idProvider.generate(),
      text: text,
      sentAt: DateTime.now(),
      userId: sender.id,
      userImageUrl: sender.imageUrl,
      userName: sender.name,
    );
    _updateStream(newMessage);
    return newMessage;
  }

  void _updateStream(ChatMessage message) {
    _messages.add(message);
    _streamController?.add(_messages);
  }

  static final List<ChatMessage> _messages = [
    ChatMessage(
      id: 'id1',
      text: 'Hello, there',
      sentAt: DateTime.now(),
      userId: 'id',
      userImageUrl: 'assets/default_avatar.png',
      userName: 'Daniel',
    ),
    ChatMessage(
      id: 'id2',
      text: 'Hi everyone',
      sentAt: DateTime.now(),
      userId: 'userId1',
      userImageUrl: 'assets/default_avatar.png',
      userName: 'Joana',
    ),
    ChatMessage(
      id: 'id3',
      text: 'Can anyone pick me up at 8pm?',
      sentAt: DateTime.now(),
      userId: 'userId2',
      userImageUrl: 'assets/default_avatar.png',
      userName: 'Mariann',
    ),
  ];

  final _messagesStream = Stream<List<ChatMessage>>.multi((p0) {
    _streamController = p0;
    _streamController?.add(_messages);
  });

  static MultiStreamController<List<ChatMessage>>? _streamController;

  static ChatServiceMock get instance => ChatServiceMock._();

  ChatServiceMock._();
}
