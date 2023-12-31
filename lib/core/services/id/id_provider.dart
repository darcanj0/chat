import 'package:uuid/uuid.dart';

abstract class IIdProvider {
  String generate();

  factory IIdProvider() => UUIDProvider();
}

class UUIDProvider implements IIdProvider {
  static const _lib = Uuid();

  @override
  String generate() {
    return _lib.v4();
  }
}
