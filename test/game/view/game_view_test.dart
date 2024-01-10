// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:game_hub/game/game.dart';
import 'package:game_hub/providers/providers.dart';
import 'package:game_hub/repositories/repositories.dart';
import 'package:mocktail/mocktail.dart';
import 'package:mocktail_image_network/mocktail_image_network.dart';
import 'package:nes_ui/nes_ui.dart';

import '../../helpers/helpers.dart';

class _MockGamesRepository extends Mock implements GamesRepository {}

class _MockAuthRepository extends Mock implements AuthRepository {}

void main() {
  group('GameView', () {
    late GamesRepository gamesRepository;
    late AuthRepository authRepository;

    setUp(() {
      gamesRepository = _MockGamesRepository();
      authRepository = _MockAuthRepository();
    });

    testWidgets('renders', (tester) async {
      when(() => gamesRepository.fetchGame('1')).thenAnswer(
        (_) async => const Game(
          id: '1',
          name: 'Stardustry',
          description: 'A Great game releasing soon!',
          thumb: '',
        ),
      );

      when(() => gamesRepository.fetchGameVersions('1')).thenAnswer(
        (_) async => const [
          GameVersion(
            id: 'id',
            gameId: '1',
            version: '0.0.1',
            description: '',
            macosUrl: '',
            windowsUrl: '',
            linuxUrl: '',
          ),
        ],
      );

      when(() => authRepository.currentUser).thenReturn(const Session(id: ''));

      await mockNetworkImages(
        () async {
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
                home: GameView(gameId: '1'),
              ),
            ),
          );
          await tester.pumpAndSettle();
        },
      );
      expect(find.byType(GameView), findsOneWidget);
      expect(find.text('Stardustry'), findsOneWidget);
      expect(find.text('A Great game releasing soon!'), findsOneWidget);
      expect(find.text('0.0.1'), findsOneWidget);
      expect(find.text('MacOS'), findsOneWidget);
      expect(find.text('Linux'), findsOneWidget);
      expect(find.text('Windows'), findsOneWidget);
      expect(find.byType(Image), findsOneWidget);
    });

    testWidgets('download the linux version', (tester) async {
      tester.setScreenSize(Size(1280, 1280));
      addTearDown(tester.view.resetPhysicalSize);

      when(() => gamesRepository.fetchGame('1')).thenAnswer(
        (_) async => const Game(
          id: '1',
          name: 'Stardustry',
          description: 'A Great game releasing soon!',
          thumb: '',
        ),
      );

      when(() => gamesRepository.fetchGameVersions('1')).thenAnswer(
        (_) async => const [
          GameVersion(
            id: 'id',
            gameId: '1',
            version: '0.0.1',
            description: '',
            macosUrl: '',
            windowsUrl: '',
            linuxUrl: '',
          ),
        ],
      );

      when(() => authRepository.currentUser).thenReturn(const Session(id: ''));

      await mockNetworkImages(
        () async {
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
                home: GameView(gameId: '1'),
              ),
            ),
          );
          await tester.pumpAndSettle();
        },
      );

      final button = find.ancestor(
          of: find.text('Linux'), matching: find.byType(NesButton));
      await tester.tap(button);
      // TODO(erickzanardo): Add assertion
    });

    testWidgets('download the macos version', (tester) async {
      tester.setScreenSize(Size(1280, 1280));
      addTearDown(tester.view.resetPhysicalSize);

      when(() => gamesRepository.fetchGame('1')).thenAnswer(
        (_) async => const Game(
          id: '1',
          name: 'Stardustry',
          description: 'A Great game releasing soon!',
          thumb: '',
        ),
      );

      when(() => gamesRepository.fetchGameVersions('1')).thenAnswer(
        (_) async => const [
          GameVersion(
            id: 'id',
            gameId: '1',
            version: '0.0.1',
            description: '',
            macosUrl: '',
            windowsUrl: '',
            linuxUrl: '',
          ),
        ],
      );

      when(() => authRepository.currentUser).thenReturn(const Session(id: ''));

      await mockNetworkImages(
        () async {
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
                home: GameView(gameId: '1'),
              ),
            ),
          );
          await tester.pumpAndSettle();
        },
      );

      final button = find.ancestor(
          of: find.text('MacOS'), matching: find.byType(NesButton));
      await tester.tap(button);
      // TODO(erickzanardo): Add assertion
    });

    testWidgets('download the windows version', (tester) async {
      tester.setScreenSize(Size(1280, 1280));
      addTearDown(tester.view.resetPhysicalSize);

      when(() => gamesRepository.fetchGame('1')).thenAnswer(
        (_) async => const Game(
          id: '1',
          name: 'Stardustry',
          description: 'A Great game releasing soon!',
          thumb: '',
        ),
      );

      when(() => gamesRepository.fetchGameVersions('1')).thenAnswer(
        (_) async => const [
          GameVersion(
            id: 'id',
            gameId: '1',
            version: '0.0.1',
            description: '',
            macosUrl: '',
            windowsUrl: '',
            linuxUrl: '',
          ),
        ],
      );

      when(() => authRepository.currentUser).thenReturn(const Session(id: ''));

      await mockNetworkImages(
        () async {
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
                home: GameView(gameId: '1'),
              ),
            ),
          );
          await tester.pumpAndSettle();
        },
      );

      final button = find.ancestor(
          of: find.text('Windows'), matching: find.byType(NesButton));
      await tester.tap(button);
      // TODO(erickzanardo): Add assertion
    });

    testWidgets('renders a loading indicator', (tester) async {
      when(() => gamesRepository.fetchGame('1')).thenAnswer(
        (_) async => const Game(
          id: '1',
          name: 'Stardustry',
          description: 'A Great game releasing soon!',
          thumb: '',
        ),
      );

      when(() => authRepository.currentUser).thenReturn(const Session(id: ''));

      await mockNetworkImages(
        () async {
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
                home: GameView(gameId: '1'),
              ),
            ),
          );
        },
      );
      expect(find.byType(GameView), findsOneWidget);
      expect(find.byType(NesPixelRowLoadingIndicator), findsNWidgets(2));
    });

    testWidgets('renders an error when something goes wrong', (tester) async {
      when(() => authRepository.currentUser).thenReturn(null);

      await mockNetworkImages(
        () async {
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
                home: GameView(gameId: '1'),
              ),
            ),
          );
          await tester.pumpAndSettle();
        },
      );
      expect(find.byType(GameView), findsOneWidget);
      expect(find.text('Exception: User not authenticated'), findsOneWidget);
    });

    testWidgets('renders an error when loading the versions fail',
        (tester) async {
      when(() => gamesRepository.fetchGameVersions('1')).thenThrow(
        Exception('Error fetching game versions'),
      );

      await mockNetworkImages(
        () async {
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
                home: GameView(gameId: '1'),
              ),
            ),
          );
          await tester.pumpAndSettle();
        },
      );
      expect(find.byType(GameView), findsOneWidget);
      expect(
          find.text('Exception: Error fetching game versions'), findsOneWidget);
    });
  });
}
