part of 'rtc_bloc.dart';

@immutable
abstract class RtcEvent {}

class RtcTokenGetEvent extends RtcEvent {
  final String uid;

  RtcTokenGetEvent({required this.uid});
}
