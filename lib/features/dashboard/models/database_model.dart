import 'package:cloud_firestore/cloud_firestore.dart';

class FireDatabase {
  final bool? agoraCalling;
  final String? agoraRtcToken;
  final String? phone;
  final String? uid;
  final String? callerName;

  FireDatabase(
      {this.agoraCalling,
      this.agoraRtcToken,
      this.phone,
      this.uid,
      this.callerName});

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
      callerName: data?['callerName'],
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      if (agoraCalling != null) "agoraCalling": agoraCalling,
      if (agoraRtcToken != null) "agoraRtcToken": agoraRtcToken,
      if (phone != null) "phone": phone,
      if (uid != null) "uid": uid,
      if (callerName != null) "callerName": callerName,
    };
  }
}
