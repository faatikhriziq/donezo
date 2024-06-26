import 'package:donezo/core/resources/data_state.dart';
import 'package:donezo/core/resources/params.dart';
import 'package:donezo/core/usecase/usecase.dart';
import 'package:donezo/src/auth/domain/entities/auth_credential_entity.dart';

import '../repositories/auth_repository.dart';

class SignInWithGoogleUseCase implements UseCase<DataState<AuthCredentialEntity>, NoParams> {
  final AuthRepository authRepository;

  SignInWithGoogleUseCase(this.authRepository);

  @override
  Future<DataState<AuthCredentialEntity>> call(NoParams params) async {
    return await authRepository.signInWithGoogle();
  }
}
