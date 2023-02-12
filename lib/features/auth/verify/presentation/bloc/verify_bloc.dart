import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'verify_event.dart';
part 'verify_state.dart';

class VerifyBloc extends Bloc<VerifyEvent, VerifyState> {
  final auth = FirebaseAuth.instance;
  final database = FirebaseFirestore.instance;

  VerifyBloc() : super(VerifyInitial()) {
    on<VerifyTapEvent>((event, emit) async {
      emit(VerifyLoadingState());
      try {
        PhoneAuthCredential credential = PhoneAuthProvider.credential(
            verificationId: event.verificationId, smsCode: event.otp);
        await auth.signInWithCredential(credential);
        emit(VerifySuccessState("Successfully Verified"));
        final prefs = await SharedPreferences.getInstance();

        await prefs.setBool('authenticated', true);

        await database
            .collection('Users')
            .doc(auth.currentUser!.phoneNumber)
            .set({
          "phone": auth.currentUser!.phoneNumber,
          "uid": auth.currentUser!.uid,
          "agoraRtcToken": "",
          "agoraCalling": false
        });

        await database
            .collection("Users")
            .doc(auth.currentUser!.phoneNumber)
            .collection("caller_details")
            .doc('details')
            .set({"callerNumber": "", "callerName": ""});
      } catch (e) {
        emit(VerifyFailState('Could not verify the OTP'));
      }
    });
  }
}
