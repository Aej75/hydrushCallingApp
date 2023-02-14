part of 'listen_bloc.dart';

@immutable
abstract class ListenEvent {}

class ListenDataEvent extends ListenEvent {
  final bool listen;

  ListenDataEvent({required this.listen});
}

class OnChangeEvent extends ListenEvent {
  final String callerId;

  OnChangeEvent(this.callerId);
}
