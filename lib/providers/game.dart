import 'package:game_hub/providers/providers.dart';
import 'package:game_hub/repositories/repositories.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'game.g.dart';

@riverpod
class GetGame extends _$GetGame {
  @override
  Future<Game> build(String gameId) async {
    final authRepository = ref.read(authRepositoryProvider());
    final session = authRepository.currentUser;

    if (session == null) {
      throw Exception('User not authenticated');
    }

    final gamesRepository = ref.read(gamesRepositoryProvider());
    final game = await gamesRepository.fetchGame(gameId);
    return game;
  }
}
