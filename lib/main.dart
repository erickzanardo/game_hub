import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:game_hub/admin/admin.dart';
import 'package:game_hub/game/game.dart';
import 'package:game_hub/home/home.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:go_router/go_router.dart';
import 'package:nes_ui/nes_ui.dart';
import 'firebase_options.dart';

final _router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const HomeView(),
    ),
    GoRoute(
      path: '/game/:gameId',
      builder: (context, state) => GameView(
        gameId: state.pathParameters['gameId'] ?? '',
      ),
    ),
    GoRoute(
      path: '/admin',
      builder: (context, state) => const AdminView(),
    ),
    GoRoute(
      path: '/admin/games',
      builder: (context, state) => const GamesAdminView(),
    ),
    GoRoute(
      path: '/admin/games/:gameId/versions',
      builder: (context, state) => GameVersionsAdminView(
        gameId: state.pathParameters['gameId'] ?? '',
      ),
    ),
  ],
);

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(
    BuildContext context,
  ) {
    return MaterialApp.router(
      theme: flutterNesTheme(),
      routerConfig: _router,
    );
  }
}
