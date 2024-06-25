import 'package:donezo/core/resources/data_state.dart';
import 'package:donezo/core/resources/params.dart';
import 'package:donezo/core/usecase/usecase.dart';
import 'package:donezo/src/auth/domain/entities/user_entity.dart';

import '../repositories/auth_repository.dart';

class SignUpUseCase implements UseCase<DataState<UserEntity>, SignUpParams> {
  final AuthRepository authRepository;

  SignUpUseCase(this.authRepository);

  @override
  Future<DataState<UserEntity>> call(SignUpParams params) async {
    return await authRepository.signUpWithEmailAndPassword(params.email, params.password);
  }
}
