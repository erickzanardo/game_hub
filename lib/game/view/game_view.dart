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
    final gameVersionsState = ref.watch(gameVersionsProvider(gameId));
    const containerWidth = 600.0;
    return Scaffold(
      body: Column(
        children: [
          gameState.when(
            data: (game) => Padding(
              padding: const EdgeInsets.all(16),
              child: Center(
                child: NesContainer(
                  width: containerWidth,
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
          gameVersionsState.when(
            data: (gameVersions) => Padding(
              padding: const EdgeInsets.all(16),
              child: NesContainer(
                width: containerWidth,
                child: gameVersions.isEmpty
                    ? const Text('No versions available')
                    : ListTile(
                        title: Text(gameVersions.first.version),
                        subtitle: Text(gameVersions.first.description),
                        trailing: ConstrainedBox(
                          constraints: const BoxConstraints(
                            maxWidth: 400,
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              if (gameVersions.first.macosUrl != null)
                                _DownloadLink(
                                  label: 'macOS',
                                  link: gameVersions.first.macosUrl!,
                                ),
                              if (gameVersions.first.windowsUrl != null)
                                _DownloadLink(
                                  label: 'Windows',
                                  link: gameVersions.first.windowsUrl!,
                                ),
                              if (gameVersions.first.linuxUrl != null)
                                _DownloadLink(
                                  label: 'Linux',
                                  link: gameVersions.first.linuxUrl!,
                                ),
                            ],
                          ),
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
        ],
      ),
    );
  }
}

class _DownloadLink extends StatelessWidget {
  const _DownloadLink({
    required this.label,
    required this.link,
  });

  final String label;
  final String link;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4),
      child: NesButton(
        onPressed: () {
          //
        },
        type: NesButtonType.normal,
        child: Text(
          label,
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                fontSize: 8,
              ),
        ),
      ),
    );
  }
}
