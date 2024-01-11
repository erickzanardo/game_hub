abstract class CrudContext {
  const CrudContext();
}

class RootCrudContext extends CrudContext {
  const RootCrudContext();
}

mixin CrudRepositoryAdapter<T> {
  Future<T> fetch(String id);
  Future<List<T>> fetchAll({
    required CrudContext context,
  });
  Future<T> create(T data, {required CrudContext context});
  Future<T> update(T data);
  Future<void> delete(String id);
}
