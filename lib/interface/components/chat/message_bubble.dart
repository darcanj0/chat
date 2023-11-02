import 'dart:io';

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

  static const bubbleBorderRadius = Radius.circular(20);
  static const nullBorderRadius = Radius.circular(0);

  Widget getUserAvatar(String imageUrl) {
    ImageProvider provider;
    if (imageUrl.contains('http')) {
      provider = NetworkImage(imageUrl);
    } else if (imageUrl.contains('assets/')) {
      provider = AssetImage(imageUrl);
    } else {
      provider = FileImage(File(imageUrl));
    }

    return Padding(
      padding: const EdgeInsets.only(bottom: 5),
      child: CircleAvatar(
        radius: 10,
        backgroundImage: provider,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment:
          isFromCurrentUser ? MainAxisAlignment.end : MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        if (!isFromCurrentUser) getUserAvatar(message.userImageUrl),
        const SizedBox(width: 5),
        Container(
          padding: const EdgeInsets.all(10),
          margin: const EdgeInsets.symmetric(vertical: 5),
          width: 180,
          decoration: BoxDecoration(
            color: isFromCurrentUser
                ? getColorScheme(context).primaryContainer
                : getColorScheme(context).tertiaryContainer,
            borderRadius: BorderRadius.only(
              bottomRight:
                  isFromCurrentUser ? nullBorderRadius : bubbleBorderRadius,
              bottomLeft:
                  isFromCurrentUser ? bubbleBorderRadius : nullBorderRadius,
              topRight: bubbleBorderRadius,
              topLeft: bubbleBorderRadius,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                message.userName,
                style: getTextTheme(context).bodyLarge,
                textAlign: isFromCurrentUser ? TextAlign.end : TextAlign.start,
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
        const SizedBox(width: 5),
        if (isFromCurrentUser) getUserAvatar(message.userImageUrl),
      ],
    );
  }
}
