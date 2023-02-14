part of 'rtc_crud_bloc.dart';

@immutable
abstract class RtcCrudEvent {}

class RtcCrudUpdateEvent extends RtcCrudEvent {}

class RtcCrudDeleteEvent extends RtcCrudEvent {}
