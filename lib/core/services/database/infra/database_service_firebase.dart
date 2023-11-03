import 'package:chat/core/models/chat_user.dart';
import 'package:chat/core/services/database/database_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DbServiceFirebase implements IDbService {
  static final _db = FirebaseFirestore.instance;
  @override
  Future<void> saveUser(ChatUser user) async {
    await _db.collection('users').doc(user.id).set(user.toPersistence());
    print('object');
  }

  DbServiceFirebase._();

  static DbServiceFirebase get instance => DbServiceFirebase._();
}
