// ignore_for_file: prefer_const_constructors

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:game_hub/crud/crud.dart';
import 'package:mocktail/mocktail.dart';

import '../../helpers/helpers.dart';

class _CrudRepositoryAdapterMock extends Mock
    implements CrudRepositoryAdapter {}

void main() {
  group('CrudList', () {
    late CrudRepositoryAdapter repositoryAdapter;

    setUp(() {
      repositoryAdapter = _CrudRepositoryAdapterMock();
    });

    setUpAll(() {
      registerFallbackValue(RootCrudContext());
    });

    ProviderContainer createTestContainer() => createContainer();

    test('builds correctly', () async {
      when(
        () => repositoryAdapter.fetchAll(
          context: any(named: 'context'),
        ),
      ).thenAnswer(
        (_) async => [],
      );

      final container = createTestContainer();

      final future = container.read(crudListProvider(
        crudContext: RootCrudContext(),
        adapter: repositoryAdapter,
      ).future);

      await expectLater(
        future,
        completion([]),
      );
    });
  });
}
