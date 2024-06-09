import 'package:flutter/material.dart';
import 'package:sport_app_lct/screens/auth/login_screen.dart';
import 'package:sport_app_lct/screens/auth/register_screen.dart';
import 'package:sport_app_lct/widgets/button_primary.dart';
import 'package:sport_app_lct/widgets/button_secondary.dart';
import 'package:sport_app_lct/widgets/description.dart';

import '../../widgets/header.dart';

class StartScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFFFFFF),
        body: Column(
          children: [
            Image.asset("assets/start_image.png"),
            SizedBox(height: 20,),
            Center(
              child: Header(text: "Начни занятия спортом сегодня!"),
            ),
            Center(
              child: Description(text: "Курсы, тренировки, питание и многое другое в одном приложении"),
            ),
            SizedBox(height: 20,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ButtonPrimary(text: "Вход", onPress: (){
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                      builder: (context) => LoginScreen(),
                    ),
                  );
                },),
                ButtonSecondary(text: "Регистрация", onPress: (){
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                      builder: (context) => RegisterScreen(),
                    ),
                  );
                },)
              ],
            )
          ],

        )
    );
  }
}
