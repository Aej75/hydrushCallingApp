part of 'sign_up_bloc.dart';

@immutable
abstract class SignUpState {}

class SignUpInitial extends SignUpState {}

class SignUpLoadingState extends SignUpState {}

class SignUpFailState extends SignUpState {
  final String message;
  SignUpFailState(this.message);
}

class SignUpSuccessState extends SignUpState {
  final String verificationId;
  SignUpSuccessState(this.verificationId);
}
