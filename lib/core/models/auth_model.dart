import 'dart:io';

enum AuthModes { signup, login }

class AuthModel {
  String name = '';
  String email = '';
  String password = '';
  File? image;
  AuthModes _authMode = AuthModes.login;

  bool get isLogin => _authMode == AuthModes.login;
  bool get isSignup => _authMode == AuthModes.signup;

  void toggleAuthMode() {
    switch (_authMode) {
      case AuthModes.login:
        _authMode = AuthModes.signup;
      case AuthModes.signup:
        _authMode = AuthModes.login;
    }
  }
}
