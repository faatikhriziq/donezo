import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'auth_form_event.dart';
part 'auth_form_state.dart';

class AuthFormBloc extends Bloc<AuthFormEvent, AuthFormState> {
  AuthFormBloc() : super(AuthFormInitial()) {
    on<AuthFormSignUpValidateEvent>((event, emit) {
      emit(AuthFormValidateLoading());

      final String email = event.email;
      final String password = event.password;
      final String confirmPassword = event.confirmPassword;

      final bool isEmailValid = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(email);

      final bool isPasswordValid = password.length >= 6;

      final Map<String, List<String>> errors = {
        'email': [],
        'password': [],
        'confirmPassword': [],
      };

      if (email.isEmpty) {
        errors['email']!.add('Email is Required');
      } else if (!isEmailValid) {
        errors['email']!.add('Email is not valid');
      } else if (password.isEmpty) {
        errors['password']!.add('Password is Required');
      } else if (!isPasswordValid) {
        errors['password']!.add('Password must be at least 6 characters long');
      } else if (confirmPassword.isEmpty) {
        errors['confirmPassword']!.add('Confirm Password is Required');
      } else if (confirmPassword != password) {
        errors['confirmPassword']!.add('Password does not match');
      }

      if (errors['email']!.isNotEmpty || errors['password']!.isNotEmpty || errors['confirmPassword']!.isNotEmpty) {
        emit(AuthFormSignUpInvalidValidateState(message: errors));
      } else {
        emit(AuthFormSignUpValidValidateState());
      }
    });

    on<AuthFormSignInValidateEvent>((event, emit) {
      emit(AuthFormValidateLoading());

      final String email = event.email;
      final String password = event.password;

      final bool isEmailValid = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(email);

      final Map<String, List<String>> errors = {
        'email': [],
        'password': [],
      };

      if (email.isEmpty) {
        errors['email']!.add('Email is Required');
      } else if (!isEmailValid) {
        errors['email']!.add('Email is not valid');
      } else if (password.isEmpty) {
        errors['password']!.add('Password is Required');
      }

      if (errors['email']!.isNotEmpty || errors['password']!.isNotEmpty) {
        emit(AuthFormSignInInvalidValidateState(message: errors));
      } else {
        emit(AuthFormSignInValidValidateState());
      }
    });

    on<AuthFormResetStateEvent>((event, emit) {
      emit(AuthFormInitial());
    });
  }
}
