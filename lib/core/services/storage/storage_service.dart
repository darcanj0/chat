import 'dart:io';
import 'package:chat/core/services/storage/infra/storage_service_firabse.dart';

abstract class IStorageService {
  Future<String?> uploadProfilePicture(String userUid, File image);

  factory IStorageService() => StorageServiceFirebase.instance;
}
