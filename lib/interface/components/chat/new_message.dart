import 'package:chat/core/models/chat_user.dart';
import 'package:chat/core/services/auth/auth_service.dart';
import 'package:chat/core/services/chat/chat_service.dart';
import 'package:chat/util/theme_consumer.dart';
import 'package:flutter/material.dart';

class NewMessage extends StatefulWidget {
  const NewMessage({
    required this.authService,
    required this.chatService,
    super.key,
  });

  final IChatService chatService;
  final IAuthService authService;

  @override
  State<NewMessage> createState() => _NewMessageState();
}

class _NewMessageState extends State<NewMessage> with ThemeConsumer {
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  String message = '';

  final TextEditingController _controller = TextEditingController();

  Future<void> sendMessage() async {
    await widget.chatService
        .save(message, widget.authService.currentUser as ChatUser);
    _controller.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 5, left: 10),
      child: SizedBox(
        width: double.infinity,
        height: 70,
        child: Row(
          children: [
            Expanded(
              child: TextField(
                expands: true,
                maxLines: null,
                controller: _controller,
                onChanged: (value) {
                  setState(() {
                    message = value;
                  });
                },
                decoration: const InputDecoration(
                  labelText: 'Type here...',
                ),
                keyboardType: TextInputType.multiline,
              ),
            ),
            IconButton(
              onPressed: () {
                final bool canSend = message.isNotEmpty &&
                    message.trim().isNotEmpty &&
                    widget.authService.currentUser != null;
                if (canSend) {
                  sendMessage();
                }
              },
              icon: Icon(Icons.send, color: getColorScheme(context).primary),
              splashColor: getPrimaryColor(context),
            )
          ],
        ),
      ),
    );
  }
}
