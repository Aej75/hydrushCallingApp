part of 'rtc_bloc.dart';

@immutable
abstract class RtcState {}

class RtcInitial extends RtcState {}

class RtcGetLoadingState extends RtcState {}

class RtcGetFailState extends RtcState {
  final String message;

  RtcGetFailState({required this.message});
}

class RtcGetSuccessState extends RtcState {
  final String message;

  RtcGetSuccessState({required this.message});
}
