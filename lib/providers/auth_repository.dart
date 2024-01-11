import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:game_hub/repositories/auth_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'auth_repository.g.dart';

@riverpod
AuthRepository authRepository(
  AuthRepositoryRef ref, {
  FirebaseAuth? firebaseAuth,
  FirebaseFirestore? firebaseFirestore,
}) {
  final auth = firebaseAuth ?? FirebaseAuth.instance; // coverage:ignore-line
  final firestore =
      firebaseFirestore ?? FirebaseFirestore.instance; // coverage:ignore-line
  return AuthRepository(
    firebaseAuth: auth,
    firebaseFirestore: firestore,
  );
}
