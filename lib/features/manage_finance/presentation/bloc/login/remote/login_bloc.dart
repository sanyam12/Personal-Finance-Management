import 'dart:async';
import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

import '../../../../domain/entities/credentials.dart';
import '../../../../domain/usecases/login_usecase.dart';

part 'login_event.dart';

part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final LoginUseCase _loginUseCase;

  LoginBloc(
    this._loginUseCase,
  ) : super(LoginInitial()) {
    on<LoginEvent>((event, emit) async{
      if (event is AttemptLogin) {
        // log("Check for login event");
        try {
          String response = await _loginUseCase.call(
            params1: CredentialsEntity(
              mail: event.email,
              password: event.password,
            ),
          );
          if(response.isEmpty){
            emit(LoginSuccess("Logged in Successfully"));
          }else if(response=="INVALID_LOGIN_CREDENTIALS"){
            emit(LoginFailed(response));
          }
        } catch (e) {
          emit(LoginFailed(e.toString()));
        }
      }
    });
  }
}
