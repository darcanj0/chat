import 'package:chat/core/models/chat_user.dart';
import 'package:chat/core/services/auth/auth_service.dart';
import 'package:chat/core/services/auth/dtos/login_dto.dart';
import 'package:chat/core/services/auth/dtos/signup_dto.dart';

class AuthServiceMock implements IAuthService {
  @override
  ChatUser? get currentUser => throw UnimplementedError();

  @override
  Future<void> login(ILoginDto dto) {
    throw UnimplementedError();
  }

  @override
  Future<void> logout() {
    throw UnimplementedError();
  }

  @override
  Future<void> signup(ISignupDto dto) {
    throw UnimplementedError();
  }

  @override
  Stream<ChatUser?> get userChanges => throw UnimplementedError();

  AuthServiceMock._();

  static AuthServiceMock get instance => AuthServiceMock._();
}
