import 'package:flutter/material.dart';
import 'package:rive/rive.dart';
import 'package:sport_app_lct/screens/client/client_main_screen.dart';
import 'package:sport_app_lct/screens/coach/coach_chat_screen.dart';
import '../../models/chat.dart';
import '../../models/message.dart';
import '../../models/rive_model.dart';
import 'client_trains_screen.dart';
import 'client_profile_screen.dart';

const Color bottonNavBgColor = Color(0xFF17203A);

class ClientHomeScreen extends StatefulWidget {
  const ClientHomeScreen({super.key});

  @override
  State<ClientHomeScreen> createState() => _MainScreenState();
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
      artboard: "TIMER",
      stateMachineName: "TIMER_Interactivity"),
  RiveModel(
      src: "assets/animated_icons.riv",
      artboard: "USER",
      stateMachineName: "USER_Interactivity"),
];

class _MainScreenState extends State<ClientHomeScreen> {
  List<SMIBool> riveIconInputs = [];
  List<StateMachineController?> controllers = [];
  int selctedNavIndex = 1;

  final chats = [
    Chat(
      name: 'Alice',
      profileImageUrl: 'https://via.placeholder.com/50',
      messages: [
        Message(content: 'Hello!', timestamp: DateTime.now(), isRead: false, isMe: false),
      ],
      unreadCount: 1,
    ),
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

    final List<Widget> pages = [
      CoachChatScreen(chats: chats),
      ClientMainScreen(),
      const ClientTrainsScreen(),
      const ClientProfileScreen(),
    ];

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
                                  riveOnInIt(artboard, stateMachineName: riveIcon.stateMachineName);
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
