import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:game_hub/repositories/repositories.dart';
import 'package:mocktail/mocktail.dart';

class _FirebaseAuthMock extends Mock implements FirebaseAuth {}

class _UserCredentialFake extends Fake implements UserCredential {}

class _UserMock extends Mock implements User {}

void main() {
  group('AuthRepository', () {
    setUpAll(() {
      registerFallbackValue(GoogleAuthProvider());
    });

    test('can be instantiated', () {
      expect(
        AuthRepository(firebaseAuth: _FirebaseAuthMock()),
        isA<AuthRepository>(),
      );
    });

    test('can authenticate', () async {
      final firebaseAuth = _FirebaseAuthMock();
      final authRepository = AuthRepository(firebaseAuth: firebaseAuth);

      when(() => firebaseAuth.signInWithPopup(any()))
          .thenAnswer((_) async => _UserCredentialFake());

      await authRepository.authenticate();

      verify(() => firebaseAuth.signInWithPopup(any())).called(1);
    });

    test('currentUser returns null when not authenticated', () {
      final firebaseAuth = _FirebaseAuthMock();
      final authRepository = AuthRepository(firebaseAuth: firebaseAuth);

      when(() => firebaseAuth.currentUser).thenReturn(null);

      expect(authRepository.currentUser, isNull);
    });

    test('currentUser returns a session when authenticated', () {
      final firebaseAuth = _FirebaseAuthMock();
      final authRepository = AuthRepository(firebaseAuth: firebaseAuth);

      final user = _UserMock();
      when(() => user.uid).thenReturn('1');
      when(() => user.displayName).thenReturn('Test');
      when(() => user.photoURL).thenReturn('http://test.com');

      when(() => firebaseAuth.currentUser).thenReturn(user);

      expect(
        authRepository.currentUser,
        equals(
          const Session(
            id: '1',
          ),
        ),
      );
    });

    test('authStateChanges emits new user data', () {
      final firebaseAuth = _FirebaseAuthMock();
      final authRepository = AuthRepository(firebaseAuth: firebaseAuth);

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
          ),
        ),
      );
    });
  });
}
