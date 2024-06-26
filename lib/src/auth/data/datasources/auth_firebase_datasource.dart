import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

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
      throw FirebaseAuthException(code: e.code, message: e.message!);
    } catch (e) {
      throw FirebaseAuthException(code: 'unknown_error', message: e.toString());
    }
  }

  Future<UserCredential> signInWithGoogle() async {
    try {
      GoogleSignIn googleSignIn = GoogleSignIn(
        scopes: [
          'email',
          'https://www.googleapis.com/auth/contacts.readonly',
          'https://www.googleapis.com/auth/userinfo.profile',
        ],
        clientId: "156416546526-esr375jtqus6a4e1t768mfmoafun8v93.apps.googleusercontent.com",
      );
      final googleUser = await googleSignIn.signIn();
      if (googleUser == null) {
        throw FirebaseAuthException(code: 'google_sign_in_failed', message: 'Google sign in failed');
      }
      final googleAuth = await googleUser.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      return await _firebaseAuth.signInWithCredential(credential);
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
