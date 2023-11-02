import 'package:firebase_auth/firebase_auth.dart';

class ChatUser {
  final String id;
  final String name;
  final String email;
  final String imageUrl;

  const ChatUser({
    required this.id,
    required this.name,
    required this.email,
    required this.imageUrl,
  });

  static ChatUser? fromFirebase(User? user) {
    if (user == null) return null;
    return ChatUser(
      id: user.uid,
      name: user.displayName ?? user.email!.split('@')[0],
      email: user.email as String,
      imageUrl: user.photoURL ?? 'assets/default_avatar.png',
    );
  }

  Map<String, String> toPersistence() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'imageUrl': imageUrl,
    };
  }
}
