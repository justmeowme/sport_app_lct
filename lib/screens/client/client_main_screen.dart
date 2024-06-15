// client_main_screen.dart
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sport_app_lct/screens/client/client_body_screen.dart';
import 'package:sport_app_lct/screens/client/client_stats_screen.dart';


class ClientMainScreen extends StatelessWidget {
  final PageController _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    final kToday = DateTime.now();

    return Scaffold(
      body: PageView(
        controller: _pageController,
        children: [
          ClientBodyScreen(),
          ClientStatsScreen(),
        ],
      ),
    );
  }
}
