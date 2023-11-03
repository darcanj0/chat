import 'package:chat/core/models/mappers/mapper.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

abstract class IFireStoreMapper<T> {
  T fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> doc,
    SnapshotOptions? options,
  );

  Map<String, Object?> toFirestore(
    T entity,
    SetOptions? options,
  );

  IMapper<T>? mapperDelegate;
}
