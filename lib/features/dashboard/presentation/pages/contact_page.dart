import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import '../widgets/contact_main.dart';
import 'bloc/contact_bloc/contacts_bloc.dart';

class ContactPage extends StatefulWidget {
  const ContactPage({super.key});

  @override
  State<ContactPage> createState() => _ContactPageState();
}

class _ContactPageState extends State<ContactPage> {
  ContactsBloc contactsBloc = ContactsBloc();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => contactsBloc..add(GetContactEvent()),
      child: BlocBuilder<ContactsBloc, ContactsState>(
        builder: (context, state) {
          if (state is GetContactState) {
            EasyLoading.show();
          } else if (state is GetContactFailState) {
            EasyLoading.dismiss();
            return Text(state.message);
          } else if (state is GetContactSuccessState) {
            EasyLoading.dismiss();
            var response = state.contacts;
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: response
                    .map(
                      (e) => e.photo == null
                          ? ContactMain(
                              phoneNumber: e.phones
                                  .map((phone) => phone.normalizedNumber)
                                  .toString(),
                              name: e.displayName,
                            )
                          : ContactMain(
                              phoneNumber: e.phones
                                  .map((phone) => phone.normalizedNumber)
                                  .toString(),
                              name: e.displayName,
                              image: MemoryImage(e.photoOrThumbnail!),
                            ),
                    )
                    .toList(),
              ),
            );
          }

          return const SizedBox();
        },
      ),
    );
  }
}
