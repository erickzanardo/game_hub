import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:game_hub/providers/providers.dart';
import 'package:game_hub/repositories/repositories.dart';
import 'package:mocktail/mocktail.dart';

class _AuthRepositoryRefMock extends Mock implements AuthRepositoryRef {}

class _FirebaseAuthMock extends Mock implements FirebaseAuth {}

class _FirebaseFirestoreMock extends Mock implements FirebaseFirestore {}

void main() {
  test('returns the repository', () {
    expect(
      authRepository(
        _AuthRepositoryRefMock(),
        firebaseAuth: _FirebaseAuthMock(),
        firebaseFirestore: _FirebaseFirestoreMock(),
      ),
      isA<AuthRepository>(),
    );
  });
}
