import 'package:game_hub/providers/providers.dart';
import 'package:game_hub/repositories/repositories.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'game_versions.g.dart';

@riverpod
class GameVersions extends _$GameVersions {
  @override
  Future<List<GameVersion>> build(String gameId) async {
    final gamesRepository = ref.read(gameVersionsRepositoryProvider());

    return gamesRepository.fetchGameVersions(gameId);
  }
}
