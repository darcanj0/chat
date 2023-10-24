import 'package:chat/util/theme_consumer.dart';
import 'package:flutter/material.dart';

class AuthForm extends StatefulWidget {
  const AuthForm({super.key});

  @override
  State<AuthForm> createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> with ThemeConsumer {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Container(
            alignment: Alignment.center,
            height: 100,
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              color: const Color.fromARGB(179, 160, 117, 240),
              boxShadow: const [
                BoxShadow(
                  offset: Offset(0, 25),
                  blurRadius: 20,
                  color: Color.fromARGB(76, 0, 0, 0),
                )
              ],
              border: Border.all(
                width: 2,
                color: const Color.fromARGB(54, 160, 117, 240),
              ),
            ),
            child: Text(
              "Talkative",
              style: getTextTheme(context).displayLarge,
            ),
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        Padding(
          padding: const EdgeInsets.all(10),
          child: Container(
            padding: const EdgeInsets.only(left: 20, right: 20, bottom: 15),
            decoration: BoxDecoration(
                color: getColorScheme(context).background,
                borderRadius: BorderRadius.circular(10)),
            child: Form(
              child: Column(
                children: [
                  TextFormField(
                    decoration: const InputDecoration(labelText: 'Name'),
                    textInputAction: TextInputAction.next,
                  ),
                  TextFormField(
                    decoration: const InputDecoration(labelText: 'Email'),
                    textInputAction: TextInputAction.next,
                  ),
                  TextFormField(
                    decoration: const InputDecoration(labelText: 'Password'),
                    textInputAction: TextInputAction.done,
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor: MaterialStateColor.resolveWith(
                      (states) => getColorScheme(context).tertiaryContainer,
                    )),
                    onPressed: () {},
                    child: const Text(
                      'Sign In',
                    ),
                  ),
                  const SizedBox(height: 20),
                  TextButton(
                    onPressed: () {},
                    child: const Text(
                      'Already have an account?',
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
