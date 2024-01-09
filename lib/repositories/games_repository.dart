import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class Game extends Equatable {
  const Game({
    required this.id,
    required this.name,
    required this.description,
    required this.thumb,
  });

  final String id;
  final String name;
  final String description;
  final String thumb;

  Game copyWith({
    String? id,
    String? name,
    String? description,
    String? thumb,
  }) {
    return Game(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      thumb: thumb ?? this.thumb,
    );
  }

  @override
  List<Object?> get props => [
        id,
        name,
        description,
        thumb,
      ];
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
  Game toGame() {
    final values = data();
    return Game(
      id: id,
      name: values?['name'] as String? ?? '',
      description: values?['description'] as String? ?? '',
      thumb: values?['thumb'] as String? ?? '',
    );
  }

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

class GamesRepository {
  GamesRepository({required FirebaseFirestore firestore})
      : _firestore = firestore;

  final FirebaseFirestore _firestore;

  Future<List<Game>> fetchUserGames(String id) async {
    final gamesAccessList = await _firestore
        .collection('games_access')
        .where('user_id', isEqualTo: id)
        .get();

    final ids = gamesAccessList.docs.map((game) => game['game_id']).toList();

    final games = await _firestore
        .collection('games')
        .where(FieldPath.documentId, whereIn: ids)
        .get();

    return games.docs.map((game) {
      return game.toGame();
    }).toList();
  }

  Future<Game> fetchGame(String id) async {
    final game = await _firestore.collection('games').doc(id).get();

    return game.toGame();
  }

  Future<List<GameVersion>> fetchGameVersions(String id) async {
    final versions = await _firestore
        .collection('games_versions')
        .where('game_id', isEqualTo: id)
        .get();

    return versions.docs.map((version) {
      return version.toGameVersion();
    }).toList();
  }
}
