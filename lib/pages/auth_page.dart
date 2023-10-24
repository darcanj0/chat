import 'package:chat/util/theme_consumer.dart';
import 'package:flutter/material.dart';

import '../components/auth_form.dart';

class AuthPage extends StatelessWidget with ThemeConsumer {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: getPrimaryColor(context),
      body: Center(
        child: SingleChildScrollView(
          child: AuthForm(),
        ),
      ),
    );
  }
}
