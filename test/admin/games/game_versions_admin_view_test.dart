// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:game_hub/admin/admin.dart';
import 'package:game_hub/crud/crud.dart';
import 'package:game_hub/providers/providers.dart';
import 'package:game_hub/repositories/repositories.dart';
import 'package:mocktail/mocktail.dart';
import 'package:nes_ui/nes_ui.dart';

import '../../helpers/helpers.dart';

class _MockGameVersionsRepository extends Mock
    implements GameVersionsRepository {}

void main() {
  group('GameVersionsAdminView', () {
    late GameVersionsRepository gameVersionsRepository;

    setUp(() {
      gameVersionsRepository = _MockGameVersionsRepository();

      when(
        () => gameVersionsRepository.fetchAll(
          context: any(named: 'context'),
        ),
      ).thenAnswer((_) async => []);
    });

    setUpAll(() {
      registerFallbackValue(RootCrudContext());
    });

    testWidgets('renders', (tester) async {
      when(() =>
              gameVersionsRepository.fetchAll(context: any(named: 'context')))
          .thenAnswer(
        (_) async => [
          GameVersion(
            id: '',
            gameId: '1',
            version: '0.0.1',
            description: '',
          ),
        ],
      );

      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            gameVersionsRepositoryProvider().overrideWith(
              (_) => gameVersionsRepository,
            ),
          ],
          child: MaterialApp(
            theme: flutterNesTheme(),
            home: GameVersionsAdminView(gameId: '1'),
          ),
        ),
      );
      await tester.pumpAndSettle();
      expect(find.text('Game Versions'), findsOneWidget);
      expect(find.text('0.0.1'), findsOneWidget);
    });
  });
}
