import 'package:flutter/material.dart';
import 'package:sport_app_lct/screens/auth/login_screen.dart';
import 'package:sport_app_lct/screens/auth/register_screen.dart';
import 'package:sport_app_lct/widgets/button_primary.dart';
import 'package:sport_app_lct/widgets/button_secondary.dart';
import 'package:sport_app_lct/widgets/description.dart';

import '../../widgets/header.dart';

class StartScreen extends StatelessWidget {
  const StartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFFFFF),
      body: Column(
        children: [
          Image.asset("assets/start_image.png", width: MediaQuery.of(context).size.width, fit: BoxFit.contain,),
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
            child: Column(
              children: [
                Center(
                  child: Header(text: "Начни занятия спортом сегодня!"),
                ),
                const SizedBox(height: 12,),
                Center(
                  child: Description(text: "Курсы, тренировки, питание и многое другое в одном приложении"),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20,),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ButtonPrimary(
                text: "Вход",
                onPress: (){
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => LoginScreen(),
                    ),
                  );
                },
              ),
              ButtonSecondary(
                text: "Регистрация",
                onPress: (){
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => RegisterScreen(),
                    ),
                  );
                },
              )
            ],
          )
        ],
      )
    );
  }
}
