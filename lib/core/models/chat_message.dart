class ChatMessage {
  final String id;
  final String text;
  final DateTime sentAt;

  final String userId;
  final String userName;
  final String userImageUrl;

  ChatMessage({
    required this.id,
    required this.text,
    required this.sentAt,
    required this.userId,
    required this.userImageUrl,
    required this.userName,
  });
}
