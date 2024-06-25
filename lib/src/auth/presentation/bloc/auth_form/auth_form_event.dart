part of 'auth_form_bloc.dart';

sealed class AuthFormEvent extends Equatable {
  const AuthFormEvent();

  @override
  List<Object> get props => [];
}

class AuthFormSignUpValidateEvent extends AuthFormEvent {
  final String email;
  final String password;
  final String confirmPassword;

  const AuthFormSignUpValidateEvent({
    required this.email,
    required this.password,
    required this.confirmPassword,
  });

  @override
  List<Object> get props => [
        email,
        password,
        confirmPassword,
      ];
}

class AuthFormSignInValidateEvent extends AuthFormEvent {
  final String email;
  final String password;

  const AuthFormSignInValidateEvent({
    required this.email,
    required this.password,
  });

  @override
  List<Object> get props => [
        email,
        password,
      ];
}

class AuthFormResetStateEvent extends AuthFormEvent {}
