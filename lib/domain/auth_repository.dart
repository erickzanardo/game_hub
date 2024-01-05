import 'package:firebase_auth/firebase_auth.dart';
import 'package:game_hub/repositories/auth_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'auth_repository.g.dart';

@riverpod
AuthRepository authRepository(AuthRepositoryRef ref) {
  return AuthRepository(firebaseAuth: FirebaseAuth.instance);
}
