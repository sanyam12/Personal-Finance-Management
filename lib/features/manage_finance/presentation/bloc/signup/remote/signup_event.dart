part of 'signup_bloc.dart';

@immutable
abstract class SignupEvent {}

class AttemptSignup extends SignupEvent{
  final String email;
  final String password;

  AttemptSignup(this.email, this.password);
}
