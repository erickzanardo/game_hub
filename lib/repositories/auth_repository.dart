import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';

extension on User {
  Session toSession() => Session(id: uid);
}

class Session extends Equatable {
  const Session({
    required this.id,
  });

  final String id;

  @override
  List<Object?> get props => [id];
}

class AuthRepository {
  AuthRepository({required FirebaseAuth firebaseAuth})
      : _firebaseAuth = firebaseAuth;

  final FirebaseAuth _firebaseAuth;

  Session? get currentUser => _firebaseAuth.currentUser?.toSession();

  Stream<Session?> get authStateChanges =>
      _firebaseAuth.authStateChanges().map((user) => user?.toSession());

  Future<void> authenticate() async {
    await _firebaseAuth.signInWithPopup(GoogleAuthProvider());
  }
}
