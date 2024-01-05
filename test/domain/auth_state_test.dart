// ignore_for_file: prefer_const_constructors

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:game_hub/domain/domain.dart';
import 'package:game_hub/repositories/repositories.dart';
import 'package:mocktail/mocktail.dart';

import '../helpers/helpers.dart';

class _AuthRepositoryMock extends Mock implements AuthRepository {}

void main() {
  group('AuthState', () {
    late AuthRepository authRepository;

    setUp(() {
      authRepository = _AuthRepositoryMock();
    });

    ProviderContainer createTestContainer() {
      return createContainer(
        overrides: [
          authRepositoryProvider.overrideWith((ref) => authRepository),
        ],
      );
    }

    test('builds correctly', () async {
      when(() => authRepository.currentUser).thenReturn(Session(id: '1'));
      when(() => authRepository.authStateChanges)
          .thenAnswer((_) => Stream.empty());

      final container = createTestContainer();

      final future = container.read(authStateProvider.future);

      await expectLater(
        future,
        completion(Session(id: '1')),
      );
    });
  });
}
