import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ContactMain extends StatelessWidget {
  final String name;
  final String? phoneNumber;
  final ImageProvider<Object>? image;
  ContactMain({super.key, required this.name, this.image, this.phoneNumber});
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<bool> doesDocumentExist(String documentId) async {
    var updated = documentId.replaceAll(RegExp(r'[+-\s\(\)]'), "");
    print("+$updated");
    DocumentSnapshot snapshot =
        await _firestore.collection("Users").doc('+$updated').get();
    return snapshot.exists;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
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
                  bool documentExists = await doesDocumentExist(phoneNumber!);

                  if (documentExists) {
                    EasyLoading.showSuccess('You can make a call');
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
    );
  }
}
