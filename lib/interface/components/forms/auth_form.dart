import 'dart:io';

import 'package:chat/interface/components/forms/user_image_picker.dart';
import 'package:chat/core/models/entities/auth_model.dart';
import 'package:chat/util/theme_consumer.dart';
import 'package:chat/util/validation.dart';
import 'package:flutter/material.dart';

class AuthForm extends StatefulWidget {
  const AuthForm({required this.onSubmit, super.key});
  final void Function(AuthModel model) onSubmit;
  @override
  State<AuthForm> createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm>
    with ThemeConsumer, TickerProviderStateMixin {
  final _formData = AuthModel();
  final formKey = GlobalKey<FormState>();
  bool selectingImage = false;
  late final AnimationController fromRightController;
  late final Animation<Offset> fromRightAnimation;
  late final AnimationController toLeftController;
  late final Animation<Offset> toLeftAnimation;

  @override
  void initState() {
    fromRightController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 300));
    toLeftController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 300));
    toLeftAnimation = Tween<Offset>(
            begin: Offset.zero, end: const Offset(-5, 0))
        .animate(CurvedAnimation(parent: toLeftController, curve: Curves.ease));
    fromRightAnimation =
        Tween<Offset>(begin: const Offset(5, 0), end: Offset.zero).animate(
            CurvedAnimation(parent: fromRightController, curve: Curves.ease));

    fromRightController.forward();

    super.initState();
  }

  @override
  void dispose() {
    fromRightController.dispose();
    toLeftController.dispose();
    super.dispose();
  }

  void selectImage(File image) => _formData.image = image;

  Future<void> submitForm() async {
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();
      if (_formData.isSignup) {
        await toLeftController.forward();
        setState(() {
          selectingImage = true;
        });
        await fromRightController.forward();
      } else {
        widget.onSubmit(_formData);
      }
    }
  }

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
          child: selectingImage
              ? SlideTransition(
                  position: fromRightAnimation,
                  child: UserImagePicker(
                    onSelectImage: selectImage,
                    onFinish: () => widget.onSubmit(_formData),
                  ),
                )
              : SlideTransition(
                  position: toLeftAnimation,
                  child: Container(
                    padding: const EdgeInsets.only(
                        left: 20, right: 20, bottom: 15, top: 20),
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
                    child: Form(
                      key: formKey,
                      child: Column(
                        children: [
                          if (_formData.isSignup)
                            TextFormField(
                              key: const ValueKey('name'),
                              initialValue: _formData.name,
                              decoration:
                                  const InputDecoration(labelText: 'Name'),
                              textInputAction: TextInputAction.next,
                              validator: (value) =>
                                  const ValidationComposite(validations: [
                                IsEmptyStringValidation(),
                                IsTooShortString(minSize: 4),
                                IsTooLongString(maxSize: 50)
                              ]).validate(value),
                              onSaved: (newValue) =>
                                  _formData.name = newValue as String,
                              onChanged: (value) => _formData.name = value,
                            ),
                          TextFormField(
                            key: const ValueKey('email'),
                            decoration:
                                const InputDecoration(labelText: 'Email'),
                            textInputAction: TextInputAction.next,
                            keyboardType: TextInputType.emailAddress,
                            validator: (value) =>
                                const ValidationComposite(validations: [
                              IsEmptyStringValidation(),
                              IsValidEmail(),
                            ]).validate(value),
                            onSaved: (newValue) =>
                                _formData.email = newValue as String,
                          ),
                          TextFormField(
                            key: const ValueKey('password'),
                            decoration:
                                const InputDecoration(labelText: 'Password'),
                            textInputAction: TextInputAction.done,
                            obscureText: true,
                            validator: (value) =>
                                const ValidationComposite(validations: [
                              IsEmptyStringValidation(),
                              IsTooShortString(minSize: 5),
                              IsTooLongString(maxSize: 50),
                            ]).validate(value),
                            onSaved: (newValue) =>
                                _formData.password = newValue as String,
                          ),
                          const SizedBox(height: 20),
                          ElevatedButton(
                            style: ButtonStyle(
                                backgroundColor: MaterialStateColor.resolveWith(
                              (states) =>
                                  getColorScheme(context).tertiaryContainer,
                            )),
                            onPressed: submitForm,
                            child: Text(
                              _formData.isLogin ? 'Login' : 'Continue',
                            ),
                          ),
                          const SizedBox(height: 20),
                          TextButton(
                            onPressed: () => setState(() {
                              _formData.toggleAuthMode();
                            }),
                            child: Text(
                              _formData.isSignup
                                  ? 'Already have an account?'
                                  : 'Create account',
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
        ),
      ],
    );
  }
}
