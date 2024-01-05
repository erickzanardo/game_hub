import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../repositories/games_repository.dart';

part 'games_repository.g.dart';

@riverpod
GamesRepository gamesRepository(GamesRepositoryRef ref) {
  return GamesRepository(
    firestore: FirebaseFirestore.instance,
  );
}
