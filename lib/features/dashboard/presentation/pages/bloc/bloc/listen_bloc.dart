import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';

part 'listen_event.dart';
part 'listen_state.dart';

class ListenBloc extends Bloc<ListenEvent, ListenState> {
  final CollectionReference userCollection =
      FirebaseFirestore.instance.collection("Users");
  ListenBloc() : super(ListenInitial()) {
    on<ListenDataEvent>((event, emit) {
      Stream<QuerySnapshot<Map<String, dynamic>>> notificationStream;
      StreamSubscription<QuerySnapshot<Map<String, dynamic>>>? subscription;
      if (event.listen) {
        notificationStream =
            FirebaseFirestore.instance.collection("Users").snapshots();
        subscription = notificationStream.listen((event) {
          if (event.docs.isEmpty) {
            return;
          } else {
            add(OnChangeEvent(event.docs.first.get('agoraCalling').toString()));
          }
        });
      }

      if (event.listen == false) {
        subscription?.cancel();
      }
    });

    on<OnChangeEvent>((event, emit) {
      emit(ListenDataLiveState(event.message));
    });
  }
}
