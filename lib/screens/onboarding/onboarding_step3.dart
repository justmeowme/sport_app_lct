import 'package:flutter/material.dart';
import 'package:sport_app_lct/screens/onboarding/onboarding_step4.dart';
import 'package:sport_app_lct/models/user.dart';

import '../../widgets/button_primary.dart';
import '../../widgets/form_widget.dart';
import '../../widgets/header.dart';
import '../../widgets/small_text.dart';

class OnboardingStep3 extends StatefulWidget {
  final User user;

  OnboardingStep3({required this.user});

  @override
  _OnboardingStep3State createState() => _OnboardingStep3State();
}

class _OnboardingStep3State extends State<OnboardingStep3> {

  String? _experience;

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

              SmallText(text: "3/4", textColor: Color(0xFFED6929),),

              SizedBox(height: 12),

              Header(text: "Ты занимался", textAlign: TextAlign.left,),
              Header(text: "спортом ранее?", textAlign: TextAlign.left,),

              SizedBox(height: 8),

              SmallText(text: "Это поможет определить сложность предлагаемых тренировок", textAlign: TextAlign.left,),

              SizedBox(height: 20),

              FormWidget(
                isMultiSelect: false,
                isHorizontal: false,
                items: [
                  {'icon': Icons.battery_1_bar, 'text': 'Нет, я новичок'},
                  {'icon': Icons.battery_3_bar, 'text': 'Немного занимался дома'},
                  {'icon': Icons.battery_5_bar, 'text': 'Ходил/хожу в зал'},
                  {'icon': Icons.battery_full, 'text': 'Я спортсмен'}
                ],
                onItemSelected: (index) {
                  setState(() {
                    _experience = index == 0 ? "Новичок" : index == 1 ? "Начинающий" : index == 2 ? "Продвинутый" : "Эксперт";
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
                      builder: (context) => OnboardingStep4(
                        user: widget.user.copyWith(
                            experience: _experience
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
