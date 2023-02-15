part of 'rtc_crud_bloc.dart';

@immutable
abstract class RtcCrudState {}

class RtcCrudInitial extends RtcCrudState {}

class RtcCrudUpdateLoadingState extends RtcCrudState {}

class RtcCrudUpdateFailState extends RtcCrudState {
  final String message;

  RtcCrudUpdateFailState(this.message);
}

class RtcCrudUpdateSuccessState extends RtcCrudState {
  final String rtcToken;
  final String friendPhone;

  RtcCrudUpdateSuccessState(this.rtcToken, this.friendPhone);
}

class RtcCrudDeleteLoadingState extends RtcCrudState {}

class RtcCrudDeleteFailState extends RtcCrudState {}

class RtcCrudDeleteSuccessState extends RtcCrudState {}
