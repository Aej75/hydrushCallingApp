import 'package:flutter/material.dart';

import '../../models/chat_page_model.dart';

class ChatDisplayItem extends StatelessWidget {
  final List<ChatPageView> chatPageView;
  const ChatDisplayItem({super.key, required this.chatPageView});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Column(
            children: chatPageView
                .map((e) => Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            CircleAvatar(
                                radius: 25,
                                backgroundImage: NetworkImage(e.image)),
                            const SizedBox(
                              width: 20,
                            ),
                            SizedBox(
                              height: 40,
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    e.title,
                                    style: const TextStyle(fontSize: 15),
                                  ),
                                  Text(
                                    e.message,
                                    style: TextStyle(
                                        fontSize: 13,
                                        color: Theme.of(context)
                                            .primaryColorLight),
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 5),
                          child: Text(
                            e.time,
                            style: TextStyle(
                                fontSize: 12,
                                color: Theme.of(context).primaryColorLight),
                          ),
                        )
                      ],
                    ))
                .toList()),
      ),
    );
  }
}
