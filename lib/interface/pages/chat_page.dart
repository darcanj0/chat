import 'package:chat/core/services/auth/auth_service.dart';
import 'package:flutter/material.dart';

class ChatPage extends StatelessWidget {
  const ChatPage({required this.authService, super.key});

  final IAuthService authService;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Chat'),
            ElevatedButton(
                onPressed: authService.logout, child: const Text('Logout'))
          ],
        ),
      ),
    );
  }
}
