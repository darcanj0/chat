import 'package:chat/core/models/chat_message.dart';
import 'package:chat/util/theme_consumer.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class MessageBubble extends StatelessWidget with ThemeConsumer {
  const MessageBubble({
    required this.message,
    required this.isFromCurrentUser,
    super.key,
  });

  final ChatMessage message;
  final bool isFromCurrentUser;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment:
          isFromCurrentUser ? MainAxisAlignment.end : MainAxisAlignment.start,
      children: [
        if (!isFromCurrentUser)
          CircleAvatar(
            radius: 10,
            backgroundImage: AssetImage(message.userImageUrl),
          ),
        Container(
          padding: const EdgeInsets.all(10),
          width: 180,
          decoration: BoxDecoration(
            color: isFromCurrentUser
                ? getColorScheme(context).primaryContainer
                : getColorScheme(context).tertiaryContainer,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                message.userName,
                style: getTextTheme(context).bodyLarge,
              ),
              Text(
                message.text,
                style: getTextTheme(context).bodyMedium,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    DateFormat(DateFormat.HOUR24_MINUTE).format(message.sentAt),
                    style: getTextTheme(context).bodySmall,
                  )
                ],
              )
            ],
          ),
        ),
      ],
    );
  }
}
