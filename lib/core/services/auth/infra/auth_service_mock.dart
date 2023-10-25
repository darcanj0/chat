import 'dart:async';
import 'package:chat/core/models/chat_user.dart';
import 'package:chat/core/services/auth/auth_service.dart';
import 'package:chat/core/services/auth/dtos/login_dto.dart';
import 'package:chat/core/services/auth/dtos/signup_dto.dart';
import 'package:chat/core/services/id/id_provider.dart';

class AuthServiceMock implements IAuthService {
  //mock
  static final Map<String, ChatUser> _users = {
    'dan@.com': const ChatUser(
      id: 'id',
      name: 'User',
      email: 'dan@.com',
      imageUrl: 'assets/default_avatar.png',
    )
  };
  static final IIdProvider _idProvider = UUIDProvider();

  @override
  Future<void> login(ILoginDto dto) async {
    _updateUser(_users[dto.email]);
  }

  @override
  Future<void> logout() async {
    _updateUser(null);
  }

  @override
  Future<void> signup(ISignupDto dto) async {
    final newUser = ChatUser(
      id: _idProvider.generate(),
      name: dto.name,
      email: dto.email,
      imageUrl: dto.image.path,
    );
    _users.putIfAbsent(dto.email, () => newUser);
    _updateUser(newUser);
  }

  //stream config
  static MultiStreamController<ChatUser?>? _controller;
  static ChatUser? _currentUser;

  final Stream<ChatUser?> _userStream = Stream.multi((p0) {
    _controller = p0;
    _updateUser(const ChatUser(
      id: 'id',
      name: 'User',
      email: 'dan@.com',
      imageUrl: 'assets/default_avatar.png',
    ));
  });

  static void _updateUser(ChatUser? user) {
    _currentUser = user;
    _controller?.add(_currentUser);
  }

  @override
  Stream<ChatUser?> get userChanges => _userStream;

  @override
  ChatUser? get currentUser => _currentUser;

  //singleton config
  AuthServiceMock._();
  static AuthServiceMock get instance => AuthServiceMock._();
}
