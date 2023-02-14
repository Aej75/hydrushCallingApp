import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:whatsapp/core/route/routes.gr.dart';
import 'package:whatsapp/features/dashboard/presentation/pages/bloc/listen_bloc/listen_bloc.dart';
import 'package:whatsapp/features/dashboard/presentation/pages/bloc/rtcToken_bloc/bloc/rtc_bloc.dart';

class ContactMain extends StatelessWidget {
  final String name;
  final String? phoneNumber;
  final ImageProvider<Object>? image;
  ContactMain({super.key, required this.name, this.image, this.phoneNumber});
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  var auth = FirebaseAuth.instance;

  var updated;

  RtcBloc rtcBloc = RtcBloc();
  ListenBloc listenBloc = ListenBloc();

  Future<bool> doesDocumentExist(String documentId) async {
    updated = "+${documentId.replaceAll(RegExp(r'[+-\s\(\)]'), "")}";
    print(updated);
    DocumentSnapshot snapshot =
        await _firestore.collection("Users").doc(updated).get();
    return snapshot.exists;
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => rtcBloc,
      child: BlocListener<RtcBloc, RtcState>(
        listener: (context, state) async {
          if (state is RtcGetLoadingState) {
            EasyLoading.show();
          } else if (state is RtcGetFailState) {
            EasyLoading.dismiss();
            EasyLoading.showError(state.message);
          } else if (state is RtcGetSuccessState) {
            EasyLoading.dismiss();
            EasyLoading.showSuccess(state.message);

            if (!await Permission.camera.status.isGranted ||
                !await Permission.microphone.status.isGranted) {
              await Permission.camera.request();
              await Permission.microphone.request();
              if (await Permission.camera.status.isGranted &&
                  await Permission.microphone.status.isGranted) {
                context.router.push(CallPageRoute(token: state.message));
              }
            } else {
              context.router.push(CallPageRoute(token: state.message));
            }
          }
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 7),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  image == null
                      ? CircleAvatar(
                          radius: 25,
                          backgroundColor: Theme.of(context).cardColor,
                          child: const Icon(Icons.person),
                        )
                      : CircleAvatar(radius: 25, backgroundImage: image),
                  const SizedBox(
                    width: 20,
                  ),
                  Text(name),
                ],
              ),
              IconButton(
                  onPressed: () async {
                    var prefs = await SharedPreferences.getInstance();

                    final bool? authenticated = prefs.getBool('authenticated');
                    if (authenticated!) {
                      bool documentExists =
                          await doesDocumentExist(phoneNumber!);

                      if (documentExists) {
                        EasyLoading.showSuccess('You can make a call');

                        print('Updated = $updated');

                        rtcBloc.add(RtcTokenGetEvent(uid: updated));
                      } else {
                        EasyLoading.showError('User not registered in Hydrush');
                      }
                    } else {
                      EasyLoading.showInfo("User not authenticated");
                    }
                  },
                  icon: const Icon(Icons.call))
            ],
          ),
        ),
      ),
    );
  }
}
