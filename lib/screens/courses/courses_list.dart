import 'package:flutter/material.dart';
import 'package:sport_app_lct/models/course.dart';
import 'package:sport_app_lct/screens/coach/coach_home_screen.dart';
import 'package:sport_app_lct/screens/courses/create_course.dart';
import 'package:sport_app_lct/widgets/button_primary.dart';

import '../../widgets/course_widget.dart';
import '../../widgets/header.dart';
import '../coach/coach_main_screen.dart';

class CoursesList extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.only(top: 48, left: 20, right: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  child: Image.asset("assets/back_button.png", height: 44, width: 44,),
                  onTap: (){
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                        builder: (context) => CoachMainScreen(),
                      ),
                    );
                  },
                ),
                Spacer(),
                Center(
                  child: Header(text: "Ваши курсы",),
                ),
                Spacer(),
              ],
            ),
            Spacer(),
            // Center(
            //   child: Image.asset("assets/no_courses.png", width: MediaQuery.of(context).size.width / 3 * 2,),
            // ),
            CourseWidget(
              course: Course(
                id: 1,
                title: "Курс “Сделай сильные руки за месяц”",
                description: "Сильные руки - основа любой тренировки и еще какой-то текст, который почему-то должен здесь быть",
                rating: 4,
                trainerId: 12,
                participantsCount: 30,
                difficulty: "Средний",
                difficultyNumeric: 2,
                classes: [],
              ),
            ),
            Spacer(),
            ButtonPrimary(
                text: "Создать курс",
                onPress: (){
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                      builder: (context) => CreateCourse(),
                    ),
                  );
                },
                isFullWidth: true,
            ),
            SizedBox(height: 20,)
          ],

        ),
      )
    );
  }
}
