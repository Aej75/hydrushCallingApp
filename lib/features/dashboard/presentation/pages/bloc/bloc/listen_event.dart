part of 'listen_bloc.dart';

@immutable
abstract class ListenEvent {}

class ListenDataEvent extends ListenEvent {
  final bool listen;

  ListenDataEvent({this.listen = true});
}

class OnChangeEvent extends ListenEvent {
  final String message;

  OnChangeEvent(this.message);
}
