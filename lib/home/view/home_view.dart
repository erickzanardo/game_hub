import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:game_hub/providers/providers.dart';
import 'package:go_router/go_router.dart';
import 'package:nes_ui/nes_ui.dart';

class HomeView extends ConsumerWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authStateProvider);

    return Scaffold(
      body: authState.when(
        data: (authStatus) {
          if (authStatus == null) {
            return const _UnauthenticatedView();
          } else {
            return const _AuthenticatedView();
          }
        },
        error: (err, stack) {
          return Center(
            child: Text(err.toString()),
          );
        },
        loading: () => const Center(
          child: NesPixelRowLoadingIndicator(),
        ),
      ),
    );
  }
}

class _UnauthenticatedView extends ConsumerWidget {
  const _UnauthenticatedView();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Center(
      child: Column(
        children: [
          const Text('Unauthenticated'),
          const SizedBox(height: 16),
          NesButton(
            type: NesButtonType.primary,
            onPressed: () {
              ref.read(authStateProvider.notifier).authenticate();
            },
            child: const Text('Log with Google'),
          ),
        ],
      ),
    );
  }
}

class _AuthenticatedView extends ConsumerWidget {
  const _AuthenticatedView();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final games = ref.watch(gamesProvider);
    final authState = ref.watch(authStateProvider);

    Widget errorHandler(err, stack) => Center(
          child: Text(err.toString()),
        );
    Widget loadingHandler() => const Center(
          child: NesPixelRowLoadingIndicator(),
        );

    return authState.when(
      data: (session) => Stack(
        children: [
          Positioned.fill(
            child: Center(
              child: games.when(
                data: (games) {
                  return Column(
                    children: [
                      const SizedBox(height: 16),
                      const SizedBox(
                        width: 200,
                        height: 50,
                        child: Placeholder(),
                      ),
                      const Divider(),
                      const SizedBox(height: 16),
                      Text('My games',
                          style: Theme.of(context).textTheme.titleLarge),
                      Expanded(
                        child: SizedBox(
                          width: 800,
                          child: SingleChildScrollView(
                            child: Wrap(
                              children: [
                                for (final game in games)
                                  Padding(
                                    padding: const EdgeInsets.all(16),
                                    child: NesPressable(
                                      onPress: () {
                                        context.go('/game/${game.id}');
                                      },
                                      child: NesContainer(
                                        child: Column(
                                          children: [
                                            SizedBox.square(
                                              dimension: 200,
                                              child: Image.network(
                                                game.thumb,
                                                filterQuality:
                                                    FilterQuality.none,
                                                fit: BoxFit.contain,
                                              ),
                                            ),
                                            Text(game.name),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
                },
                error: errorHandler,
                loading: loadingHandler,
              ),
            ),
          ),
          if (session?.isAdmin ?? false)
            Positioned(
              bottom: 16,
              right: 16,
              child: NesButton(
                type: NesButtonType.primary,
                onPressed: () {
                  context.go('/admin');
                },
                child: const Text('Admin'),
              ),
            ),
        ],
      ),
      error: errorHandler,
      loading: loadingHandler,
    );
  }
}
