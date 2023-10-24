import 'dart:io';

import 'package:chat/util/theme_consumer.dart';
import 'package:flutter/material.dart';

class UserImagePicker extends StatefulWidget {
  const UserImagePicker({required this.onSelectImage, super.key});

  final void Function(File image) onSelectImage;

  @override
  State<UserImagePicker> createState() => _UserImagePickerState();
}

class _UserImagePickerState extends State<UserImagePicker> with ThemeConsumer {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Container(
        height: 300,
        width: double.infinity,
        decoration: BoxDecoration(
            color: getColorScheme(context).background,
            borderRadius: BorderRadius.circular(10),
            boxShadow: const [
              BoxShadow(
                offset: Offset(0, 25),
                blurRadius: 20,
                color: Color.fromARGB(69, 104, 101, 101),
              )
            ]),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FittedBox(
              child: Text(
                'Take a picture for your profile',
                style: getTextTheme(context).displaySmall,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            const CircleAvatar(
              radius: 50,
            ),
            const SizedBox(
              height: 20,
            ),
            TextButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.photo),
              label: const Text('Select From Gallery'),
            ),
            TextButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.camera_alt),
              label: const Text('Take a picture'),
            ),
          ],
        ),
      ),
    );
  }
}
