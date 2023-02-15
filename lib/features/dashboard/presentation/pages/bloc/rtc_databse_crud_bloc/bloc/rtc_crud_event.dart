part of 'rtc_crud_bloc.dart';

@immutable
abstract class RtcCrudEvent {}

class RtcCrudUpdateEvent extends RtcCrudEvent {
  final String friendPhone;

  RtcCrudUpdateEvent({required this.friendPhone});
}

class RtcCrudDeleteEvent extends RtcCrudEvent {}
