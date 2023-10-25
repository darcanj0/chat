import '../../core/models/auth_model.dart';
import 'package:chat/util/theme_consumer.dart';
import 'package:flutter/material.dart';
import '../components/auth_form.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> with ThemeConsumer {
  bool isLoading = false;

  Future<void> handleSubmit(AuthModel authModel) async {
    try {
      setState(() => isLoading = true);
      if (authModel.isLogin) {

      } else {}
    } catch (e) {
    } finally {
      setState(() => isLoading = true);
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
