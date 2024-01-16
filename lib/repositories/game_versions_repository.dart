import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:game_hub/crud/crud.dart';

class GameVersionsCrudContext extends CrudContext {
  GameVersionsCrudContext(this.gameId);

  final String gameId;
}

class GameVersion extends Equatable {
  const GameVersion({
    required this.id,
    required this.gameId,
    required this.version,
    required this.description,
    this.macosUrl,
    this.windowsUrl,
    this.linuxUrl,
  });

  final String id;
  final String gameId;
  final String version;
  final String description;
  final String? macosUrl;
  final String? windowsUrl;
  final String? linuxUrl;

  GameVersion copyWith({
    String? id,
    String? gameId,
    String? version,
    String? description,
    String? macosUrl,
    String? windowsUrl,
    String? linuxUrl,
  }) {
    return GameVersion(
      id: id ?? this.id,
      gameId: gameId ?? this.gameId,
      version: version ?? this.version,
      description: description ?? this.description,
      macosUrl: macosUrl ?? this.macosUrl,
      windowsUrl: windowsUrl ?? this.windowsUrl,
      linuxUrl: linuxUrl ?? this.linuxUrl,
    );
  }

  @override
  List<Object?> get props => [
        id,
        gameId,
        version,
        description,
        macosUrl,
        windowsUrl,
        linuxUrl,
      ];
}

extension on DocumentSnapshot<Map<String, dynamic>> {
  GameVersion toGameVersion() {
    final values = data();
    return GameVersion(
      id: id,
      gameId: values?['game_id'] as String? ?? '',
      version: values?['version'] as String? ?? '',
      description: values?['description'] as String? ?? '',
      macosUrl: values?['macos_url'] as String?,
      windowsUrl: values?['windows_url'] as String?,
      linuxUrl: values?['linux_url'] as String?,
    );
  }
}

class GameVersionsRepository with CrudRepositoryAdapter<GameVersion> {
  GameVersionsRepository({required FirebaseFirestore firestore})
      : _firestore = firestore;

  final FirebaseFirestore _firestore;

  @override
  Future<GameVersion> fetch(String id) async {
    final gameVersion =
        await _firestore.collection('games_versions').doc(id).get();

    return gameVersion.toGameVersion();
  }

  Future<List<GameVersion>> fetchGameVersions(String id) {
    return fetchAll(context: GameVersionsCrudContext(id));
  }

  @override
  Future<GameVersion> create(
    GameVersion data, {
    required CrudContext context,
  }) async {
    // TODO: implement create
    throw UnimplementedError();
  }

  @override
  Future<void> delete(String id) {
    // TODO: implement delete
    throw UnimplementedError();
  }

  @override
  Future<List<GameVersion>> fetchAll({
    required CrudContext context,
  }) async {
    final games = await _firestore
        .collection('games_versions')
        .where(
          'game_id',
          // TOOD(erickzanardo): Really not happy about this cast, need to think on an alternative
          isEqualTo: (context as GameVersionsCrudContext).gameId,
        )
        .get();

    return games.docs.map((game) {
      return game.toGameVersion();
    }).toList();
  }

  @override
  Future<GameVersion> update(GameVersion data) {
    // TODO: implement update
    throw UnimplementedError();
  }
}
