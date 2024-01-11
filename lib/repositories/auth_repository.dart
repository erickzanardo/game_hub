import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';

extension on User {
  Session toSession({
    required bool isAdmin,
  }) =>
      Session(
        id: uid,
        isAdmin: isAdmin,
      );
}

class Session extends Equatable {
  const Session({
    required this.id,
    required this.isAdmin,
  });

  final String id;
  final bool isAdmin;

  @override
  List<Object?> get props => [id];
}

class AuthRepository {
  AuthRepository({
    required FirebaseAuth firebaseAuth,
    required FirebaseFirestore firebaseFirestore,
  })  : _firebaseAuth = firebaseAuth,
        _firebaseFirestore = firebaseFirestore;

  final FirebaseAuth _firebaseAuth;
  final FirebaseFirestore _firebaseFirestore;

  Future<Session?> currentUser() async {
    final user = _firebaseAuth.currentUser;

    if (user != null) {
      return user.toSession(isAdmin: await _isAdmin(user.uid));
    }

    return null;
  }

  Future<bool> _isAdmin(String uid) async {
    final doc =
        await _firebaseFirestore.collection('user_admins').doc(uid).get();

    return doc.exists;
  }

  Stream<Future<Session?>> get authStateChanges =>
      _firebaseAuth.authStateChanges().map((user) async {
        if (user != null) {
          return user.toSession(isAdmin: await _isAdmin(user.uid));
        }

        return null;
      });

  Future<void> authenticate() async {
    await _firebaseAuth.signInWithPopup(GoogleAuthProvider());
  }
}
