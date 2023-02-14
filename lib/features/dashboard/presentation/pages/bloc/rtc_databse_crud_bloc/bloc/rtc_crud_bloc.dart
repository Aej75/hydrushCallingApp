import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../../../models/database_model.dart';

part 'rtc_crud_event.dart';
part 'rtc_crud_state.dart';

class RtcCrudBloc extends Bloc<RtcCrudEvent, RtcCrudState> {
  var documentReference = FirebaseFirestore.instance
      .collection('Users')
      .doc(FirebaseAuth.instance.currentUser!.phoneNumber)
      .withConverter(
        fromFirestore: FireDatabase.fromFirestore,
        toFirestore: (FireDatabase database, _) => database.toFirestore(),
      );

  RtcCrudBloc() : super(RtcCrudInitial()) {
    on<RtcCrudUpdateEvent>((event, emit) async {
      // TODO: implement event handler

      emit(RtcCrudUpdateLoadingState());

      final docSnap = await documentReference.get();
      final data = docSnap.data(); // Convert to City object
      if (data!.agoraRtcToken != null) {
        print(data.agoraRtcToken);
        if (!await Permission.camera.status.isGranted ||
            !await Permission.microphone.status.isGranted) {
          await Permission.camera.request();
          await Permission.microphone.request();
          if (await Permission.camera.status.isGranted &&
              await Permission.microphone.status.isGranted) {
            emit(RtcCrudUpdateSuccessState(data.agoraRtcToken!));
          }
        } else {
          emit(RtcCrudUpdateSuccessState(data.agoraRtcToken!));
        }
      } else {
        emit(RtcCrudUpdateFailState('No such user'));
      }
    });
    on<RtcCrudDeleteEvent>((event, emit) async {
      try {
        var model = FireDatabase(agoraCalling: false, agoraRtcToken: '');
        final docSnap = await documentReference.update(model.toFirestore());
      } catch (e) {
        print(e);
      }
    });
  }
}
