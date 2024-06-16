import 'package:flutter/material.dart';
import 'package:sport_app_lct/screens/onboarding/onboarding_step3.dart';
import 'package:sport_app_lct/models/user.dart';
import '../../widgets/button_primary.dart';
import '../../widgets/form_widget.dart';
import '../../widgets/header.dart';
import '../../widgets/small_text.dart';

class OnboardingStep2 extends StatefulWidget {
  final User user;

  const OnboardingStep2({super.key, required this.user});

  @override
  OnboardingStep2State createState() => OnboardingStep2State();
}

class OnboardingStep2State extends State<OnboardingStep2> {
  String? _goals;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            const SizedBox(height: 44),

            SmallText(text: "2/4", textColor: const Color(0xFFED6929),),

            const SizedBox(height: 12),

            Header(text: "Каких результатов", textAlign: TextAlign.left,),
            Header(text: "ты хочешь достичь?", textAlign: TextAlign.left,),

            const SizedBox(height: 8),

            SmallText(text: "Твоя цель поможет нам рекомендовать тренеров и занятия", textAlign: TextAlign.left,),

            const SizedBox(height: 20),

            FormWidget(
              isMultiSelect: false,
              isHorizontal: false,
              items: const [
                {'icon': Icons.monitor_weight, 'text': 'Хочу похудеть'},
                {'icon': Icons.sports_martial_arts, 'text': 'Хочу накачаться'},
                {'icon': Icons.fitness_center, 'text': 'Хочу держать себя в форме'},
                {'icon': Icons.monitor_heart, 'text': 'Хочу улучшить здоровье'}
              ],
              onItemSelected: (index) {
                setState(() {
                  _goals = index == 0 ? "Похудеть" : index == 1 ? "Накачаться" : index == 2 ? "Держать себя в форме" : "Улучшить здоровье";
                });
              },
            ),

            const Spacer(),

            ButtonPrimary(
              text: "Далее",
              isFullWidth: true,
              onPress: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => OnboardingStep3(
                      user: widget.user.copyWith(
                        goals: _goals
                      ),
                    ),
                  ),
                );
              },
            ),

            const SizedBox(height: 12,),

            const Center(
              child: Text(
                "Пропустить знакомство",
                style: TextStyle(
                  color: Color(0xFFB9B8B8),
                  fontFamily: 'GilroyMedium',
                  fontSize: 18
                ),
              ),
            ),

            const SizedBox(height: 24,),
          ],
        ),
      )
    );
  }
}
