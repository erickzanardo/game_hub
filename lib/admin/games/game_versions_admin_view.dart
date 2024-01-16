import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:game_hub/crud/crud.dart';
import 'package:game_hub/providers/providers.dart';
import 'package:game_hub/repositories/repositories.dart';

class GameVersionsAdminView extends ConsumerWidget {
  const GameVersionsAdminView({
    required this.gameId,
    super.key,
  });

  final String gameId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final repository = ref.watch(gameVersionsRepositoryProvider());
    return CrudView<GameVersion>(
      title: 'Game Versions',
      repository: repository,
      crudContext: GameVersionsCrudContext(gameId),
      listItemBuilder: (context, version) {
        return Text(version.version);
      },
    );
  }
}
