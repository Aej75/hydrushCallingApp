part of 'listen_bloc.dart';

@immutable
abstract class ListenState {}

class ListenInitial extends ListenState {}

class ListenDataLiveState extends ListenState {
  final String message;

  ListenDataLiveState(this.message);
}
