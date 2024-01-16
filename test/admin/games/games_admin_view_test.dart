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

class _MockGamesRepository extends Mock implements GamesRepository {}

void main() {
  group('GamesAdminView', () {
    late GamesRepository gamesRepository;

    setUp(() {
      gamesRepository = _MockGamesRepository();

      when(
        () => gamesRepository.fetchAll(
          context: any(named: 'context'),
        ),
      ).thenAnswer((_) async => []);
    });

    setUpAll(() {
      registerFallbackValue(RootCrudContext());
    });

    testWidgets('renders', (tester) async {
      when(() => gamesRepository.fetchAll(context: any(named: 'context')))
          .thenAnswer(
        (_) async => [
          Game(id: '', name: 'Stardustry', description: '', thumb: ''),
        ],
      );

      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            gamesRepositoryProvider().overrideWith((_) => gamesRepository),
          ],
          child: MaterialApp(
            theme: flutterNesTheme(),
            home: GamesAdminView(),
          ),
        ),
      );
      await tester.pumpAndSettle();
      expect(find.text('Games'), findsOneWidget);
      expect(find.text('Stardustry'), findsOneWidget);
    });

    testWidgets('navigates to game versions admin', (tester) async {
      tester.setScreenSize(Size(2000, 2000));
      when(() => gamesRepository.fetchAll(context: any(named: 'context')))
          .thenAnswer(
        (_) async => [
          Game(id: '1', name: 'Stardustry', description: '', thumb: ''),
        ],
      );

      final goRouter = MockGoRouter();
      when(() => goRouter.go('/admin/games/1/versions'))
          .thenAnswer((_) async {});

      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            gamesRepositoryProvider().overrideWith((_) => gamesRepository),
          ],
          child: MaterialApp(
            theme: flutterNesTheme(),
            home: MockGoRouterProvider(
              goRouter: goRouter,
              child: GamesAdminView(),
            ),
          ),
        ),
      );

      await tester.pumpAndSettle();

      await tester.tap(
        find.byWidgetPredicate(
            (widget) => widget is NesIcon && widget.iconData == NesIcons.paste),
      );
      await tester.pump();

      verify(() => goRouter.go('/admin/games/1/versions')).called(1);
    });
  });
}
