part of 'verify_bloc.dart';

@immutable
abstract class VerifyEvent {}

class VerifyTapEvent extends VerifyEvent {
  final String verificationId;
  final String otp;

  VerifyTapEvent({required this.verificationId, required this.otp});
}
