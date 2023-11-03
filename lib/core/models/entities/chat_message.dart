class ChatMessage {
  final String id;
  final String text;
  final DateTime sentAt;

  final String userId;
  final String userName;
  final String userImageUrl;

  const ChatMessage({
    required this.id,
    required this.text,
    required this.sentAt,
    required this.userId,
    required this.userImageUrl,
    required this.userName,
  });

  Map<String, String> toPersistence() {
    return {
      'id': id,
      'text': text,
      'sentAt': sentAt.toIso8601String(),
      'userId': userId,
      'userName': userName,
      'userImageUrl': userImageUrl,
    };
  }

  static ChatMessage fromPersistence(
      String id, Map<String, dynamic> messageData) {
    return ChatMessage(
      id: id,
      text: messageData['text'],
      sentAt: DateTime.parse(messageData['sentAt']),
      userId: messageData['senderId'],
      userImageUrl: messageData['userImageUrl'],
      userName: messageData['userName'],
    );
  }
}
