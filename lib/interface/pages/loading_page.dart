import 'package:chat/util/theme_consumer.dart';
import 'package:flutter/material.dart';

class LoadingPage extends StatelessWidget with ThemeConsumer {
  const LoadingPage({super.key});

  @override
  Widget build(BuildContext context) {
    final primaryColor = getPrimaryColor(context);

    return Scaffold(
      backgroundColor: primaryColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Loading',
              style: getTextTheme(context).displayMedium,
            ),
            const SizedBox(
              height: 20,
            ),
            SizedBox(
              width: 300,
              child: LinearProgressIndicator(
                color: primaryColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
