import 'package:flutter/material.dart';
import 'package:sport_app_lct/widgets/button_primary.dart';
import 'package:sport_app_lct/widgets/custom_input.dart';
import 'package:sport_app_lct/widgets/custom_input_extendable.dart';
import 'package:sport_app_lct/widgets/header.dart';
import 'package:sport_app_lct/widgets/weight_slider.dart';

import '../../widgets/custom_input_age.dart';

class CoachEditProfile extends StatelessWidget {

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  final TextEditingController _achivementsController = TextEditingController();
  final TextEditingController _aboutYourselfController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.only(left: 20, right: 20, top: 48, bottom: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Header(text: "Редактировать профиль", textAlign: TextAlign.left,),

            CustomInput(
              controller: _nameController,
              isDescription: true,
              description: "Имя",
            ),

            CustomInputAge(
              controller: _ageController,
              isDescription: true,
              description: "Возраст",
            ),

            CustomInputExtendable(
              controller: _achivementsController,
              isDescription: true,
              description: "О себе",
            ),

            CustomInputExtendable(
              controller: _aboutYourselfController,
              isDescription: true,
              description: "Достижения",
            ),


            Spacer(),
            ButtonPrimary(
                text: "Сохранить",
                isFullWidth: true,
                onPress: (){
                  Navigator.pop(context);
                }
            )
          ],
        ),
      )
    );
  }
}
