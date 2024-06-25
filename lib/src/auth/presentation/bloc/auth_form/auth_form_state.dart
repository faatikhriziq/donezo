part of 'auth_form_bloc.dart';

sealed class AuthFormState extends Equatable {
  const AuthFormState();

  @override
  List<Object> get props => [];
}

final class AuthFormInitial extends AuthFormState {}

final class AuthFormValidateLoading extends AuthFormState {}

final class AuthFormSignUpInvalidValidateState extends AuthFormState {
  final Map<String, List<String>> message;

  const AuthFormSignUpInvalidValidateState({this.message = const {}});

  @override
  List<Object> get props => [
        message
      ];
}

final class AuthFormSignInInvalidValidateState extends AuthFormState {
  final Map<String, List<String>> message;

  const AuthFormSignInInvalidValidateState({this.message = const {}});

  @override
  List<Object> get props => [
        message
      ];
}

final class AuthFormSignInValidValidateState extends AuthFormState {}

final class AuthFormSignUpValidValidateState extends AuthFormState {}
