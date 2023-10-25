import 'dart:io';

class ISignupDto {
  final String name;
  final String email;
  final String password;
  final File image;

  ISignupDto({
    required this.name,
    required this.email,
    required this.password,
    required this.image,
  });
}
