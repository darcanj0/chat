abstract class IMapper<T> {
  Map<String, String> toPersistence(T entity);
  T fromPersistence(Map<String, dynamic> data);
}
