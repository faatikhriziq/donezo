import 'package:donezo/core/resources/data_state.dart';
import 'package:donezo/core/resources/params.dart';
import 'package:donezo/core/usecase/usecase.dart';
import 'package:donezo/src/auth/domain/entities/user_entity.dart';

import '../repositories/auth_repository.dart';

class SignInWithEmailPasswordUseCase implements UseCase<DataState<UserEntity>, SignInParams>{
  final AuthRepository _authRepository;

  SignInWithEmailPasswordUseCase(this._authRepository);
  
  @override
  Future<DataState<UserEntity>> call(SignInParams params) async {
    return _authRepository.signInWithEmailAndPassword(params.email, params.password);
  }
}
