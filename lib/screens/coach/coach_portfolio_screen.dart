import 'package:flutter/material.dart';
import 'package:sport_app_lct/screens/coach/coach_edit_profile.dart';
import 'package:sport_app_lct/widgets/header.dart';
import 'package:sport_app_lct/widgets/small_text.dart';

class CoachPortfolioScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.only(left: 20, right: 20, top: 48, bottom: 24),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Header(text: "Профиль"),
                  Spacer(),
                  GestureDetector(
                    child: Image.asset("assets/edit_orange.png", height: 32),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => CoachEditProfile()),
                      );
                    },
                  )
                ],
              ),
              SizedBox(height: 20),
              Stack(
                children: [
                  Image.asset(
                    "assets/coach_no_photo.png",
                    width: MediaQuery.of(context).size.width - 40,
                  ),
                  Positioned(
                    bottom: 10,
                    left: 10,
                    child: Text(
                      "Без Имени, 33",
                      style: TextStyle(
                        fontSize: 24,
                        fontFamily: 'GilroyMedium',
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 24,),

              SmallText(text: 'О себе', textColor: Color(0xFFED6929),),
              SmallText(text: 'Тренер с 10-летним стажем, делаю упор на результат', textAlign: TextAlign.left,),

              SizedBox(height: 12,),

              SmallText(text: 'Достижения', textColor: Color(0xFFED6929)),
              SmallText(text: 'Чемпион по плаванью в соревновании Армавир-2007', textAlign: TextAlign.left,),


              SizedBox(height: 80,),
            ],
          ),
        )
      ),
    );
  }
}
