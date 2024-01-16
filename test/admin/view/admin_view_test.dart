// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:game_hub/admin/admin.dart';
import 'package:mocktail/mocktail.dart';
import 'package:nes_ui/nes_ui.dart';

import '../../helpers/helpers.dart';

void main() {
  group('AdmingView', () {
    testWidgets('renders', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: flutterNesTheme(),
          home: AdminView(),
        ),
      );

      expect(find.byType(AdminView), findsOneWidget);
      expect(find.text('Admin Dashboard'), findsOneWidget);
    });

    testWidgets('navigates to Games when taping games button', (tester) async {
      final navigator = MockGoRouter();
      when(() => navigator.go('/admin/games')).thenAnswer((_) async {});
      await tester.pumpWidget(
        MaterialApp(
          theme: flutterNesTheme(),
          home: MockGoRouterProvider(
            goRouter: navigator,
            child: AdminView(),
          ),
        ),
      );

      await tester.tap(find.text('Games'));
      await tester.pumpAndSettle();

      verify(() => navigator.go('/admin/games')).called(1);
    });
  });
}
