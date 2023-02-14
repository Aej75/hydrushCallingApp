import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:whatsapp/core/route/routes.gr.dart';
import 'package:whatsapp/features/dashboard/presentation/widgets/message_bubble.dart';
import 'package:whatsapp/features/dashboard/presentation/widgets/message_text_field.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chat'),
        actions: [
          IconButton(
              onPressed: () async {
                if (!await Permission.camera.status.isGranted ||
                    !await Permission.microphone.status.isGranted) {
                  await Permission.camera.request();
                  await Permission.microphone.request();
                  if (await Permission.camera.status.isGranted &&
                      await Permission.microphone.status.isGranted) {
                    // context.router.push(CallPageRoute());
                  }
                } else {
                  // context.router.push(CallPageRoute());
                }
              },
              icon: const Icon(CupertinoIcons.video_camera))
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.separated(
                padding: const EdgeInsets.only(bottom: 16),
                reverse: true,
                itemBuilder: (_, index) => _messages[index],
                separatorBuilder: (_, __) => const SizedBox(),
                itemCount: _messages.length),
          ),
          const MessageTextField()
        ],
      ),
    );
  }
}

const _messages = <MessageBubble>[
  MessageBubble(
    message: 'Hey how are you ......',
    date: 'Apr 22, 5:55 PM',
    profileImageUrl:
        'https://th.bing.com/th/id/OIP.2bJ9_f9aKoGCME7ZIff-ZwHaJ4?pid=ImgDet&rs=1',
  ),
  MessageBubble(
    message: 'Hey how are you ......',
    date: 'Apr 22, 5:55 PM',
  ),
  MessageBubble(
    message: 'Hey how are you ......',
    date: 'Apr 22, 5:55 PM',
    profileImageUrl:
        'https://th.bing.com/th/id/OIP.2bJ9_f9aKoGCME7ZIff-ZwHaJ4?pid=ImgDet&rs=1',
  ),
  MessageBubble(
    message: 'Hey how are you ......',
    date: 'Apr 22, 5:55 PM',
  ),
  MessageBubble(
    message: 'Hey how are you ......',
    date: 'Apr 22, 5:55 PM',
    profileImageUrl:
        'https://th.bing.com/th/id/OIP.2bJ9_f9aKoGCME7ZIff-ZwHaJ4?pid=ImgDet&rs=1',
  ),
  MessageBubble(
    message: 'Hey how are you ......',
    date: 'Apr 22, 5:55 PM',
  ),
  MessageBubble(
    message: 'Hey how are you ......',
    date: 'Apr 22, 5:55 PM',
    profileImageUrl:
        'https://th.bing.com/th/id/OIP.2bJ9_f9aKoGCME7ZIff-ZwHaJ4?pid=ImgDet&rs=1',
  ),
  MessageBubble(
    message: 'Hey how are you ......',
    date: 'Apr 22, 5:55 PM',
  ),
  MessageBubble(
    message: 'Hey how are you ......',
    date: 'Apr 22, 5:55 PM',
    profileImageUrl:
        'https://th.bing.com/th/id/OIP.2bJ9_f9aKoGCME7ZIff-ZwHaJ4?pid=ImgDet&rs=1',
  ),
  MessageBubble(
    message: 'Hey how are you ......',
    date: 'Apr 22, 5:55 PM',
  ),
  MessageBubble(
    message: 'Hey how are you ......',
    date: 'Apr 22, 5:55 PM',
    profileImageUrl:
        'https://th.bing.com/th/id/OIP.2bJ9_f9aKoGCME7ZIff-ZwHaJ4?pid=ImgDet&rs=1',
  ),
  MessageBubble(
    message: 'Hey how are you ......',
    date: 'Apr 22, 5:55 PM',
  )
];
