import 'dart:async';

import 'package:chat/core/models/entities/chat_user.dart';
import 'package:chat/core/services/auth/auth_service.dart';
import 'package:chat/core/services/auth/dtos/login_dto.dart';
import 'package:chat/core/services/auth/dtos/signup_dto.dart';
import 'package:chat/core/services/database/database_service.dart';
import 'package:chat/core/services/storage/storage_service.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthServiceFirebase implements IAuthService {
  static final _firebase = FirebaseAuth.instance;
  static ChatUser? _currentUser;

  static MultiStreamController<ChatUser?>? _controller;

  static final Stream<ChatUser?> _stream = Stream.multi((p0) async {
    _controller = p0;
    final authState = _firebase.userChanges();
    await for (final user in authState) {
      _currentUser = ChatUser.fromFirebase(user);
      _controller?.add(_currentUser);
    }
  });

  @override
  ChatUser? get currentUser => _currentUser;

  static final _storageService = IStorageService();
  static final _dbService = IDbService();

  @override
  Future<void> login(ILoginDto dto) async {
    await _firebase.signInWithEmailAndPassword(
      email: dto.email,
      password: dto.password,
    );
  }

  @override
  Future<void> logout() async {
    await _firebase.signOut();
  }

  @override
  Future<void> signup(ISignupDto dto) async {
    final UserCredential credential =
        await _firebase.createUserWithEmailAndPassword(
      email: dto.email,
      password: dto.password,
    );

    if (credential.user == null) return;
    final avatarUrl = await _storageService.uploadProfilePicture(
      credential.user!.uid,
      dto.image,
    );
    credential.user!.updatePhotoURL(avatarUrl);

    await credential.user!.updateDisplayName(dto.name);

    await _dbService.saveUser(ChatUser(
      id: credential.user!.uid,
      name: dto.name,
      email: dto.email,
      imageUrl: avatarUrl ?? '',
    ));
  }

  @override
  Stream<ChatUser?> get userChanges => _stream;

  AuthServiceFirebase._();
  static AuthServiceFirebase get instance => AuthServiceFirebase._();
}
