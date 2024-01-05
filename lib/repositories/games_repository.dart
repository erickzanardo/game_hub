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

class GamesRepository {
  GamesRepository({required FirebaseFirestore firestore})
      : _firestore = firestore;

  final FirebaseFirestore _firestore;

  Future<List<Game>> fetchUserGames(String id) async {
    final games = await _firestore
        .collection('games')
        .where('users', arrayContainsAny: [id, '*']).get();

    return games.docs.map((game) {
      return Game(
        id: game.id,
        name: game['name'],
        description: game['description'],
        thumb: game['thumb'],
      );
    }).toList();
  }
}
