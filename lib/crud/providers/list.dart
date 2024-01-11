import 'package:game_hub/crud/crud.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'list.g.dart';

@riverpod
class CrudList extends _$CrudList {
  @override
  Future<List> build({
    required CrudRepositoryAdapter adapter,
    required CrudContext crudContext,
  }) async {
    return adapter.fetchAll(context: crudContext);
  }
}
