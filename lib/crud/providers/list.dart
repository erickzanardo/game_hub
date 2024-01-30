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

  void refresh() async {
    state = const AsyncValue.loading();

    try {
      final data = await build(
        adapter: adapter,
        crudContext: crudContext,
      );
      state = AsyncValue.data(data);
    } catch (e, s) {
      state = AsyncValue.error(e, s);
    }
  }
}
