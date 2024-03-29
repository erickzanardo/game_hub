import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:game_hub/crud/crud.dart';

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
}

class GamesRepository with CrudRepositoryAdapter<Game> {
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

  @override
  Future<Game> fetch(String id) async {
    final game = await _firestore.collection('games').doc(id).get();

    return game.toGame();
  }

  @override
  Future<Game> create(
    Game data, {
    required CrudContext context,
  }) {
    // TODO: implement create
    throw UnimplementedError();
  }

  @override
  Future<void> delete(String id) {
    // TODO: implement delete
    throw UnimplementedError();
  }

  @override
  Future<List<Game>> fetchAll({
    required CrudContext context,
  }) async {
    final games = await _firestore.collection('games').get();

    return games.docs.map((game) {
      return game.toGame();
    }).toList();
  }

  @override
  Future<Game> update(Game data) {
    // TODO: implement update
    throw UnimplementedError();
  }
}
