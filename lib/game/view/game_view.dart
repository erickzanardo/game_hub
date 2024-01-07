import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:game_hub/providers/providers.dart';
import 'package:nes_ui/nes_ui.dart';

class GameView extends ConsumerWidget {
  const GameView({
    required this.gameId,
    super.key,
  });

  final String gameId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final gameState = ref.watch(getGameProvider(gameId));
    return Scaffold(
      body: gameState.when(
        data: (game) => Padding(
          padding: const EdgeInsets.all(16),
          child: Center(
            child: NesContainer(
              width: 600,
              child: Column(
                children: [
                  Image.network(
                    game.thumb,
                    width: 400,
                    filterQuality: FilterQuality.none,
                    fit: BoxFit.contain,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    game.name,
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 16),
                  Text(game.description),
                ],
              ),
            ),
          ),
        ),
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
