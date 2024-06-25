import 'package:donezo/core/resources/data_state.dart';
import 'package:donezo/src/auth/domain/entities/user_entity.dart';

abstract class AuthRepository {
  Future<DataState<UserEntity>> signInWithEmailAndPassword(String email, String password);
  Future<DataState<UserEntity>> signUpWithEmailAndPassword(String email, String password);
  Future<void> signInWithGoogle();
  Future<void> signInWithFacebook();
  Future<void> signOut();
  Future<bool> isSignedIn();
  Future<String> getUserId();
  Future<String> getUserEmail();
  Future<void> sendPasswordResetEmail(String email);
}
