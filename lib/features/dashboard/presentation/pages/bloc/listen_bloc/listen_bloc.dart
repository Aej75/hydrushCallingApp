import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';

import '../../../../models/database_model.dart';

part 'listen_event.dart';
part 'listen_state.dart';

class ListenBloc extends Bloc<ListenEvent, ListenState> {
  final CollectionReference userCollection =
      FirebaseFirestore.instance.collection("Users");

  var documentReference = FirebaseFirestore.instance
      .collection('Users')
      .doc(FirebaseAuth.instance.currentUser!.phoneNumber)
      .collection('caller_details')
      .doc('details')
      .withConverter(
        fromFirestore: FireDatabase.fromFirestore,
        toFirestore: (FireDatabase database, _) => database.toFirestore(),
      );
  ListenBloc() : super(ListenInitial()) {
    on<ListenDataEvent>((event, emit) {
      Stream<QuerySnapshot<Map<String, dynamic>>> notificationStream;
      StreamSubscription<QuerySnapshot<Map<String, dynamic>>>? subscription;
      if (event.listen) {
        notificationStream = FirebaseFirestore.instance
            .collection("Users")
            .where('phone',
                isEqualTo: FirebaseAuth.instance.currentUser!.phoneNumber)
            .limit(1)
            .snapshots();
        subscription = notificationStream.listen((event) async {
          if (event.docs.isEmpty) {
            return;
          } else {
            if (event.docs.first.get('agoraCalling') == true) {
              final docSnap = await documentReference.get();
              var callerId = docSnap.data();

              add(OnChangeEvent(callerId!.callerName!));
            }
          }
        });
      }

      if (!event.listen) {
        subscription?.cancel();
      }
    });

    on<OnChangeEvent>((event, emit) async {
      emit(ListenDataLiveState(event.callerId));
    });
  }
}
