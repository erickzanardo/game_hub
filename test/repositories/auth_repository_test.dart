import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:game_hub/repositories/repositories.dart';
import 'package:mocktail/mocktail.dart';

import '../helpers/helpers.dart';

class _FirebaseAuthMock extends Mock implements FirebaseAuth {}

class _FirestoreMock extends Mock implements FirebaseFirestore {}

class _UserCredentialFake extends Fake implements UserCredential {}

class _UserMock extends Mock implements User {}

void main() {
  group('AuthRepository', () {
    setUpAll(() {
      registerFallbackValue(GoogleAuthProvider());
    });

    test('can be instantiated', () {
      expect(
        AuthRepository(
          firebaseAuth: _FirebaseAuthMock(),
          firebaseFirestore: _FirestoreMock(),
        ),
        isA<AuthRepository>(),
      );
    });

    test('can authenticate', () async {
      final firebaseAuth = _FirebaseAuthMock();
      final firebaseFirestore = _FirestoreMock();
      final authRepository = AuthRepository(
        firebaseAuth: firebaseAuth,
        firebaseFirestore: firebaseFirestore,
      );

      when(() => firebaseAuth.signInWithPopup(any()))
          .thenAnswer((_) async => _UserCredentialFake());

      await authRepository.authenticate();

      verify(() => firebaseAuth.signInWithPopup(any())).called(1);
    });

    test('currentUser returns null when not authenticated', () async {
      final firebaseAuth = _FirebaseAuthMock();
      final firebaseFirestore = _FirestoreMock();
      final authRepository = AuthRepository(
        firebaseAuth: firebaseAuth,
        firebaseFirestore: firebaseFirestore,
      );

      when(() => firebaseAuth.currentUser).thenReturn(null);

      final session = await authRepository.currentUser();
      expect(session, isNull);
    });

    test('currentUser returns a session when authenticated', () async {
      final firebaseAuth = _FirebaseAuthMock();
      final firebaseFirestore = _FirestoreMock();
      final authRepository = AuthRepository(
        firebaseAuth: firebaseAuth,
        firebaseFirestore: firebaseFirestore,
      );

      final user = _UserMock();
      when(() => user.uid).thenReturn('1');
      when(() => user.displayName).thenReturn('Test');
      when(() => user.photoURL).thenReturn('http://test.com');

      final collection = MockCollectionReference();
      when(() => firebaseFirestore.collection('user_admins'))
          .thenReturn(collection);

      mockDocumentOnCollection(id: '1', collection: collection);

      when(() => firebaseAuth.currentUser).thenReturn(user);

      expect(
        await authRepository.currentUser(),
        equals(
          const Session(
            id: '1',
            isAdmin: true,
          ),
        ),
      );
    });

    test('authStateChanges emits new user data', () {
      final firebaseAuth = _FirebaseAuthMock();
      final firebaseFirestore = _FirestoreMock();
      final authRepository = AuthRepository(
          firebaseAuth: firebaseAuth, firebaseFirestore: firebaseFirestore);

      final collection = MockCollectionReference();
      when(() => firebaseFirestore.collection('user_admins'))
          .thenReturn(collection);

      mockDocumentOnCollection(id: '1', collection: collection);

      final user = _UserMock();
      when(() => user.uid).thenReturn('1');
      when(() => user.displayName).thenReturn('Test');
      when(() => user.photoURL).thenReturn('http://test.com');

      when(() => firebaseAuth.authStateChanges())
          .thenAnswer((_) => Stream.value(user));

      expect(
        authRepository.authStateChanges,
        emits(
          const Session(
            id: '1',
            isAdmin: true,
          ),
        ),
      );
    });
  });
}
