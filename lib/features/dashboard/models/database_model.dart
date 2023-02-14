import 'package:cloud_firestore/cloud_firestore.dart';

class FireDatabase {
  final bool agoraCalling;
  final String agoraRtcToken;
  final String phone;
  final String uid;

  FireDatabase(
      {required this.agoraCalling,
      required this.agoraRtcToken,
      required this.phone,
      required this.uid});

  factory FireDatabase.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();
    return FireDatabase(
      agoraCalling: data?['agoraCalling'],
      agoraRtcToken: data?['agoraRtcToken'],
      phone: data?['phone'],
      uid: data?['uid'],
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      if (agoraCalling != null) "name": agoraCalling,
      if (agoraRtcToken != null) "state": agoraRtcToken,
      if (phone != null) "country": phone,
      if (uid != null) "capital": uid,
    };
  }
}
