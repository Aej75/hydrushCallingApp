import 'package:bloc/bloc.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:meta/meta.dart';
import 'package:permission_handler/permission_handler.dart';

part 'contacts_event.dart';
part 'contacts_state.dart';

class ContactsBloc extends Bloc<ContactsEvent, ContactsState> {
  ContactsBloc() : super(ContactsInitial()) {
    on<GetContactEvent>((event, emit) async {
      emit(GetContactState());
      if (!await Permission.contacts.isGranted) {
        await Permission.contacts.request();
        if (await Permission.contacts.isGranted) {
          List<Contact> contacts = await FlutterContacts.getContacts(
              withProperties: true, withPhoto: true);

          emit(GetContactSuccessState(contacts));
        } else {
          emit(GetContactFailState('Access Denied'));
        }
      } else {
        List<Contact> contacts = await FlutterContacts.getContacts(
            withProperties: true, withPhoto: true);
        print(contacts);
        emit(GetContactSuccessState(contacts));
      }
    });
  }
}
