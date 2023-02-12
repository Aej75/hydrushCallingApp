part of 'contacts_bloc.dart';

@immutable
abstract class ContactsState {}

class ContactsInitial extends ContactsState {}

class GetContactState extends ContactsState {}

class GetContactFailState extends ContactsState {
  final String message;

  GetContactFailState(this.message);
}

class GetContactSuccessState extends ContactsState {
  final List<Contact> contacts;
  GetContactSuccessState(this.contacts);
}
