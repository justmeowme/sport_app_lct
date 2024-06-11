import 'package:flutter/material.dart';
import 'package:sport_app_lct/screens/onboarding/onboarding_step2.dart';
import 'package:sport_app_lct/models/user.dart';
import 'package:sport_app_lct/widgets/button_primary.dart';
import 'package:sport_app_lct/widgets/form_widget.dart';
import 'package:sport_app_lct/widgets/header.dart';
import 'package:sport_app_lct/widgets/height_slider.dart';
import 'package:sport_app_lct/widgets/small_text.dart';
import 'package:sport_app_lct/widgets/weight_slider.dart';

class OnboardingStep1 extends StatefulWidget {
  final User user;

  OnboardingStep1({required this.user});

  @override
  _OnboardingStep1State createState() => _OnboardingStep1State();
}

class _OnboardingStep1State extends State<OnboardingStep1> {
  String? _gender = 'Male';
  int _height = 170;
  int? _weight;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.only(left: 20, right: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            SizedBox(height: 44),

            SmallText(text: "1/4", textColor: Color(0xFFED6929),),

            SizedBox(height: 12),

            Header(text: "Давай", textAlign: TextAlign.left,),
            Header(text: "познакомимся", textAlign: TextAlign.left,),

            SizedBox(height: 8),

            SmallText(text: "Чем больше информации ты укажешь, тем точнее мы подберем тренировки", textAlign: TextAlign.left,),

            SizedBox(height: 20),

            SmallText(text: "Выбери пол", weight: 1,),

            FormWidget(
              isMultiSelect: false,
              isHorizontal: true,
              items: [
                {'icon': Icons.male, 'text': 'Мужчина'},
                {'icon': Icons.female, 'text': 'Женщина'}
              ],
              onItemSelected: (index) {
                setState(() {
                  _gender = index == 0 ? 'Male' : 'Female';
                });
              },
            ),

            SizedBox(height: 20),

            SmallText(text: "Введи свой рост", weight: 1,),
            
            HeightSlider(
              onHeightChanged: (int newHeight) {
                setState(() {
                  _height = newHeight;
                });
              },
            ),

            SizedBox(height: 20),

            SmallText(text: "Введи свой вес", weight: 1,),

            WeightSlider(
              onWeightChanged: (int newWeight) {
                setState(() {
                  _weight = newWeight;
                });
              },
            ),

            Spacer(),
            
            ButtonPrimary(
              text: "Далее",
              isFullWidth: true,
              onPress: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => OnboardingStep2(
                      user: widget.user.copyWith(
                        gender: _gender,
                        height: _height,
                        weight: _weight,
                      ),
                    ),
                  ),
                );
              },
            ),

            SizedBox(height: 12,),

            Center(
              child: Text(
                "Пропустить знакомство",
                style: TextStyle(
                    color: Color(0xFFB9B8B8),
                    fontFamily: 'GilroyMedium',
                    fontSize: 18
                ),
              ),
            ),

            SizedBox(height: 24,),
          ],
        ),
      )
    );
  }
}
