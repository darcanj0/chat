import 'dart:io';

import 'package:chat/core/services/auth/auth_service.dart';
import 'package:chat/core/services/auth/dtos/login_dto.dart';
import 'package:chat/core/services/auth/dtos/signup_dto.dart';

import '../../core/models/auth_model.dart';
import 'package:chat/util/theme_consumer.dart';
import 'package:flutter/material.dart';
import '../components/auth_form.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({required this.authService, super.key});

  final IAuthService authService;

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> with ThemeConsumer {
  bool isLoading = false;

  Future<void> handleSubmit(AuthModel authModel) async {
    try {
      setState(() => isLoading = true);
      if (authModel.isLogin) {
        await widget.authService.login(
            ILoginDto(email: authModel.email, password: authModel.password));
      } else {
        await widget.authService.signup(ISignupDto(
            name: authModel.name,
            email: authModel.email,
            password: authModel.password,
            image: authModel.image as File));
      }
    } catch (e) {
      print(e);
    } finally {
      setState(() => isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: getPrimaryColor(context),
      body: Stack(children: [
        Center(
          child: SingleChildScrollView(
            child: AuthForm(onSubmit: handleSubmit),
          ),
        ),
        if (isLoading)
          Container(
            alignment: Alignment.center,
            decoration: BoxDecoration(
                color: getColorScheme(context).scrim.withOpacity(.2)),
            child: CircularProgressIndicator.adaptive(
              backgroundColor: getPrimaryColor(context),
            ),
          )
      ]),
    );
  }
}
