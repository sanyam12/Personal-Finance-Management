import 'package:personal_finance/features/manage_finance/domain/entities/credentials.dart';
import 'package:personal_finance/features/manage_finance/domain/repository/login_repository.dart';

import '../../../../core/usecase/usecase.dart';

class SignupUseCase implements UseCase<String, CredentialsEntity?, void>{
  final LoginRepository _loginRepository;

  const SignupUseCase(this._loginRepository);

  @override
  Future<String> call({CredentialsEntity? params1, void params2})async {
    return await _loginRepository.signup(params1!);
  }


}