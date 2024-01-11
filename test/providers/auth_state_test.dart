// ignore_for_file: prefer_const_constructors

import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:game_hub/providers/providers.dart';
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
          authRepositoryProvider().overrideWith((ref) => authRepository),
        ],
      );
    }

    test('builds correctly', () async {
      when(authRepository.currentUser)
          .thenAnswer((_) async => Session(id: '1', isAdmin: false));
      when(() => authRepository.authStateChanges)
          .thenAnswer((_) => Stream.empty());

      final container = createTestContainer();

      final future = container.read(authStateProvider.future);

      await expectLater(
        future,
        completion(Session(id: '1', isAdmin: false)),
      );
    });

    test('can authenticate', () async {
      when(authRepository.currentUser).thenAnswer((_) async => null);
      when(() => authRepository.authStateChanges)
          .thenAnswer((_) => Stream.empty());
      when(authRepository.authenticate).thenAnswer((_) async {});

      final container = createTestContainer();

      container.read(authStateProvider.notifier).authenticate();

      verify(authRepository.authenticate).called(1);
    });

    test('emits authenticated when a new session arrives', () async {
      final controller = StreamController<Future<Session?>>();
      when(authRepository.currentUser).thenAnswer((_) async => null);

      when(() => authRepository.authStateChanges).thenAnswer(
        (_) => controller.stream,
      );

      final container = createTestContainer();

      final completer = Completer<Session?>();

      container.listen(authStateProvider, (previous, next) async {
        if (next.value != null) {
          completer.complete(next.value);
        }
      });

      controller.add(Future.value(Session(id: '1', isAdmin: false)));

      await expectLater(
        completer.future,
        completion(Session(id: '1', isAdmin: false)),
      );
    });
  });
}
