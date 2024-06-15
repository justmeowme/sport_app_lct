import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/chat.dart';

class ChatItem extends StatelessWidget {
  final Chat chat;
  final VoidCallback onTap;

  ChatItem({required this.chat, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final lastMessage = chat.messages.last;
    final time = DateFormat('HH:mm').format(lastMessage.timestamp);

    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
              child: Row(
                children: [
                  CircleAvatar(
                    backgroundImage: NetworkImage(chat.profileImageUrl),
                    radius: 25,
                  ),
                  SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          chat.name,
                          style: TextStyle(
                              fontSize: 16,
                              fontFamily: 'GilroyMedium',
                              fontWeight: FontWeight.bold
                          ),
                        ),
                        Text(
                          lastMessage.content,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              color: Color(0xFF9B9B9B),
                              fontFamily: 'GilroyMedium',
                              fontSize: 16
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: 12),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        time,
                        style: TextStyle(fontFamily: 'GilroyMedium', fontSize: 14),
                      ),
                      SizedBox(height: 4),
                      if (chat.unreadCount > 0)
                        CircleAvatar(
                          radius: 10,
                          backgroundColor: Color(0xFFED6929),
                          child: Text(
                            chat.unreadCount.toString(),
                            style: TextStyle(color: Colors.white, fontSize: 14),
                          ),
                        ),
                    ],
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 20, right: 20, top: 8),
              child: Divider(color: Color(0xFFD9D9D9), height: 1),
            )
          ],
        ),
      )
    );
  }
}
