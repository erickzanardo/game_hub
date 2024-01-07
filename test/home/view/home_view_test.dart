// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:game_hub/home/home.dart';
import 'package:game_hub/providers/providers.dart';
import 'package:game_hub/repositories/repositories.dart';
import 'package:mocktail/mocktail.dart';
import 'package:mocktail_image_network/mocktail_image_network.dart';
import 'package:nes_ui/nes_ui.dart';

import '../../helpers/mock_go_router.dart';

class _MockGamesRepository extends Mock implements GamesRepository {}

class _MockAuthRepository extends Mock implements AuthRepository {}

void main() {
  group('HomeView', () {
    late GamesRepository gamesRepository;
    late AuthRepository authRepository;

    setUp(() {
      gamesRepository = _MockGamesRepository();
      authRepository = _MockAuthRepository();
    });
    testWidgets('renders the log button', (tester) async {
      when(() => authRepository.currentUser).thenReturn(null);
      when(() => authRepository.authStateChanges)
          .thenAnswer((_) => Stream.empty());

      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            gamesRepositoryProvider().overrideWith(
              (_) => gamesRepository,
            ),
            authRepositoryProvider().overrideWith(
              (_) => authRepository,
            ),
          ],
          child: MaterialApp(
            theme: flutterNesTheme(),
            home: HomeView(),
          ),
        ),
      );

      await tester.pumpAndSettle();

      expect(find.text('Log with Google'), findsOneWidget);
    });

    testWidgets('authenticates', (tester) async {
      when(() => authRepository.currentUser).thenReturn(null);
      when(() => authRepository.authStateChanges)
          .thenAnswer((_) => Stream.empty());
      when(authRepository.authenticate).thenAnswer((_) async {});

      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            gamesRepositoryProvider().overrideWith(
              (_) => gamesRepository,
            ),
            authRepositoryProvider().overrideWith(
              (_) => authRepository,
            ),
          ],
          child: MaterialApp(
            theme: flutterNesTheme(),
            home: HomeView(),
          ),
        ),
      );

      await tester.pumpAndSettle();

      await tester.tap(find.text('Log with Google'));
      verify(authRepository.authenticate).called(1);
    });

    testWidgets('renders the game list when logged', (tester) async {
      when(() => authRepository.currentUser).thenReturn(const Session(id: '1'));
      when(() => authRepository.authStateChanges)
          .thenAnswer((_) => Stream.empty());

      when(() => gamesRepository.fetchUserGames('1')).thenAnswer(
        (_) async => [
          const Game(
            id: '1',
            name: 'Stardustry',
            description: 'A Great game releasing soon!',
            thumb: '',
          ),
        ],
      );

      await mockNetworkImages(() async {
        await tester.pumpWidget(
          ProviderScope(
            overrides: [
              gamesRepositoryProvider().overrideWith(
                (_) => gamesRepository,
              ),
              authRepositoryProvider().overrideWith(
                (_) => authRepository,
              ),
            ],
            child: MaterialApp(
              theme: flutterNesTheme(),
              home: HomeView(),
            ),
          ),
        );

        await tester.pumpAndSettle();
      });

      expect(find.text('My games'), findsOneWidget);
      expect(find.text('Stardustry'), findsOneWidget);
    });

    testWidgets('renders error when something goes wrong while athenticated',
        (tester) async {
      when(() => authRepository.currentUser).thenReturn(const Session(id: '1'));
      when(() => authRepository.authStateChanges)
          .thenAnswer((_) => Stream.empty());

      when(() => gamesRepository.fetchUserGames('1'))
          .thenThrow(Exception('Error'));

      await mockNetworkImages(() async {
        await tester.pumpWidget(
          ProviderScope(
            overrides: [
              gamesRepositoryProvider().overrideWith(
                (_) => gamesRepository,
              ),
              authRepositoryProvider().overrideWith(
                (_) => authRepository,
              ),
            ],
            child: MaterialApp(
              theme: flutterNesTheme(),
              home: HomeView(),
            ),
          ),
        );

        await tester.pumpAndSettle();
      });

      expect(find.text('Exception: Error'), findsOneWidget);
    });

    testWidgets(
        'renders error when something goes wrong while non athenticated',
        (tester) async {
      when(() => authRepository.currentUser).thenThrow(Exception('Error'));
      when(() => authRepository.authStateChanges)
          .thenAnswer((_) => Stream.empty());

      await mockNetworkImages(() async {
        await tester.pumpWidget(
          ProviderScope(
            overrides: [
              gamesRepositoryProvider().overrideWith(
                (_) => gamesRepository,
              ),
              authRepositoryProvider().overrideWith(
                (_) => authRepository,
              ),
            ],
            child: MaterialApp(
              theme: flutterNesTheme(),
              home: HomeView(),
            ),
          ),
        );

        await tester.pumpAndSettle();
      });

      expect(find.text('Exception: Error'), findsOneWidget);
    });

    testWidgets('navigates to the ame page', (tester) async {
      when(() => authRepository.currentUser).thenReturn(const Session(id: '1'));
      when(() => authRepository.authStateChanges)
          .thenAnswer((_) => Stream.empty());

      when(() => gamesRepository.fetchUserGames('1')).thenAnswer(
        (_) async => [
          const Game(
            id: '1',
            name: 'Stardustry',
            description: 'A Great game releasing soon!',
            thumb: '',
          ),
        ],
      );

      final navigator = MockGoRouter();
      when(navigator.canPop).thenReturn(false);
      when(() => navigator.go(any())).thenAnswer((_) async {});

      await mockNetworkImages(() async {
        await tester.pumpWidget(
          ProviderScope(
            overrides: [
              gamesRepositoryProvider().overrideWith(
                (_) => gamesRepository,
              ),
              authRepositoryProvider().overrideWith(
                (_) => authRepository,
              ),
            ],
            child: MaterialApp(
              theme: flutterNesTheme(),
              home: MockGoRouterProvider(
                goRouter: navigator,
                child: HomeView(),
              ),
            ),
          ),
        );

        await tester.pumpAndSettle();
      });

      await tester.tap(find.byType(NesContainer));

      verify(() => navigator.go(any())).called(1);
    });
  });
}
