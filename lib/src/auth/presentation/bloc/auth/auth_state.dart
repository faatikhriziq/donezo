part of 'auth_bloc.dart';

abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => [];
}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class AuthSignUpSuccess extends AuthState {
  final UserEntity user;
  const AuthSignUpSuccess({required this.user});

  @override
  List<Object> get props => [
        user
      ];
}

class AuthSignUpFailure extends AuthState {
  final String? error;

  const AuthSignUpFailure({required this.error});

  @override
  List<Object> get props => [
        error!
      ];
}

class AuthSignInSuccess extends AuthState {
  final UserEntity user;
  const AuthSignInSuccess({required this.user});

  @override
  List<Object> get props => [
        user
      ];
}

class AuthSignInFailure extends AuthState {
  final String? error;

  const AuthSignInFailure({required this.error});

  @override
  List<Object> get props => [
        error!
      ];
}

class AuthSignInWithGoogleSuccess extends AuthState {}

class AuthSignInWithGoogleFailure extends AuthState {
  final String? error;

  const AuthSignInWithGoogleFailure({required this.error});

  @override
  List<Object> get props => [
        error!
      ];
}
