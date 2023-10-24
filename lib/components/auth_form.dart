import 'package:chat/models/auth_model.dart';
import 'package:chat/util/theme_consumer.dart';
import 'package:chat/util/validation.dart';
import 'package:flutter/material.dart';

class AuthForm extends StatefulWidget {
  const AuthForm({required this.onSubmit, super.key});
  final void Function(AuthModel) onSubmit;
  @override
  State<AuthForm> createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> with ThemeConsumer {
  final _formData = AuthModel();
  final formKey = GlobalKey<FormState>();

  void submitForm() {
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();
      widget.onSubmit(_formData);
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
          child: Container(
            padding: const EdgeInsets.only(left: 20, right: 20, bottom: 15),
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
                      decoration: const InputDecoration(labelText: 'Name'),
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
                    decoration: const InputDecoration(labelText: 'Email'),
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.emailAddress,
                    validator: (value) =>
                        const ValidationComposite(validations: [
                      IsEmptyStringValidation(),
                      IsValidEmail(),
                    ]).validate(value),
                    onSaved: (newValue) => _formData.email = newValue as String,
                  ),
                  TextFormField(
                    key: const ValueKey('password'),
                    decoration: const InputDecoration(labelText: 'Password'),
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
                      (states) => getColorScheme(context).tertiaryContainer,
                    )),
                    onPressed: submitForm,
                    child: Text(
                      _formData.isLogin ? 'Login' : 'Sign Up',
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
      ],
    );
  }
}
