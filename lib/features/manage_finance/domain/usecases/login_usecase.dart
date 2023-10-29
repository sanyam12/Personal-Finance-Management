import 'dart:developer';

import 'package:personal_finance/features/manage_finance/domain/entities/credentials.dart';
import 'package:personal_finance/features/manage_finance/domain/repository/login_repository.dart';

import '../../../../core/usecase/usecase.dart';

class LoginUseCase implements UseCase<String, CredentialsEntity?, void>{
  final LoginRepository _loginRepository;

  const LoginUseCase(this._loginRepository);

  @override
  Future<String> call({CredentialsEntity? params1, void params2}) async {
    String response = await _loginRepository.login(params1!);
    return response;
  }

}