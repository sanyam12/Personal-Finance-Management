part of 'login_bloc.dart';

@immutable
abstract class LoginState extends Equatable{}

class LoginInitial extends LoginState {
  @override
  List<Object?> get props => [];
}

class LoginSuccess extends LoginState{
  final String message;
  LoginSuccess(this.message);

  @override
  List<Object?> get props => [message];
}

class LoginFailed extends LoginState{
  final String message;
  LoginFailed(this.message);

  @override
  List<Object?> get props => [message];

}
