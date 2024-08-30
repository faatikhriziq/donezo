import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:donezo/core/resources/data_state.dart';
import 'package:donezo/core/shared/local_storage/auth_local_storage.dart';
import 'package:donezo/src/auth/data/datasources/auth_firebase_datasource.dart';
import 'package:donezo/src/auth/domain/entities/auth_credential_entity.dart';
import 'package:donezo/src/auth/domain/entities/user_entity.dart';
import 'package:donezo/src/auth/domain/repositories/auth_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthRepositoriesImpl implements AuthRepository {
  final FirebaseAuth firebaseAuth;
  final FirebaseFirestore firebaseFirestore;
  final AuthFirebaseDatasource authFirebaseDatasource;

  AuthRepositoriesImpl(this.firebaseAuth, this.authFirebaseDatasource, this.firebaseFirestore);

  @override
  Future<DataState<UserEntity>> signUpWithEmailAndPassword(String email, String password) async {
    try {
      final response = await authFirebaseDatasource.signUpWithEmailAndPassword(email, password);
      if (response.user != null) {
        final userEntity = UserEntity.fromFirebaseUser(response.user!);
        await firebaseFirestore.collection('users').doc(userEntity.id).set({
          'id': response.user!.uid,
          'email': response.user!.email,
          'name': response.user?.displayName ?? 'user_${response.user!.uid}',
          'photoUrl': response.user?.photoURL ?? '',
          'createdAt': FieldValue.serverTimestamp(),
        });

        return DataState.success(userEntity);
      } else {
        return DataState.error('Error while creating user. Please try again.');
      }
    } on FirebaseAuthException catch (e) {
      log(e.toString());
      String errorMessage;
      switch (e.code) {
        case 'email-already-in-use':
          errorMessage = e.message!;
          break;
        case 'invalid-email':
          errorMessage = e.message!;
          break;
        case 'operation-not-allowed':
          errorMessage = e.message!;
          break;
        case 'weak-password':
          errorMessage = e.message!;
          break;
        default:
          errorMessage = e.message!;
      }
      return DataState.error(errorMessage);
    } catch (e) {
      log(e.toString());
      return DataState.error(e.toString());
    }
  }

  @override
  Future<DataState<UserEntity>> signInWithEmailAndPassword(String email, String password) async {
    try {
      final response = await authFirebaseDatasource.signInWithEmailAndPassword(email, password);
      if (response.user != null) {
        final userEntity = UserEntity.fromFirebaseUser(response.user!);
        log('User: ${userEntity.id}');
        await saveUserId(userEntity.id);
        return DataState.success(userEntity);
      } else {
        return DataState.error("Error while signing in. Please try again.");
      }
    } on FirebaseAuthException catch (e) {
      String errorMessage;
      switch (e.code) {
        case 'invalid-email':
          errorMessage = e.message!;
          break;
        case 'user-disabled':
          errorMessage = e.message!;
          break;
        case 'user-not-found':
          errorMessage = e.message!;
          break;
        case 'wrong-password':
          errorMessage = e.message!;
          break;
        case 'invalid-credential':
          errorMessage = "Email or password is incorrect. Please try again.";
          break;
        default:
          errorMessage = e.message!;
      }
      return DataState.error(errorMessage);
    } catch (e) {
      log(e.toString());
      return DataState.error(e.toString());
    }
  }

  @override
  Future<DataState<AuthCredentialEntity>> signInWithGoogle() async {
    try {
      final response = await authFirebaseDatasource.signInWithGoogle();
      if (response.user != null) {
        final useCredential = AuthCredentialEntity.fromAtuhCredential(response.credential!);
        final userData = UserEntity.fromUserInfo(response.user!.providerData);

        await saveUserId(response.user!.uid);
        if (response.additionalUserInfo!.isNewUser) {
          log('isNewUser: ${response.additionalUserInfo!.isNewUser}');
          await firebaseFirestore.collection('users').doc(response.user!.uid).set({
            'id': response.user!.uid,
            'email': userData.email,
            'name': userData.name,
            'photoUrl': userData.photoUrl,
            'createdAt': FieldValue.serverTimestamp(),
          });
        }
        return DataState.success(useCredential);
      } else {
        return DataState.error("Error while signing in with Google. Please try again.");
      }
    } on FirebaseAuthException catch (e) {
      log(e.toString());
      String errorMessage;
      switch (e.code) {
        case 'google_sign_in_failed':
          errorMessage = e.message!;
          break;
        default:
          log(e.toString());
          errorMessage = e.message!;
      }
      return DataState.error(errorMessage);
    } catch (e) {
      log(e.toString());
      return DataState.error(e.toString());
    }
  }

  @override
  Future<String> getUserEmail() {
    // TODO: implement getUserEmail
    throw UnimplementedError();
  }

  @override
  Future<String> getUserId() {
    // TODO: implement getUserId
    throw UnimplementedError();
  }

  @override
  Future<bool> isSignedIn() {
    // TODO: implement isSignedIn
    throw UnimplementedError();
  }

  @override
  Future<void> sendPasswordResetEmail(String email) {
    // TODO: implement sendPasswordResetEmail
    throw UnimplementedError();
  }

  @override
  Future<void> signInWithFacebook() {
    // TODO: implement signInWithFacebook
    throw UnimplementedError();
  }

  @override
  Future<void> signOut() {
    // TODO: implement signOut
    throw UnimplementedError();
  }
}
