import 'package:flutter/material.dart';
import 'package:sport_app_lct/screens/client/client_body_screen.dart';
import 'package:sport_app_lct/screens/client/client_stats_screen.dart';

class ClientMainScreen extends StatelessWidget {
  final PageController _pageController = PageController();

  ClientMainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageController,
        children: [
          ClientBodyScreen(),
          const ClientStatsScreen(),
        ],
      ),
    );
  }
}
