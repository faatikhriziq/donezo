import 'package:donezo/core/resources/data_state.dart';
import 'package:donezo/src/auth/domain/entities/user_entity.dart';
import 'package:donezo/src/auth/domain/usecases/sign_in_with_email_password_use_case.dart';
import 'package:donezo/src/auth/domain/usecases/sign_in_with_google_use_case.dart';
import 'package:donezo/src/auth/domain/usecases/sign_up_use_case.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/resources/params.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final SignUpUseCase signUpUseCase;
  final SignInWithEmailPasswordUseCase signInWithEmailPasswordUseCase;
  final SignInWithGoogleUseCase signInWithGoogleUseCase;
  final SignUpParams signUpParams;
  final SignInParams signInParams;
  final NoParams noParams;
  AuthBloc({required this.noParams, required this.signInWithGoogleUseCase, required this.signInParams, required this.signInWithEmailPasswordUseCase, required this.signUpUseCase, required this.signUpParams}) : super(AuthInitial()) {
    on<AuthSignUpEvent>((event, emit) async {
      emit(AuthLoading());
      final result = await signUpUseCase.call(signUpParams);
      if (result is DataStateSuccess) {
        emit(AuthSignUpSuccess(user: result.data!));
      } else if (result is DataStateError) {
        emit(AuthSignUpFailure(error: result.error!));
      }
    });

    on<AuthSignInEvent>((event, emit) async {
      emit(AuthLoading());
      final result = await signInWithEmailPasswordUseCase.call(signInParams);
      if (result is DataStateSuccess) {
        emit(AuthSignInSuccess(user: result.data!));
      } else if (result is DataStateError) {
        emit(AuthSignInFailure(error: result.error!));
      }
    });

    on<AuthSignInWithGoogleEvent>((event, emit) async {
      emit(AuthLoading());
      final result = await signInWithGoogleUseCase.call(noParams);
      if (result is DataStateSuccess) {
        emit(AuthSignInWithGoogleSuccess());
      } else if (result is DataStateError) {
        emit(AuthSignInWithGoogleFailure(error: result.error!));
      }
    });
  }
}
