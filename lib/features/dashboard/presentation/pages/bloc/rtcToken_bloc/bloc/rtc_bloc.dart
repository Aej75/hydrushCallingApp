import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';
import 'package:whatsapp/features/dashboard/models/rtc_response_model.dart';

part 'rtc_event.dart';
part 'rtc_state.dart';

class RtcBloc extends Bloc<RtcEvent, RtcState> {
  Dio dio = Dio();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  var auth = FirebaseAuth.instance;

  requestRtcToken(
      {required String channelID,
      required String role,
      required String tokenType,
      required String uid}) async {
    var response = await dio.get(
        "https://agora-token-server-y13x.onrender.com/rtc/$channelID/$role/$tokenType/$uid");

    print(response);

    if (response.statusCode == 200) {
      return response.data;
    }
    return null;
  }

  RtcBloc() : super(RtcInitial()) {
    on<RtcTokenGetEvent>((event, emit) async {
      emit(RtcGetLoadingState());

      try {
        var response = await requestRtcToken(
            channelID: 'videoCall',
            role: 'audience',
            tokenType: 'uid',
            uid: "0");

        var data = RtcTokenModel.fromJson(response);

        print(data.rtcToken);

        try {
          await _firestore
              .collection('Users')
              .doc(event.uid)
              .update({"agoraRtcToken": data.rtcToken, "agoraCalling": true});
          await _firestore
              .collection('Users')
              .doc(event.uid)
              .collection('caller_details')
              .doc('details')
              .set({"callerName": auth.currentUser!.phoneNumber});
          emit(RtcGetSuccessState(message: data.rtcToken));
        } catch (e) {
          emit(RtcGetFailState(message: e.toString()));
        }
      } catch (e) {
        emit(RtcGetFailState(message: e.toString()));
      }
    });
  }
}
