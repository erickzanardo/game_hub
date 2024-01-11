import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:game_hub/repositories/repositories.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'game_versions_repository.g.dart';

@riverpod
GameVersionsRepository gameVersionsRepository(
  GameVersionsRepositoryRef ref, {
  FirebaseFirestore? firestore,
}) {
  return GameVersionsRepository(
      firestore: firestore ?? FirebaseFirestore.instance);
}
