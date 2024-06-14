import 'package:flutter/material.dart';
import 'package:rive/rive.dart';
import 'package:sport_app_lct/screens/coach/coach_portfolio_screen.dart';

import '../../models/rive_model.dart';
import 'coach_chat_screen.dart';
import 'coach_home_screen.dart';

const Color bottonNavBgColor = Color(0xFF17203A);

class CoachMainScreen extends StatefulWidget {
  const CoachMainScreen({super.key});

  @override
  State<CoachMainScreen> createState() => _MainScreenState();
}

List<RiveModel> bottomNavItems = [
  RiveModel(
      src: "assets/animated_icons.riv",
      artboard: "CHAT",
      stateMachineName: "CHAT_Interactivity"),
  RiveModel(
      src: "assets/animated_icons.riv",
      artboard: "HOME",
      stateMachineName: "HOME_interactivity"),
  RiveModel(
      src: "assets/animated_icons.riv",
      artboard: "USER",
      stateMachineName: "USER_Interactivity"),
];

class _MainScreenState extends State<CoachMainScreen> {
  List<SMIBool> riveIconInputs = [];
  List<StateMachineController?> controllers = [];
  int selctedNavIndex = 1;

  final List<Widget> pages = [
    CoachChatScreen(),
    CoachHomeScreen(),
    CoachPortfolioScreen(),
  ];

  void animateTheIcon(int index) {
    riveIconInputs[index].change(true);
    Future.delayed(
      const Duration(seconds: 1),
          () {
        riveIconInputs[index].change(false);
      },
    );
  }

  void riveOnInIt(Artboard artboard, {required String stateMachineName}) {
    StateMachineController? controller =
    StateMachineController.fromArtboard(artboard, stateMachineName);

    artboard.addController(controller!);
    controllers.add(controller);

    riveIconInputs.add(controller.findInput<bool>('active') as SMIBool);
  }

  @override
  void dispose() {
    for (var controller in controllers) {
      controller?.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          pages[selctedNavIndex],
          Positioned(
            left: 24,
            right: 24,
            bottom: 24,
            child: Container(
              padding: const EdgeInsets.only(left: 32, right: 32, top: 14, bottom: 14),
              decoration: BoxDecoration(
                color: bottonNavBgColor.withOpacity(1.0),
                borderRadius: const BorderRadius.all(Radius.circular(24)),
                boxShadow: [
                  BoxShadow(
                    color: bottonNavBgColor.withOpacity(0.3),
                    offset: const Offset(0, 20),
                    blurRadius: 20,
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: List.generate(
                  bottomNavItems.length,
                      (index) {
                    final riveIcon = bottomNavItems[index];
                    return GestureDetector(
                      onTap: () {
                        animateTheIcon(index);
                        Future.delayed(Duration.zero, () {
                          setState(() {
                            selctedNavIndex = index;
                          });
                        });
                      },
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          AnimatedBar(isActive: selctedNavIndex == index),
                          SizedBox(
                            height: 36,
                            width: 36,
                            child: Opacity(
                              opacity: selctedNavIndex == index ? 1 : 0.5,
                              child: RiveAnimation.asset(
                                riveIcon.src,
                                artboard: riveIcon.artboard,
                                onInit: (artboard) {
                                  riveOnInIt(artboard,
                                      stateMachineName: riveIcon.stateMachineName);
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class AnimatedBar extends StatelessWidget {
  const AnimatedBar({
    super.key,
    required this.isActive,
  });

  final bool isActive;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      margin: const EdgeInsets.only(bottom: 2),
      height: 4,
      width: isActive ? 20 : 0,
      decoration: const BoxDecoration(
        color: Color(0xFFED6929),
        borderRadius: BorderRadius.all(Radius.circular(12)),
      ),
    );
  }
}