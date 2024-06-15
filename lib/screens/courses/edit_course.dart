import 'package:flutter/material.dart';
import 'package:sport_app_lct/models/course.dart';
import 'package:sport_app_lct/screens/courses/create_lesson.dart';
import 'package:sport_app_lct/widgets/button_primary.dart';
import 'package:sport_app_lct/widgets/custom_input.dart';
import 'package:sport_app_lct/widgets/custom_input_age.dart';
import 'package:sport_app_lct/widgets/header.dart';

class EditCourse extends StatelessWidget {
  final Course course;

  EditCourse({required this.course});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.only(bottom: 24, left: 20, right: 20, top: 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Image.asset("assets/back_button.png", height: 32),
                    ),
                    Spacer(),
                    Header(text: "Занятия", textAlign: TextAlign.left,),
                    SizedBox(width: 32,),
                    Spacer(),
                  ],
                ),

                
                
                Spacer(),
                ButtonPrimary(
                  text: "Добавить урок",
                  onPress: (){
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => CreateLesson(course: course),
                      ),
                    );
                  },
                  isFullWidth: true,
                ),
              ],
            ),
          )
        )
    );
  }
}
