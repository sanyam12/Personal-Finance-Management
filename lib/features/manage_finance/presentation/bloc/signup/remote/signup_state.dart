part of 'signup_bloc.dart';

@immutable
abstract class SignupState extends Equatable{}

class SignupInitial extends SignupState {
  @override
  List<Object?> get props => [];
}

class SignupSuccess extends SignupState{
  final String message;
  SignupSuccess(this.message);

  @override
  List<Object?> get props => [message];
}

class SignupFailed extends SignupState{
  final String message;
  SignupFailed(this.message);

  @override
  List<Object?> get props => [message];

}
