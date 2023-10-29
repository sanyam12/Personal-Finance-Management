import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../../../../domain/entities/credentials.dart';
import '../../../../domain/usecases/signup_usecase.dart';

part 'signup_event.dart';

part 'signup_state.dart';

class SignupBloc extends Bloc<SignupEvent, SignupState> {
  final SignupUseCase _signupUseCase;

  SignupBloc(this._signupUseCase) : super(SignupInitial()) {
    on<SignupEvent>((event, emit) async {
      if (event is AttemptSignup) {
        try {
          String response = await _signupUseCase.call(
              params1: CredentialsEntity(
                  mail: event.email, password: event.password));
          if (response == "") {
            emit(SignupSuccess("Logged In Successfully"));
          } else {
            emit(SignupFailed(response));
          }
        } catch (e) {
          emit(SignupFailed(e.toString()));
        }
      }
    });
  }
}
