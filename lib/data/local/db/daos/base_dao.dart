abstract class BaseDao<T> {
  const BaseDao();

  Future<T?> findById(String id);

  Future<List<T>> list();

  Future<void> delete(String id);

  Future<void> softDelete(String id);
}
