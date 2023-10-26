import 'package:chat/util/theme_consumer.dart';
import 'package:flutter/material.dart';

class NewMessage extends StatelessWidget with ThemeConsumer {
  const NewMessage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      width: double.infinity,
      decoration: BoxDecoration(
        color: getColorScheme(context).tertiaryContainer,
        borderRadius: BorderRadius.circular(20),
      ),
      alignment: Alignment.center,
      child: TextFormField(
        decoration: InputDecoration(
          labelText: 'Type here...',
        ),
      ),
    );
  }
}
