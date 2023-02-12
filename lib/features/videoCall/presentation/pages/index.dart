// import 'dart:async';
// import 'dart:developer';

// import 'package:agora_rtc_engine/rtc_engine.dart';
// import 'package:flutter/material.dart';
// import 'package:permission_handler/permission_handler.dart';

// import './callPage.dart';

// class IndexPage extends StatefulWidget {
//   const IndexPage({super.key});

//   @override
//   State<IndexPage> createState() => _IndexPageState();
// }

// class _IndexPageState extends State<IndexPage> {
//   final _channelController = TextEditingController();
//   bool _validateError = false;
//   ClientRole? _role = ClientRole.Broadcaster;

//   @override
//   void dispose() {
//     // TODO: implement dispose
//     _channelController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SingleChildScrollView(
//         child: Container(
//           child: Column(
//             children: [
//               const SizedBox(
//                 height: 40,
//               ),
//               SizedBox(
//                 height: 500,
//                 child: Image.network(
//                     'https://th.bing.com/th/id/OIP.DvKic9NKqCyOwHxwaqzi9QHaQE?pid=ImgDet&rs=1'),
//               ),
//               const SizedBox(
//                 height: 20,
//               ),
//               TextField(
//                 controller: _channelController,
//                 decoration: InputDecoration(
//                     errorText:
//                         _validateError ? 'Channel name is mandatory' : null,
//                     border: const UnderlineInputBorder(
//                       borderSide: BorderSide(width: 1),
//                     ),
//                     hintText: 'Channel name'),
//               ),
//               RadioListTile(
//                   title: const Text('Broadcaster'),
//                   value: ClientRole.Broadcaster,
//                   groupValue: _role,
//                   onChanged: (ClientRole? value) {
//                     setState(() {
//                       _role = value;
//                     });
//                   }),
//               RadioListTile(
//                   title: const Text('Audience'),
//                   value: ClientRole.Audience,
//                   groupValue: _role,
//                   onChanged: (ClientRole? value) {
//                     setState(() {
//                       _role = value;
//                     });
//                   }),
//               ElevatedButton(onPressed: onJoin, child: const Text('Join'))
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Future<void> onJoin() async {
//     setState(() {
//       _channelController.text.isEmpty
//           ? _validateError = true
//           : _validateError = false;
//     });
//     if (_channelController.text.isNotEmpty) {
//       await _handleCameraAndMic(Permission.camera);
//       await _handleCameraAndMic(Permission.microphone);

//       // ignore: use_build_context_synchronously
//       await Navigator.push(
//           context,
//           MaterialPageRoute(
//               builder: (context) => CallPage(
//                     channelName: _channelController.text,
//                     role: _role,
//                   )));
//     }
//   }

//   Future<void> _handleCameraAndMic(Permission permission) async {
//     final status = await permission.request();
//     log(status.toString());
//   }
// }
