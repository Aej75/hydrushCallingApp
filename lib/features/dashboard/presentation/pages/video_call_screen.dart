// import 'package:agora_uikit/agora_uikit.dart';
// import 'package:auto_route/auto_route.dart';
// import 'package:flutter/material.dart';
// import 'package:whatsapp/core/route/routes.gr.dart';

// class VideoCallScreen extends StatefulWidget {
//   const VideoCallScreen({super.key});

//   @override
//   State<VideoCallScreen> createState() => _VideoCallScreenState();
// }

// class _VideoCallScreenState extends State<VideoCallScreen> {
//   AgoraRtcEventHandlers ok = const AgoraRtcEventHandlers();

//   final AgoraClient _client = AgoraClient(
//     agoraConnectionData: AgoraConnectionData(
//         appId: '14516c184a5646e6a0c78f257a495fea',
//         channelName: 'hello',
//         tempToken:
//             '007eJxTYHj5ZWr3b2eZg4b2illn7ptuinBqc+PJ/9/Psa/1T/mT1P0KDIYmpoZmyYYWJommZiZmqWaJBsnmFmlGpuaJJpamaamJoVueJDcEMjIsKExkYmSAQBCflSEjNScnn4EBAMTAIQg='),
//   );

//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     _initAgora();
//   }

//   Future<void> _initAgora() async {
//     await _client.initialize();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         // automaticallyImplyLeading: false,
//         title: const Text('Video Call'),
//       ),
//       body: SafeArea(
//         child: Stack(
//           children: [
//             AgoraVideoViewer(
//               client: _client,
//               showNumberOfUsers: true,
//               // enableHostControls: true,
//             ),
//             AgoraVideoButtons(
//               onDisconnect: () => context.router.push(const ChatScreenRoute()),
//               client: _client,
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
