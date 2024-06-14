import 'package:flutter/material.dart';
import 'package:sport_app_lct/widgets/header.dart';

class CoachChatScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.only(left: 20, right: 20, top: 48, bottom: 24),
        child: Column(
          children: [
            Header(text: "Чаты"),
          ],
        ),
      )
    );
  }
}
