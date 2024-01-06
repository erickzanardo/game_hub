// ignore_for_file: prefer_const_constructors

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:game_hub/providers/providers.dart';
import 'package:game_hub/repositories/repositories.dart';
import 'package:mocktail/mocktail.dart';

import '../helpers/helpers.dart';

class _AuthRepositoryMock extends Mock implements AuthRepository {}

class _GamesRepositoryMock extends Mock implements GamesRepository {}

void main() {
  group('Games', () {
    late AuthRepository authRepository;
    late GamesRepository gamesRepository;

    setUp(() {
      authRepository = _AuthRepositoryMock();
      gamesRepository = _GamesRepositoryMock();
    });

    ProviderContainer createTestContainer() {
      return createContainer(
        overrides: [
          authRepositoryProvider().overrideWith((ref) => authRepository),
          gamesRepositoryProvider().overrideWith((ref) => gamesRepository),
        ],
      );
    }

    test('builds correctly', () async {
      when(() => authRepository.currentUser).thenReturn(const Session(id: ''));

      when(() => gamesRepository.fetchGame(any())).thenAnswer(
        (_) async => Game(
          id: '1',
          name: 'Stardustry',
          description: 'A Great game releasing soon!',
          thumb: '',
        ),
      );

      final container = createTestContainer();

      final future = container.read(getGameProvider('').future);

      await expectLater(
        future,
        completion(
          Game(
            id: '1',
            name: 'Stardustry',
            description: 'A Great game releasing soon!',
            thumb: '',
          ),
        ),
      );
    });

    test('throws when there is no session', () async {
      when(() => authRepository.currentUser).thenReturn(null);

      final container = createTestContainer();

      final future = container.read(getGameProvider('').future);

      await expectLater(
        future,
        throwsA(
          isA<Exception>().having(
            (e) => e.toString(),
            'Description',
            'Exception: User not authenticated',
          ),
        ),
      );
    });
  });
}
