import 'package:flutter/material.dart';

import '../../models/chat.dart';
import '../../widgets/chat_item.dart';
import '../../widgets/header.dart';
import 'chat_details_screen.dart';

class CoachChatScreen extends StatelessWidget {
  final List<Chat> chats;

  CoachChatScreen({required this.chats});

  void _onChatTap(BuildContext context, Chat chat) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ChatDetailScreen(chat: chat),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(top: 0, left: 20),
              child: Header(text: "Чаты"),
            ),

            SizedBox(height: 12,),

            Container(
              height: MediaQuery.of(context).size.width,
              child: ListView.builder(
                itemCount: chats.length,
                itemBuilder: (context, index) {
                  final chat = chats[index];
                  return ChatItem(
                    chat: chat,
                    onTap: () => _onChatTap(context, chat),
                  );
                },
              ),
            )
          ],
        ),
      )
    );
  }
}
