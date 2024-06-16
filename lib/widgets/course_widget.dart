import 'package:flutter/material.dart';
import 'package:sport_app_lct/models/course.dart';
import 'package:sport_app_lct/screens/courses/edit_course.dart';
import 'package:sport_app_lct/widgets/description.dart';
import 'package:sport_app_lct/widgets/header.dart';

class CourseWidget extends StatelessWidget {
  final Course course;
  final Color color;

  CourseWidget({required this.course, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.all(Radius.circular(12))
      ),
      child: Padding(
        padding: EdgeInsets.only(top: 12, bottom: 12, left: 16, right: 16),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset("assets/coach_photo.png", height: 40,),
                SizedBox(width: 8,),
                Text(
                  "Иван Иванов",
                  style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'GilroyMedium',
                      fontSize: 16
                  ),
                ),
                Spacer(),
                GestureDetector(
                  child: Image.asset("assets/edit.png", height: 24,),
                  onTap: (){
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => EditCourse(courseId: course.id!),
                      ),
                    );
                  },
                )
              ],
            ),
            SizedBox(height: 12,),
            Text(
              course.title,
              style: TextStyle(
                  color: Colors.white,
                  fontFamily: 'RussoOne',
                  fontSize: 24
              ),
            ),
            Spacer(),
            Row(
              children: [
                Image.asset("assets/user.png", height: 16,),
                SizedBox(width: 4,),
                Text(
                  course.participantsCount.toString(),
                  style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'GilroyRegular',
                    fontSize: 14,
                  ),
                ),

                SizedBox(width: 32,),

                Image.asset("assets/star.png", height: 16,),
                SizedBox(width: 4,),
                Text(
                  course.rating.toString(),
                  style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'GilroyRegular',
                    fontSize: 14,
                  ),
                ),

                SizedBox(width: 32,),

                Image.asset("assets/difficulty1.png", height: 16,),
                SizedBox(width: 4,),
                Text(
                  course.difficulty.toString(),
                  style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'GilroyRegular',
                    fontSize: 14,
                  ),
                ),

                SizedBox(width: 32,),

                Text(
                  course.classes.length.toString() + " занятий",
                  style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'GilroyRegular',
                    fontSize: 14,
                  ),
                ),

              ],
            ),
            SizedBox(height: 8,),
          ],
        ),
      )
    );
  }
}
