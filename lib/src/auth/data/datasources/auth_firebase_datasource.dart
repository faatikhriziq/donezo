import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';

class AuthFirebaseDatasource {
  final FirebaseAuth _firebaseAuth;

  AuthFirebaseDatasource(this._firebaseAuth);

  Future<UserCredential> signInWithEmailAndPassword(String email, String password) async {
    try {
      return await _firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      log(e.toString());
      throw FirebaseAuthException(code: e.code, message: e.message!);
    }
  }

  Future<UserCredential> signUpWithEmailAndPassword(String email, String password) async {
    try {
      return await _firebaseAuth.createUserWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      log(e.toString());
      throw FirebaseAuthException(code: e.code, message: e.message!);
    }
  }

  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }

  Future<User?> getCurrentUser() async {
    return _firebaseAuth.currentUser;
  }
}
