abstract class CrudContext {
  const CrudContext();
}

class RootCrudContext extends CrudContext {
  const RootCrudContext();
}

class CrudFieldValidators {
  static bool notEmptyString(String value) {
    return value.isNotEmpty;
  }
}

class CrudField<M, T> {
  const CrudField({
    required this.field,
    required this.label,
    this.isRequired = false,
    this.validator,
    required this.getter,
  });

  final String field;
  final String label;
  final bool isRequired;
  final bool Function(T)? validator;
  final T Function(M) getter;
}

mixin CrudRepositoryAdapter<T> {
  Future<T> fetch(String id);
  Future<List<T>> fetchAll({
    required CrudContext context,
  });
  Future<T> create(T data, {required CrudContext context});
  Future<T> update(T data);
  Future<void> delete(String id);
  List<CrudField<T, dynamic>> get fields;
  T fromValues(String? id, Map<String, dynamic> values);
}
