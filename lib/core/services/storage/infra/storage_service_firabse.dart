import 'dart:io';
import 'package:chat/core/services/storage/storage_service.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart' as path;

class StorageServiceFirebase implements IStorageService {
  static final _bucketInstance = FirebaseStorage.instance;
  static final _usersDir = _bucketInstance.ref().child('users');

  String _getUserAvatarFolder(String userUid) => '$userUid/avatar';

  @override
  Future<String?> uploadProfilePicture(String userUid, File image) async {
    final Reference fileRef = _usersDir.child(
      '${_getUserAvatarFolder(userUid)}/${path.basename(image.path)}',
    );
    await fileRef.putFile(image).whenComplete(() => null);
    final downloadUrl = await fileRef.getDownloadURL();
    return downloadUrl;
  }

  static IStorageService get instance => StorageServiceFirebase._();

  StorageServiceFirebase._();
}
