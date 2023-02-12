import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:whatsapp/core/route/routes.gr.dart';
import 'package:whatsapp/features/dashboard/models/chat_page_model.dart';
import 'package:whatsapp/features/dashboard/presentation/widgets/chat_display_item.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        print('pressed');
        context.router.push(const ChatScreenRoute());
      },
      child: ChatDisplayItem(
        chatPageView: [
          ChatPageView(
              image:
                  'https://cdn.britannica.com/24/58624-050-73A7BF0B/valley-Atlas-Mountains-Morocco.jpg',
              title: 'Sayapatri Payments',
              message: '+977 9813716969: Hello Sir',
              time: '9:50 AM')
        ],
      ),
    );
  }
}
