import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthCredentialEntity extends Equatable {
  final String? accessToken;
  final int? idToken;

  const AuthCredentialEntity({required this.accessToken, required this.idToken});


  factory AuthCredentialEntity.fromAtuhCredential(AuthCredential authCredential) {
    return AuthCredentialEntity(
      accessToken: authCredential.accessToken,
      idToken: authCredential.token,
    );
  }
  
  @override
  
  List<Object?> get props => [accessToken, idToken];

}