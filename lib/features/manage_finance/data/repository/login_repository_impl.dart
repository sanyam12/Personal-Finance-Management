
import 'dart:developer';

import 'package:personal_finance/features/manage_finance/data/data_sources/remote/login_service.dart';
import 'package:personal_finance/features/manage_finance/domain/entities/credentials.dart';
import 'package:personal_finance/features/manage_finance/domain/repository/login_repository.dart';

class LoginRepositoryImpl implements LoginRepository{
  final LoginService _loginService;
  LoginRepositoryImpl(this._loginService);
  @override
  Future<String> login(CredentialsEntity credentialsEntity)async {
    String response = await _loginService.login(credentialsEntity);
    return response;
  }

  @override
  Future<String> signup(CredentialsEntity credentialsEntity)async {
    String response = await _loginService.signup(credentialsEntity);
    return response;
  }

}