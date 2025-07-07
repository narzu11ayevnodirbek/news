import 'package:firebase_auth/firebase_auth.dart';
import '../../domain/entities/user_entity.dart';

class FirebaseAuthDataSource {
  final FirebaseAuth _firebaseAuth;

  FirebaseAuthDataSource(this._firebaseAuth);

  Future<UserEntity?> signIn(String email, String password) async {
    try {
      final result = await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return _userFromFirebase(result.user);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      } else {
        print('Error: ${e.code}');
      }
    }
    return null;
  }

  Future<UserEntity?> signUp(String email, String password) async {
    final result = await _firebaseAuth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    return _userFromFirebase(result.user);
  }

  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }

  Future<UserEntity?> getCurrentUser() async {
    final user = _firebaseAuth.currentUser;
    return _userFromFirebase(user);
  }

  UserEntity? _userFromFirebase(User? user) {
    if (user == null) return null;
    return UserEntity(
      uid: user.uid,
      email: user.email,
      displayName: user.displayName,
      photoUrl: user.photoURL,
    );
  }
}
