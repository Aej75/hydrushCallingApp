part of 'sign_up_bloc.dart';

@immutable
abstract class SignUpEvent {}

class SignUpButtonTapEvent extends SignUpEvent {
  final String number;

  SignUpButtonTapEvent(this.number);
}

class CodeSentEvent extends SignUpEvent {
  final String verificationId;

  CodeSentEvent(this.verificationId);
}

class SignUpErrorEvent extends SignUpEvent {
  final String error;

  SignUpErrorEvent(this.error);
}
