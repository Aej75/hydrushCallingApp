part of 'verify_bloc.dart';

@immutable
abstract class VerifyState {}

class VerifyInitial extends VerifyState {}

class VerifyLoadingState extends VerifyState {}

class VerifyFailState extends VerifyState {
  final String message;

  VerifyFailState(this.message);
}

class VerifySuccessState extends VerifyState {
  final String message;

  VerifySuccessState(this.message);
}
