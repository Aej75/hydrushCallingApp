// import 'package:flutter/material.dart';
// import 'package:permission_handler/permission_handler.dart';

// class VideoCall extends StatefulWidget {
//   const VideoCall({super.key});

//   @override
//   State<VideoCall> createState() => _VideoCallState();
// }

// class _VideoCallState extends State<VideoCall> {
//   final myController = TextEditingController();
//   bool _validateError = false;
//   Future<void> onJoin() async {
//     setState(() {
//       myController.text.isEmpty
//           ? _validateError = true
//           : _validateError = false;
//     });
//     await Permission.microphone.request();
//     await Permission.camera.request();

//     // Navigator.push(
//     //     context,
//     //     MaterialPageRoute(
//     //       builder: (context) => CallPage(channelName: myController.text),
//     //     ));
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       resizeToAvoidBottomInset: false,
//       appBar: AppBar(
//         centerTitle: true,
//         title: const Text('Agora Group Video Call'),
//         elevation: 0,
//       ),
//       body: Container(
//         padding: const EdgeInsets.symmetric(horizontal: 50),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: <Widget>[
//             const Padding(padding: EdgeInsets.only(top: 100)),
//             const Image(
//               image: NetworkImage(
//                   'https://cdn.britannica.com/24/58624-050-73A7BF0B/valley-Atlas-Mountains-Morocco.jpg'),
//               height: 100,
//             ),
//             const Padding(padding: EdgeInsets.only(top: 20)),
//             const Text(
//               'Agora Group Video Call Demo',
//               style: TextStyle(
//                   color: Colors.black,
//                   fontSize: 20,
//                   fontWeight: FontWeight.bold),
//             ),
//             const Padding(padding: EdgeInsets.symmetric(vertical: 20)),
//             SizedBox(
//               width: 300,
//               child: TextFormField(
//                 controller: myController,
//                 decoration: InputDecoration(
//                   labelText: 'Channel Name',
//                   labelStyle: const TextStyle(color: Colors.blue),
//                   hintText: 'test',
//                   hintStyle: const TextStyle(color: Colors.black45),
//                   errorText:
//                       _validateError ? 'Channel name is mandatory' : null,
//                   border: OutlineInputBorder(
//                     borderSide: const BorderSide(color: Colors.blue),
//                     borderRadius: BorderRadius.circular(20),
//                   ),
//                 ),
//               ),
//             ),
//             const Padding(padding: EdgeInsets.symmetric(vertical: 30)),
//             SizedBox(
//               width: 90,
//               child: MaterialButton(
//                 onPressed: onJoin,
//                 height: 40,
//                 color: Colors.blueAccent,
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: const <Widget>[
//                     Text('Join', style: TextStyle(color: Colors.white)),
//                     Icon(Icons.arrow_forward, color: Colors.white),
//                   ],
//                 ),
//               ),
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }
