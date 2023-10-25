import 'dart:io';

import 'package:chat/util/theme_consumer.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as path;

class UserImagePicker extends StatefulWidget {
  const UserImagePicker(
      {required this.onSelectImage, required this.onFinish, super.key});

  final void Function(File image) onSelectImage;
  final void Function() onFinish;

  @override
  State<UserImagePicker> createState() => _UserImagePickerState();
}

class _UserImagePickerState extends State<UserImagePicker> with ThemeConsumer {
  final picker = ImagePicker();
  File? selectedImage;

  Future<void> takePicture() async {
    final XFile? image =
        await picker.pickImage(source: ImageSource.camera, maxWidth: 600);
    if (image == null) return;

    final String fileName = path.basename(image.path);
    final Directory appDir = await getApplicationDocumentsDirectory();
    final String savedImagePath = '${appDir.path}/$fileName';
    await image.saveTo(savedImagePath);

    setState(() {
      selectedImage = File(savedImagePath);
    });

    widget.onSelectImage(selectedImage as File);
  }

  Future<void> pickFromGallery() async {
    final XFile? image =
        await picker.pickImage(source: ImageSource.gallery, maxWidth: 600);
    if (image == null) return;

    final String fileName = path.basename(image.path);
    final Directory appDir = await getApplicationDocumentsDirectory();
    final String savedImagePath = '${appDir.path}/$fileName';
    await image.saveTo(savedImagePath);

    setState(() {
      selectedImage = File(savedImagePath);
    });

    widget.onSelectImage(selectedImage as File);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Container(
        padding: const EdgeInsets.all(20),
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
            CircleAvatar(
              radius: 50,
              backgroundImage: selectedImage == null
                  ? null
                  : FileImage(selectedImage as File),
            ),
            const SizedBox(
              height: 20,
            ),
            TextButton.icon(
              onPressed: pickFromGallery,
              icon: const Icon(Icons.photo),
              label: const Text('Select From Gallery'),
            ),
            TextButton.icon(
              onPressed: takePicture,
              icon: const Icon(Icons.camera_alt),
              label: const Text('Take a picture'),
            ),
            ElevatedButton(
              style: ButtonStyle(
                  backgroundColor: MaterialStateColor.resolveWith(
                (states) => getColorScheme(context).tertiaryContainer,
              )),
              onPressed: () {
                if (selectedImage == null) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: const Text(
                        'You must have a profile picture',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      duration: const Duration(seconds: 2),
                      backgroundColor: getColorScheme(context).error,
                    ),
                  );
                } else {
                  widget.onFinish();
                }
              },
              child: const Text(
                'Confirm',
              ),
            )
          ],
        ),
      ),
    );
  }
}
