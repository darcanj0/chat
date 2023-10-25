import 'package:chat/core/models/chat_user.dart';
import 'package:chat/core/services/auth/auth_service.dart';
import 'package:chat/pages/auth_page.dart';
import 'package:chat/pages/chat_page.dart';
import 'package:chat/pages/loading_page.dart';
import 'package:flutter/material.dart';

class AppProxyPage extends StatelessWidget {
  const AppProxyPage({required this.authService, super.key});

  final IAuthService authService;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<ChatUser?>(
        stream: authService.userChanges,
        builder: (ctx, userSnapshot) {
          if (userSnapshot.connectionState == ConnectionState.waiting) {
            return const LoadingPage();
          } else {
            return userSnapshot.hasData
                ? ChatPage(
                    authService: authService,
                  )
                : AuthPage(
                    authService: authService,
                  );
          }
        },
      ),
    );
  }
}
