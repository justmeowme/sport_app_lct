import 'package:flutter/material.dart';
import '../../models/chat.dart';
import '../../widgets/chat_message.dart';

class ChatDetailScreen extends StatelessWidget {
  final Chat chat;

  const ChatDetailScreen({super.key, required this.chat});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF202439),
      body: SafeArea(
        child: Column(
          children: [
            Container(
              height: 70,
              color: const Color(0xFF202439),
              child: Row(
                children: [
                  const SizedBox(width: 12),
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Image.asset("assets/back_button.png", height: 32),
                  ),
                  const Spacer(),
                  Padding(
                    padding: const EdgeInsets.only(left: 24),
                    child: Center(
                      child: Text(
                        chat.name,
                        style: const TextStyle(
                          color: Colors.white,
                          fontFamily: 'RussoOne',
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ),
                  const Spacer(),
                  const Icon(Icons.video_call, color: Colors.white),
                  const SizedBox(width: 12),
                  const Icon(Icons.call, color: Colors.white),
                  const SizedBox(width: 12),
                ],
              ),
            ),
            Expanded(
              child: Container(
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("assets/wallpaper_chat.png"),
                    fit: BoxFit.cover,
                  ),
                ),
                child: ListView.builder(
                  itemCount: chat.messages.length,
                  itemBuilder: (context, index) {
                    final message = chat.messages[index];
                    return ChatMessage(
                      content: message.content,
                      timestamp: message.timestamp,
                      isMe: message.isMe,
                    );
                  },
                ),
              ),
            ),
            Container(
              color: Colors.white,
              padding: const EdgeInsets.only(bottom: 28, left: 12, right: 12),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: "Введите сообщение",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.send, color: Color(0xFF2D68FF)),
                    onPressed: () {
                      // message add logic
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
