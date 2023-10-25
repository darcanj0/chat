import 'package:chat/core/models/chat_user.dart';
import 'package:chat/core/services/auth/dtos/login_dto.dart';
import 'package:chat/core/services/auth/dtos/signup_dto.dart';

abstract class IAuthService {
  ChatUser? get currentUser;

  Stream<ChatUser?> get userChanges;

  Future<void> signup(ISignupDto dto);
  Future<void> login(ILoginDto dto);
  Future<void> logout();
}
