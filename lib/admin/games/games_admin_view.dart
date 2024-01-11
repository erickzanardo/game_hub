import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:game_hub/crud/crud.dart';
import 'package:game_hub/providers/providers.dart';
import 'package:game_hub/repositories/repositories.dart';
import 'package:go_router/go_router.dart';
import 'package:nes_ui/nes_ui.dart';

class GamesAdminView extends ConsumerWidget {
  const GamesAdminView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final repository = ref.watch(gamesRepositoryProvider());
    return CrudView<Game>.root(
      title: 'Games',
      repository: repository,
      listItemBuilder: (context, game) {
        return Text(game.name);
      },
      actionsBuilder: (context, game) {
        return [
          NesIconButton(
              icon: NesIcons.paste,
              onPress: () {
                context.go('/admin/games/${game.id}/versions');
              }),
        ];
      },
    );
  }
}
