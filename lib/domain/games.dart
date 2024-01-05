import 'package:game_hub/domain/domain.dart';
import 'package:game_hub/repositories/repositories.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'games.g.dart';

@riverpod
class Games extends _$Games {
  @override
  Future<List<Game>> build() async {
    final authRepository = ref.read(authRepositoryProvider);
    final session = authRepository.currentUser;

    if (session == null) {
      throw Exception('User not authenticated');
    }

    return ref.read(gamesRepositoryProvider).fetchUserGames(session.id);
  }
}
