// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:game_hub/crud/crud.dart';
import 'package:game_hub/game/game.dart';
import 'package:game_hub/providers/providers.dart';
import 'package:game_hub/repositories/repositories.dart';
import 'package:mocktail/mocktail.dart';
import 'package:nes_ui/nes_ui.dart';

class _MockCrudRepositoryAdapter extends Mock
    implements CrudRepositoryAdapter<Game> {}

void main() {
  group('CrudView', () {
    late CrudRepositoryAdapter<Game> crudRepositoryAdapter;

    setUp(() {
      crudRepositoryAdapter = _MockCrudRepositoryAdapter();

      when(
        () => crudRepositoryAdapter.fetchAll(
          context: any(named: 'context'),
        ),
      ).thenAnswer((_) async => []);
    });

    setUpAll(() {
      registerFallbackValue(RootCrudContext());
    });

    testWidgets('renders', (tester) async {
      when(() => crudRepositoryAdapter.fetchAll(context: any(named: 'context')))
          .thenAnswer(
        (_) async => [
          Game(id: '', name: 'Stardustry', description: '', thumb: ''),
        ],
      );

      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            crudListProvider(
                crudContext: RootCrudContext(), adapter: crudRepositoryAdapter),
          ],
          child: MaterialApp(
            theme: flutterNesTheme(),
            home: CrudView<Game>(
              title: 'Games',
              repository: crudRepositoryAdapter,
              listItemBuilder: (BuildContext context, Game game) =>
                  Text(game.name),
              crudContext: RootCrudContext(),
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();
      expect(find.text('Games'), findsOneWidget);
      expect(find.text('Stardustry'), findsOneWidget);
    });

    testWidgets('renders when is a root context', (tester) async {
      when(() => crudRepositoryAdapter.fetchAll(context: any(named: 'context')))
          .thenAnswer(
        (_) async => [
          Game(id: '', name: 'Stardustry', description: '', thumb: ''),
        ],
      );

      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            crudListProvider(
                crudContext: RootCrudContext(), adapter: crudRepositoryAdapter),
          ],
          child: MaterialApp(
            theme: flutterNesTheme(),
            home: CrudView<Game>.root(
              title: 'Games',
              repository: crudRepositoryAdapter,
              listItemBuilder: (BuildContext context, Game game) =>
                  Text(game.name),
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();
      expect(find.text('Games'), findsOneWidget);
      expect(find.text('Stardustry'), findsOneWidget);
    });

    testWidgets('renders custom actions', (tester) async {
      when(() => crudRepositoryAdapter.fetchAll(context: any(named: 'context')))
          .thenAnswer(
        (_) async => [
          Game(id: '001', name: 'Stardustry', description: '', thumb: ''),
        ],
      );

      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            crudListProvider(
                crudContext: RootCrudContext(), adapter: crudRepositoryAdapter),
          ],
          child: MaterialApp(
            theme: flutterNesTheme(),
            home: CrudView<Game>(
              title: 'Games',
              repository: crudRepositoryAdapter,
              listItemBuilder: (BuildContext context, Game game) =>
                  Text(game.name),
              actionsBuilder: (BuildContext context, Game game) => [
                Text(
                  game.id,
                ),
              ],
              crudContext: RootCrudContext(),
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();
      expect(find.text('Games'), findsOneWidget);
      expect(find.text('Stardustry'), findsOneWidget);
      expect(find.text('001'), findsOneWidget);
    });

    testWidgets('renders the error message when something goes wrong',
        (tester) async {
      when(() => crudRepositoryAdapter.fetchAll(context: any(named: 'context')))
          .thenThrow(Exception('oops'));

      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            crudListProvider(
                crudContext: RootCrudContext(), adapter: crudRepositoryAdapter),
          ],
          child: MaterialApp(
            theme: flutterNesTheme(),
            home: CrudView<Game>(
              title: 'Games',
              repository: crudRepositoryAdapter,
              listItemBuilder: (BuildContext context, Game game) =>
                  Text(game.name),
              actionsBuilder: (BuildContext context, Game game) => [
                Text(
                  game.id,
                ),
              ],
              crudContext: RootCrudContext(),
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();
      expect(find.text('Exception: oops'), findsOneWidget);
    });
  });
}
