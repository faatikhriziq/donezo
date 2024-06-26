part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

class AuthSignUpEvent extends AuthEvent {
  final SignUpParams signUpParams;

  const AuthSignUpEvent({required this.signUpParams});

  @override
  List<Object> get props => [
        signUpParams
      ];
}

class AuthSignInEvent extends AuthEvent {
  final SignInParams signInParams;

  const AuthSignInEvent({required this.signInParams});

  @override
  List<Object> get props => [
        signInParams
      ];
}

class AuthSignInWithGoogleEvent extends AuthEvent {
  const AuthSignInWithGoogleEvent();
}
