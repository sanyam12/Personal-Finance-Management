import 'package:personal_finance/features/manage_finance/domain/entities/credentials.dart';

abstract class LoginRepository{
  Future<String> login(CredentialsEntity credentialsEntity);
  Future<String> signup(CredentialsEntity credentialsEntity);
}